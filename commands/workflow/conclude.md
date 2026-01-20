---
description: Conclude the best path forward from review and evaluation (called by other commands)
---

## Variables
CONTEXT: $ARGUMENT0 - IMPORTANT: if not provided stop and ask for the original change context
REVIEW-FILE: $ARGUMENT1 - IMPORTANT: if not provided stop and ask for the review file path
EVALUATION-FILE: $ARGUMENT2 - IMPORTANT: if not provided stop and ask for the evaluation file path
OUTPUT-FILE: $ARGUMENT3 or "review/conclusion.md" if not specified

## Workflow
1. Read the original change request: [CONTEXT].
2. Read the review from [REVIEW-FILE].
3. Read the evaluation from [EVALUATION-FILE].
4. Objectively consider recommendations from both parties.
5. Decide the best way forward, explaining your reasoning.
6. Save your conclusion to [OUTPUT-FILE].

## Output
Report only the file name back to the calling agent.