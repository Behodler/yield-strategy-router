# Update Mutable Dependency

Pull the latest changes for an existing mutable dependency and refresh the interfaces.

## Usage

Run: `.claude/commands/update-mutable-dependency.sh $ARGUMENTS`

## Arguments

- `dependency-name` (required): The name of the mutable dependency to update (directory name in `lib/mutable/`)

## Behavior

1. Reverts any local changes in the dependency
2. Pulls the latest changes from the remote repository
3. Validates that the interfaces directory still exists
4. Removes all implementation files, keeping only interfaces

## Notes

- Use this after a sibling submodule has implemented your change requests
- The dependency must already exist in `lib/mutable/`
- Local modifications will be lost during the update
