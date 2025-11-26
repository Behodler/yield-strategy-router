# Consider Change Requests

Review and implement change requests from sibling submodules.

## Usage

Run: `.claude/commands/consider-change-requests.sh`

## Arguments

None required.

## Behavior

1. Checks for `SiblingChangeRequests.json` in the current directory
2. Displays the contents of pending change requests
3. Prompts for review and implementation using TDD principles

## Notes

- Change requests are placed in this file by the parent-level `pop-change-requests` command
- Each request should be implemented following Test-Driven Development
- If a request cannot be implemented, document the issue for the requesting submodule
- After implementation, the requesting submodule should run `update-mutable-dependency` to pull the changes
