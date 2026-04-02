---
name: commit
description: Generate a commit message from staged changes and commit.
allowed-tools: Bash(git diff:*), Bash(git status:*), Bash(git log:*), Bash(git commit:*)
argument-hint: "[optional: e.g., 'closes #123', 'breaking change', or any extra context]"
---

# Commit Message Generator

## Steps

1. **Check staged changes exist**
   Run `git status` to confirm there are staged changes. If nothing is staged, let the user know and suggest files to stage.

2. **Analyze the diff**
   First run `git diff --cached --stat` to get an overview of changed files and their magnitude.
   - If the diff is small (roughly fewer than 10 files and under 500 lines total), run `git diff --cached` to review all changes in detail.
   - If the diff is large, selectively run `git diff --cached -- <file>` on the most important files to understand the nature of the changes without overwhelming context.

   For each change, understand:
   - Which files were added, modified, or deleted
   - The nature of each change (bug fix, feature, refactor, docs, test, chore, style, etc.)

   **If the staged changes clearly contain multiple unrelated purposes** (e.g., a bug fix mixed with a refactor, or a new feature bundled with doc updates), suggest splitting into separate commits before proceeding. Explain which changes belong together and offer to help unstage files with `git reset HEAD <file>`.

3. **Check recent commit history for consistency**
   Run `git log --oneline -10` to review the project's existing commit style. Note:
   - Whether the project uses Conventional Commits
   - Capitalization preference for the description (lowercase vs. uppercase start)
   - Common scope names used in the project
   - Any project-specific conventions

   **Follow the project's existing style when it conflicts with the defaults below.**

4. **Generate a commit message**
   Based on the analysis, propose a commit message following the **Conventional Commits v1.0.0** specification.

   If `$ARGUMENTS` is provided (e.g., ticket numbers, change reasons, breaking change notes), incorporate it into the appropriate part of the message:
   - Ticket/issue numbers → footer (`Closes #123`)
   - Change reasons or context → body
   - Breaking change notes → `!` suffix on type and `BREAKING CHANGE:` footer

## Commit Message Format (Conventional Commits)

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Structure Rules

- **type** (required): one of `feat`, `fix`, `refactor`, `docs`, `test`, `chore`, `style`, `perf`, `ci`, `build`
  - `feat` → SemVer MINOR, `fix` → SemVer PATCH
- **scope** (optional): the module or area affected in parentheses (e.g., `auth`, `api`, `ui`). Omit if unclear.
- **description** (required): imperative mood, lowercase start (unless project convention differs), no period at end, max 50 characters
- **`!`** after type/scope indicates a breaking change: e.g., `feat(api)!: remove v1 endpoints`
- The entire first line (type + scope + description) must fit in 72 characters

### Body Rules

- Separate from first line with one blank line
- Wrap at 72 characters per line
- Explain **what** changed and **why**, not how
- Use `- ` bullet points when listing multiple changes
- Body is optional for trivial single-purpose changes

### Footer Rules

- `BREAKING CHANGE: <description>` for breaking changes (correlates with SemVer MAJOR)
- Issue references: `Closes #123`, `Fixes #456`
- Other git trailers: `Reviewed-by:`, `Refs:`, etc.

### Examples

Simple change:

```
fix(auth): prevent duplicate session on token refresh
```

Feature with body and footer:

```
feat(api): add rate limiting to public endpoints

- Add token bucket algorithm with configurable burst size
- Return 429 with Retry-After header when limit exceeded
- Apply stricter limits to unauthenticated requests

Closes #342
```

Breaking change:

```
feat(config)!: change env variable naming convention

Rename all env vars from MYAPP_* to APP_* for consistency.

BREAKING CHANGE: existing env variables must be renamed
```

5. **Present and confirm**
   Show the proposed message to the user. If approved, execute the commit:
   - **Single-line message**: `git commit -m "type(scope): description"`
   - **Multi-line message**: use separate `-m` flags for each paragraph:
     ```
     git commit -m "type(scope): description" -m "body paragraph" -m "footer"
     ```
     If the user wants changes, revise and confirm again.
