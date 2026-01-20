---
description: Atomic code review workflow (called by other commands)
---

## Variables
TARGET: $ARGUMENT0 - IMPORTANT: if not provided stop and ask for a target to review
OUTPUT-FILE: $ARGUMENT1 or "review/review.md" if not specified

## Workflow
1. Analyze [TARGET] for code quality, patterns, and potential issues.
2. Identify strengths, weaknesses, and areas for improvement.
3. Document specific recommendations with reasoning.
4. Save the complete review to [OUTPUT-FILE].

## Output
Report only the file name back to the calling agent.