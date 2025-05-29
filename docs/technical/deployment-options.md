---
layout: default
title: "Deployment Options"
parent: Technical
nav_order: 5
date: 2025-05-12
---

# Deploying Discourse on Rancher Kubernetes

This guide walks through the process of deploying Discourse on a Kubernetes cluster managed by Rancher.

## Overview

Discourse is a popular open-source forum and community platform. While Discourse doesn't officially support Kubernetes deployments, there are several viable approaches to run it on a Kubernetes cluster managed by Rancher.

From the research, there are three main approaches:
1. Using Bitnami's Helm chart
2. Building a custom Discourse image and deploying it manually 
3. Using community-contributed Kubernetes configuration files

## Prerequisites

- A running Rancher instance managing at least one Kubernetes cluster
- `kubectl` configured to interact with your cluster
- `helm` installed (if using the Helm chart approach)
- Access to a Docker registry where you can push custom images

## Option 1: Using Bitnami's Helm Chart (Recommended)

Bitnami provides a maintained Helm chart for Discourse that simplifies deployment.

### Step 1: Add the Bitnami Helm repository

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
```

### Step 2: Prepare a values.yaml file

Create a `discourse-values.yaml` file with your configuration:

```yaml
global:
  storageClass: "YOUR_STORAGE_CLASS"  # Set to a storage class available in your Rancher cluster

discourse:
  host: discourse.example.com  # Your domain
  username: admin
  password: "YOUR_ADMIN_PASSWORD"
  email: admin@example.com

postgresql:
  enabled: true
  auth:
    username: bn_discourse
    password: "YOUR_DB_PASSWORD"
    database: bitnami_discourse

redis:
  enabled: true
  auth:
    password: "YOUR_REDIS_PASSWORD"

persistence:
  enabled: true
  storageClass: "YOUR_STORAGE_CLASS"  # Same as global.storageClass
  size: 8Gi

ingress:
  enabled: true
  hostname: discourse.example.com
  annotations:
    kubernetes.io/ingress.class: nginx  # Adjust based on your ingress controller
  tls: true
```

### Step 3: Install Discourse using Helm

```bash
helm install discourse bitnami/discourse -f discourse-values.yaml -n discourse
```

Replace `-n discourse` with your preferred namespace.

## Option 2: Build Custom Discourse Image & Manual Deployment

If you need more customization, you can build a custom Discourse image.

### Step 1: Build the Discourse image locally

Clone the Discourse Docker repository:
```bash
git clone https://github.com/discourse/discourse_docker.git
cd discourse_docker
```

Create a configuration file for the build:
```bash
cp samples/standalone.yml containers/app.yml
```

Edit `containers/app.yml` with your configuration (set environment variables, plugins, etc.).

Build the image:
```bash
./launcher bootstrap app
./launcher rebuild app
```

### Step 2: Tag and push the image to your registry

```bash
docker tag local_discourse/app:latest YOUR_REGISTRY/discourse:VERSION
docker push YOUR_REGISTRY/discourse:VERSION
```

### Step 3: Create Kubernetes manifests

Create a namespace:
```bash
kubectl create namespace discourse
```

Create secrets for database credentials:
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: discourse-secrets
  namespace: discourse
type: Opaque
data:
  db-password: BASE64_ENCODED_PASSWORD
  redis-password: BASE64_ENCODED_PASSWORD
  admin-password: BASE64_ENCODED_PASSWORD
```

Create PostgreSQL deployment:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: discourse-postgresql
  namespace: discourse
spec:
  replicas: 1
  selector:
    matchLabels:
      app: discourse-postgresql
  template:
    metadata:
      labels:
        app: discourse-postgresql
    spec:
      containers:
      - name: postgresql
        image: postgres:13
        ports:
        - containerPort: 5432
        env:
        - name: POSTGRES_DB
          value: discourse
        - name: POSTGRES_USER
          value: discourse
        - name: POSTGRES_PASSWORD
          valueFrom:
            secretKeyRef:
              name: discourse-secrets
              key: db-password
        volumeMounts:
        - name: postgresql-data
          mountPath: /var/lib/postgresql/data
      volumes:
      - name: postgresql-data
        persistentVolumeClaim:
          claimName: postgresql-data
---
apiVersion: v1
kind: Service
metadata:
  name: discourse-postgresql
  namespace: discourse
spec:
  selector:
    app: discourse-postgresql
  ports:
  - port: 5432
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: postgresql-data
  namespace: discourse
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
```

Create Redis deployment:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: discourse-redis
  namespace: discourse
spec:
  replicas: 1
  selector:
    matchLabels:
      app: discourse-redis
  template:
    metadata:
      labels:
        app: discourse-redis
    spec:
      containers:
      - name: redis
        image: redis:6
        ports:
        - containerPort: 6379
        volumeMounts:
        - name: redis-data
          mountPath: /data
      volumes:
      - name: redis-data
        persistentVolumeClaim:
          claimName: redis-data
---
apiVersion: v1
kind: Service
metadata:
  name: discourse-redis
  namespace: discourse
spec:
  selector:
    app: discourse-redis
  ports:
  - port: 6379
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: redis-data
  namespace: discourse
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
```

Create Discourse deployment:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: discourse
  namespace: discourse
spec:
  replicas: 1
  selector:
    matchLabels:
      app: discourse
  template:
    metadata:
      labels:
        app: discourse
    spec:
      containers:
      - name: discourse
        image: YOUR_REGISTRY/discourse:VERSION
        ports:
        - containerPort: 80
        env:
        - name: DISCOURSE_DB_HOST
          value: discourse-postgresql
        - name: DISCOURSE_DB_NAME
          value: discourse
        - name: DISCOURSE_DB_USERNAME
          value: discourse
        - name: DISCOURSE_DB_PASSWORD
          valueFrom:
            secretKeyRef:
              name: discourse-secrets
              key: db-password
        - name: DISCOURSE_REDIS_HOST
          value: discourse-redis
        - name: DISCOURSE_HOSTNAME
          value: discourse.example.com
        volumeMounts:
        - name: discourse-data
          mountPath: /shared
      volumes:
      - name: discourse-data
        persistentVolumeClaim:
          claimName: discourse-data
---
apiVersion: v1
kind: Service
metadata:
  name: discourse
  namespace: discourse
spec:
  selector:
    app: discourse
  ports:
  - port: 80
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: discourse-data
  namespace: discourse
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: discourse
  namespace: discourse
  annotations:
    kubernetes.io/ingress.class: nginx
spec:
  rules:
  - host: discourse.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: discourse
            port:
              number: 80
  tls:
  - hosts:
    - discourse.example.com
    secretName: discourse-tls
```

### Step 4: Apply the manifests to your Rancher-managed cluster

```bash
kubectl apply -f postgresql.yaml
kubectl apply -f redis.yaml
kubectl apply -f discourse.yaml
```

## Option 3: Using Community Contributed Resources

Check out the [discourse-k8s](https://github.com/oursky/discourse-k8s) GitHub repository, which provides sample configuration files for deploying Discourse on Kubernetes.

## Post-Deployment Configuration

1. Access your Discourse instance at the configured URL
2. Log in using the admin credentials set during deployment
3. Complete the initial setup wizard
4. Install any additional plugins or themes as needed

## Troubleshooting

### Check pod status
```bash
kubectl get pods -n discourse
```

### View logs
```bash
kubectl logs -n discourse deployment/discourse
```

### Access container for debugging
```bash
kubectl exec -it -n discourse deploy/discourse -- /bin/bash
```

## Limitations and Considerations

- The official Discourse team does not officially support Kubernetes deployments
- Updates require rebuilding and pushing new images
- Backups and restore may require custom procedures in a Kubernetes environment
- For production use, consider setting up proper monitoring and alerting

## Resources

- [Bitnami Discourse Helm Chart](https://artifacthub.io/packages/helm/bitnami/discourse)
- [Discourse Docker Repository](https://github.com/discourse/discourse_docker)
- [Discourse K8s Sample Files](https://github.com/oursky/discourse-k8s)
- [Rancher Kubernetes Documentation](https://ranchermanager.docs.rancher.com/how-to-guides/new-user-guides/kubernetes-clusters-in-rancher-setup)