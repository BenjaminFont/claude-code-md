---
description: Executes multiple review cycles and amalgamates the results
model: claude-opus-4-1
---

## Variables
CHANGE_REQUEST: $ARGUMENT0 - IMPORTANT: if not specified stop and ask for a change request description

## Workflow
1. Launch Task agent: execute `commands/workflow/review.md` with "[CHANGE_REQUEST]" "review/review1.md"
2. Launch Task agent: execute `commands/workflow/evaluate.md` with "review/review1.md" "[CHANGE_REQUEST]" "review/evaluation1.md"
3. Launch Task agent: execute `commands/workflow/conclude.md` with "[CHANGE_REQUEST]" "review/review1.md" "review/evaluation1.md" "review/conclusion1.md"
4. Process sequentially (not parallel) to avoid git conflicts.

## Output
Short summary of all processing and the paths to generated files.