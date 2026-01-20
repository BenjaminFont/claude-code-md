---
description: Evaluate a code review against project goals (called by other commands)
---

## Variables
REVIEW-FILE: $ARGUMENT0 - IMPORTANT: if not provided stop and ask for the review file path
CONTEXT: $ARGUMENT1 - IMPORTANT: if not provided stop and ask for the original change context
OUTPUT-FILE: $ARGUMENT2 or "review/evaluation.md" if not specified

## Workflow
1. Read the review from [REVIEW-FILE].
2. Consider the original change described in [CONTEXT].
3. Critically evaluate: Are the recommendations valid considering project goals?
4. Justify your reasoning for each point.
5. Save your evaluation to [OUTPUT-FILE].

## Output
Report only the file name back to the calling agent.