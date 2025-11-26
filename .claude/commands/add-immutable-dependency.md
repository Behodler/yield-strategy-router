# Add Immutable Dependency

Add an external library as an immutable dependency with full source code access.

## Usage

Run: `.claude/commands/add-immutable-dependency.sh $ARGUMENTS`

## Arguments

- `repository` (required): The git repository URL or path for the external library

## Behavior

1. Clones the repository to `lib/immutable/`
2. Full source code is preserved and available

## Notes

- Use this for external libraries like OpenZeppelin, Solmate, etc.
- Unlike mutable dependencies, full source code is available
- These dependencies don't change based on sibling requirements
