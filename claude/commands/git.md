# Git Commands

## commit-msg

Analyze staged changes and generate commit message

```bash
if git diff --staged --quiet; then
  echo "No staged changes found. Please stage your changes first with 'git add'."
  exit 1
fi

git diff --staged -U20 | claude -p 'Analyze these staged git changes and generate a commit message following conventional commit format (type(scope): description).

Requirements:
- Use appropriate type (feat, fix, refactor, docs, style, test, chore)
- Include scope if applicable (component/module name)
- Keep description under 50 characters
- Provide only the commit message, no explanation

Context: This is a collaborative project, so the message should be clear to other developers.'
```
