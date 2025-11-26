# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Submodule: YieldStrategyRouter

This is a Foundry smart contract submodule for the YieldStrategyRouter contract.

## Project Purpose

The YieldStrategyRouter serves as a **registry contract** for yield strategies, analogous to Uniswap's factory contract for retrieving and registering pairs. Instead of token pairs, this router maps **underlying tokens to yield strategies**.

### Core Functionality

- **Token-to-Strategy Mapping**: Provides a 1:1 mapping between underlying tokens and their corresponding yield strategies
  - Example: Dola token address → AutoDolaYieldStrategy
- **Owner-Controlled Registration**: Only the contract owner can register new mappings
- **Strategy Lookup**: Downstream consumers can query the router to find the appropriate yield strategy for any registered underlying token

### Architecture

```
┌─────────────────────┐
│  Downstream Consumer│
└─────────┬───────────┘
          │ getStrategy(underlyingToken)
          ▼
┌─────────────────────┐
│ YieldStrategyRouter │  ← Owner registers mappings
└─────────┬───────────┘
          │ returns
          ▼
┌─────────────────────┐
│   AYieldStrategy    │  ← Abstract contract from vault dependency
└─────────────────────┘
```

### Relationship to Dependencies

- **vault (mutable dependency)**: Provides the `AYieldStrategy` abstract contract that all registered yield strategies must inherit from
- The router stores and returns references to contracts that implement `AYieldStrategy`

## Dependency Management

### Types of Dependencies

1. **Immutable Dependencies** (lib/immutable/)
   - External libraries and contracts that don't change based on sibling requirements
   - Full source code is available
   - Examples: OpenZeppelin, standard libraries

2. **Mutable Dependencies** (lib/mutable/)
   - Dependencies from sibling submodules
   - ONLY interfaces and abstract contracts are exposed
   - NO implementation details are available
   - Changes to these dependencies must go through the change request process

### Important Rules

- **NEVER** access implementation details of mutable dependencies
- Mutable dependencies only expose interfaces and abstract contracts
- If a feature requires changes to a mutable dependency, add it to the change request queue
- All development must follow Test-Driven Development (TDD) principles using Foundry

### Change Request Process

When a feature requires changes to a mutable dependency:

1. Add the request to `MutableChangeRequests.json` with format:
   ```json
   {
     "requests": [
       {
         "dependency": "dependency-name",
         "changes": [
           {
             "fileName": "ISomeInterface.sol",
             "description": "Plain language description of what needs to change"
           }
         ]
       }
     ]
   }
   ```

2. **STOP WORK** immediately after adding the change request
3. Inform the user that dependency changes are needed
4. Wait for the dependency to be updated before continuing

### Available Commands

- `.claude/commands/add-mutable-dependency.sh <repo>` - Add a mutable dependency (sibling)
- `.claude/commands/add-immutable-dependency.sh <repo>` - Add an immutable dependency
- `.claude/commands/update-mutable-dependency.sh <name>` - Update a mutable dependency
- `.claude/commands/consider-change-requests.sh` - Review and implement sibling change requests

## Project Structure

- `src/` - Solidity source files
- `test/` - Test files (TDD required)
- `script/` - Deployment scripts
- `lib/mutable/` - Mutable dependencies (interfaces only)
- `lib/immutable/` - Immutable dependencies (full source)

## Development Guidelines

### Test-Driven Development (TDD)

**ALL** features, bug fixes, and modifications MUST follow TDD principles:

1. **Write tests first** - Before implementing any feature
2. **Red phase** - Write failing tests that define the expected behavior
3. **Green phase** - Write minimal code to make tests pass
4. **Refactor phase** - Improve code while keeping tests green

### Testing Commands

- `forge test` - Run all tests
- `forge test -vvv` - Run tests with verbose output
- `forge test --match-contract <ContractName>` - Run specific contract tests
- `forge test --match-test <testName>` - Run specific test
- `forge coverage` - Check test coverage

### Other Commands

- `forge build` - Compile contracts
- `forge fmt` - Format Solidity code
- `forge snapshot` - Generate gas snapshots

## Important Reminders

- This submodule operates independently from sibling submodules
- Follow Solidity best practices and naming conventions
- Use Foundry testing tools exclusively (no Hardhat or Truffle)
- If you need to change a mutable dependency, use the change request process
