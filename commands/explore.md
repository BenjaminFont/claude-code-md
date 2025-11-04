---
description: Load context for a new agent session by analyzing codebase structure and relevant documents
model: claude-sonnet-4-5
---

## Variables
TOPIC: $ARGUMENTS0 IMPORTANT if not provided interrupt and ask the user for info
LOCATION: $ARGUMENTS1 IMPORTANT if not provided interrupt and ask the user for info

## Workflow 
1. We will be working on [TOPIC].
2. Take a closer look at [LOCATION].
3. Dive into the code, be ready to discuss advantages and disadvantages of implementation details.

## Output
Give a short summary of what you understood.