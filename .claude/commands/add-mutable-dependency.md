# Add Mutable Dependency

Add a sibling submodule as a mutable dependency. Only interfaces from the dependency will be preserved - all implementation details are removed.

## Usage

Run: `.claude/commands/add-mutable-dependency.sh $ARGUMENTS`

## Arguments

- `repository` (required): The git repository URL or path for the sibling submodule

## Behavior

1. Clones the repository to `lib/mutable/`
2. Validates that an `src/interfaces/` directory exists
3. Removes all implementation files, keeping only the interfaces directory
4. Reports success or failure

## Notes

- Mutable dependencies expose only interfaces and abstract contracts
- If the dependency has no interfaces directory, the operation fails
- Use the change request process if you need modifications to the dependency's interfaces
