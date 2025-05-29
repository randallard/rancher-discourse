---
layout: page
title: Private Group Discussions
nav_order: 2
permalink: /docs/private-groups/
---

# Discourse Private Group Discussions Setup Guide

## Overview
This guide will help you set up three test groups with different privacy levels:
- **Group A**: Hidden private category, invitation-only membership
- **Group B**: Hidden private category, invitation-only membership  
- **Group C**: Visible but locked category, request-to-join membership

## Step 1: Create User Groups

### Creating Group A (Invitation-Only, Hidden)
1. Go to **Admin Panel** → **Groups** → **New Group**
2. Fill in the details:
   - **Name**: `group-a`
   - **Full Name**: `Group A`
   - **Bio**: Brief description of the group's purpose
   - **Visibility**: Select **Group members only**
   - **Membership**: Select **Invitation only**
   - **Default notification level**: Set to **Watching** (recommended for active groups)
3. Click **Save**

### Creating Group B (Invitation-Only, Hidden)
1. Repeat the same process as Group A:
   - **Name**: `group-b`
   - **Full Name**: `Group B`
   - **Visibility**: **Group members only**
   - **Membership**: **Invitation only**
3. Click **Save**

### Creating Group C (Request-to-Join, Visible)
1. Create the group with these settings:
   - **Name**: `group-c`
   - **Full Name**: `Group C`
   - **Bio**: Description explaining the group's purpose
   - **Visibility**: Select **Public** (so others can see it exists)
   - **Membership**: Select **Request to join**
   - **Allow membership requests**: ✅ Checked
3. Click **Save**

## Step 2: Add Initial Members to Groups

### For Groups A and B (Invitation-Only):
1. Go to the group page (**Admin** → **Groups** → select your group)
2. Click the **Members** tab
3. Click **Add Members**
4. Type usernames or email addresses of your 2-3 demo users
5. Click **Add** - they'll be immediately added to the group

### For Group C (Request-to-Join):
**Option 1: Add initial members manually (for demo)**
- Same process as Groups A and B above

**Option 2: Have users request to join (realistic demonstration)**
1. Share the group URL with your demo users: `yoursite.com/g/group-c`
2. Users click **Request to Join**
3. As group owner, you'll get notifications to approve requests
4. Go to **Groups** → **Group C** → **Requests** tab to approve

## Step 3: Create Private Categories

### Creating Categories for Groups A and B (Hidden)
1. Go to **Admin Panel** → **Categories** → **New Category**
2. For Group A category:
   - **Category Name**: `Group A Discussions`
   - **Slug**: `group-a-discussions`
   - **Description**: Brief description of what this category is for
   - **Parent Category**: Leave blank (or choose existing parent if desired)

3. **Security Settings** (Most Important):
   - Remove **everyone** from all permission levels
   - Add **group-a** group with these permissions:
     - **Create/Reply/See**: ✅ Checked
     - **Full access** can be left unchecked for equal member rights
   - Add **staff** group with **Full access** (so admins can moderate)

4. **Settings Tab**:
   - **Default view**: Choose your preferred layout
   - **Default sort order**: Latest or your preference
   - Check **Suppress category definition on homepage** (keeps it more hidden)

5. Click **Save Category**

6. Repeat the exact same process for Group B, but use `group-b` group permissions instead

### Creating Category for Group C (Visible but Locked)
1. Create new category:
   - **Category Name**: `Group C Discussions`
   - **Slug**: `group-c-discussions`
   - **Description**: Clear description since others will see this

2. **Security Settings**:
   - **everyone** should have **See** permission only
   - Add **group-c** with **Create/Reply/See** permissions
   - Add **staff** with **Full access**

3. **Don't** check "Suppress category definition" since this should be visible

4. Click **Save Category**

## Step 4: Testing Your Setup

### Test Group A and B (Hidden Categories):
1. Log in as a non-member user
2. Verify you cannot see the categories in the category list
3. Try accessing the category directly via URL - should get permission error
4. Log in as a group member
5. Verify you can see and post in the category

### Test Group C (Visible but Locked):
1. Log in as a non-member user
2. Verify you can see the category name and description
3. Try to enter - should see "You are not permitted to view the requested resource"
4. Test the "Request to Join" workflow

## Adding Members at Scale (Future Planning)

### For Invitation-Only Groups (A & B):
- **Bulk CSV Import**: Admin Panel → Groups → [Group Name] → Bulk Add via CSV
- **API Integration**: Use Discourse API to programmatically add members
- **SSO Integration**: Auto-assign groups based on external system roles

### For Request-to-Join Groups (C):
- **Auto-approval rules**: Set up trust level requirements
- **Moderated queue**: Designate group moderators to handle requests
- **Integration workflows**: Connect with forms or external systems

## Advanced Moderation Options

If you want only group owners/moderators to have special permissions:

### Option 1: Category-Level Moderation
1. In category security settings, create two permission levels:
   - Regular group members: **Create/Reply/See** only  
   - Group moderators: **Full access** (includes pin, close, moderate)
2. Create a separate "moderator" group (e.g., `group-a-mods`)
3. Add only designated moderators to this group

### Option 2: Trust Level Requirements  
1. Set category permissions to require higher trust levels for moderation actions
2. Manually promote group moderators to appropriate trust levels
3. Regular posting remains available to all group members

### Option 3: Group-Specific Moderators
1. In the group settings, designate specific users as "Group Owners"
2. Group owners automatically get enhanced permissions within group contexts
3. They can manage membership and have moderation capabilities

## Troubleshooting Common Issues

**Categories still visible to non-members:**
- Double-check that "everyone" permissions are completely removed
- Verify group membership is correctly set
- Clear any caching (Admin → Logs → Staff Action Logs)

**Members can't see their private categories:**
- Confirm users are actually added to the correct groups
- Check that group visibility settings aren't too restrictive
- Verify category permissions include the correct group names

**Request-to-join not working:**
- Ensure "Allow membership requests" is checked in group settings
- Verify group visibility is set to "Public" 
- Check that group owners have notification preferences set up

## Next Steps for Your Demo

1. Create all three groups with the settings above
2. Add your 2-3 demo users to each group
3. Create the three corresponding categories
4. Test each scenario with different user accounts
5. Document any specific workflows for your organization's needs

This setup gives you a comprehensive demonstration of Discourse's private group capabilities while planning for future scale.