# Git Commit Message Generator

## Context

- Current git status: !`git status`
- Staged changes: !`git diff --staged -U5`
- Current branch: !`git branch --show-current`

## Task

Analyze the staged git changes and generate a complete commit message following conventional commit format.

## Requirements

- Use appropriate type (feat, fix, refactor, docs, style, test, chore)
- Include scope if applicable (component/module name)
- Keep subject line under 50 characters
- Follow Git commit message format:

  ```
  type(scope): description

  detailed description
  ```

## Output Format

1. **Generated commit message** in the format:

   ```
   type(scope): description

   detailed description
   ```

2. **Ask for confirmation**: "Commit with this message? (y/N)"

3. **If yes**: Execute the commit
   **If no**: Display the message for manual use

- **Subject line**: `type(scope): description` (under 50 chars)
- **Empty line**
- **Body**: Detailed explanation of what was changed and why
  - Explain the motivation for the change
  - Contrast with previous behavior if relevant
  - Include any breaking changes or migration notes

## Example

```
feat(auth): add OAuth2 integration

Integrate Google OAuth2 for user authentication to replace
the custom login system. This provides better security and
user experience.

- Add OAuth2 configuration and endpoints
- Update user model to store provider information
- Migrate existing users to new authentication flow
```

## Workflow

1. Analyze the staged changes using the context information
2. Generate an appropriate commit message
3. Show the generated message to the user
4. Ask for confirmation before committing
5. If confirmed, execute `git commit -m "generated message"`

## Note

This is for a collaborative project, so the message should be clear to other developers.
