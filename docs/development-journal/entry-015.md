---
layout: default
title: "Journal Entry #15"
parent: Development Journal
nav_order: [REVERSE_CHRONOLOGICAL_ORDER]
date: 2025-05-07
---

# Journal Entry #15 - Refactoring ConnectionService for Immutability
{: .no_toc }

**Date:** May 7, 2025
{: .fs-5 }

<details open markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

## Current Status

Successfully refactored the ConnectionService to use immutable patterns for data handling, further improving our codebase quality in preparation for building the connection UI components. All tests continue to pass, demonstrating the non-breaking nature of this change.

## Accomplishments

- Refactored ConnectionService to follow immutable patterns
- Replaced in-place array modifications with immutable alternatives
- Added defensive copying when returning objects from service methods
- Ensured consistent immutable approach across all service operations
- Maintained API compatibility while improving implementation
- Preserved all test functionality with no changes needed
- Enhanced code maintainability and predictability

## Implementation Approach

### Phase 1: Identifying Mutation Points

I began by analyzing the ConnectionService implementation to identify all places where data was being mutated:

- `saveConnection()` - Used `connections.push(connection)` to modify arrays in place
- `acceptConnection()` - Directly modified connection objects with `connections[connectionIndex].status = ConnectionStatus.ACTIVE`
- `loadConnections()` - Returned filtered objects without creating new copies
- `getConnectionById()` - Returned direct references to stored objects

### Phase 2: Implementing Immutability

I systematically replaced all mutation operations with immutable alternatives:

1. **For `getConnectionById()`**:
   - Added spread operator to return a copy of the found connection instead of the direct reference:
   ```typescript
   return Result.success({...connection});
   ```

2. **For `acceptConnection()`**:
   - Replaced direct object modification with `map()` to create a new array:
   ```typescript
   const updatedConnections = connections.map((conn, index) => {
     if (index === connectionIndex) {
       // Create a new connection object with updated status
       return {
         ...conn,
         status: ConnectionStatus.ACTIVE
       };
     }
     return conn; // Return the original for other connections
   });
   ```

3. **For `saveConnection()`**:
   - Replaced array mutation with spread operator:
   ```typescript
   // Instead of: connections.push(connection)
   const updatedConnections = [...connections, connection];
   ```

4. **For `getConnectionsByStatus()`**:
   - Added mapping to ensure each returned object is a new copy:
   ```typescript
   const filteredConnections = connections
     .filter(conn => conn.status === status)
     .map(conn => ({...conn}));
   ```

5. **For `loadConnections()`**:
   - Added mapping to create copies of all loaded connections:
   ```typescript
   const validConnections = parsedData
     .filter(item => this.isValidConnectionData(item))
     .map(item => ({...item}));
   ```

### Phase 3: Verification

After implementing these changes, I ran the existing test suite to verify that:
- All tests still pass without modification
- The behavior of the service remains consistent
- No regressions were introduced by the immutability changes

## Challenges

### Challenge 1: Balancing Immutability and Performance

**Description:** Implementing immutability introduces some overhead in terms of object creation and memory usage, which needed to be balanced against the benefits.

**Resolution:**
- Focused immutability on key areas with the most impact
- Applied defensive copying strategically at API boundaries
- Ensured that components receiving data can't accidentally modify service state
- Accepted the slight performance trade-off for improved maintainability
- Determined that for our expected data volume, the overhead is negligible

### Challenge 2: Maintaining Test Compatibility

**Description:** Ensuring that existing tests continue to pass after changing internal implementation details was essential.

**Resolution:**
- Preserved the public API contract of all methods
- Added immutability without changing the Result pattern implementation
- Verified that test assertions still work correctly with copied objects
- Ensured that object identity comparisons weren't being used in tests
- Ran the full test suite multiple times to verify consistent results

## Decisions

### Decision 1: Apply Immutability Consistently Throughout the Service

**Context:** Needed to decide whether to apply immutability everywhere or just in select critical areas.

**Options Considered:**
- Apply immutability only to public-facing methods
- Apply immutability only to write operations
- Apply immutability selectively based on complexity
- Apply immutability consistently throughout all methods

**Decision:** Applied immutability consistently throughout all service methods.

**Rationale:**
- Consistency makes the code more predictable and easier to maintain
- Prevents accidental mutations from creeping back in during future changes
- Establishes a clear pattern for other developers to follow
- Reduces cognitive load by standardizing on one approach
- Sets a good precedent for future services and components
- Aligns with functional programming principles we've been adopting

### Decision 2: Use Spread Operator for Object Copying

**Context:** Needed to choose a method for creating immutable copies of objects.

**Options Considered:**
- Deep cloning with JSON.parse/stringify
- Using Object.assign() for shallow copies
- Using a dedicated immutability library like Immer
- Using the spread operator for concise shallow copies

**Decision:** Used the spread operator for creating object copies.

**Rationale:**
- Provides concise, readable syntax for creating copies
- Suitable for our simple data structures that don't require deep cloning
- Consistent with modern JavaScript/TypeScript practices
- Works well with TypeScript's type system
- Avoids adding external dependencies
- Performs better than alternatives like JSON serialization

## Next Actions

1. Apply similar immutability patterns to the PlayerStorageService
2. Begin designing connection UI components with immutability in mind
3. Implement immutable state management in the upcoming UI components
4. Add immutability best practices to our development guidelines
5. Evaluate whether we need a more robust immutability solution for complex data structures

## References & Resources

- [Immutability in JavaScript](https://developer.mozilla.org/en-US/docs/Glossary/Immutable)
- [Working with Immutable State in React](https://beta.reactjs.org/learn/updating-objects-in-state)
- [JavaScript Array Methods for Immutability](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/map)
- [Spread Syntax in JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Spread_syntax)
- [Object Spread vs Object.assign()](https://thecodebarbarian.com/object-assign-vs-object-spread.html)

---

**Hours Logged:** 1.5

**Tags:** #immutability #refactoring #functional-programming #performance-optimization #defensive-copying