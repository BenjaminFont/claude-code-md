---
description: To generate a detailed plan of implementing a feature based on earlier gotten knowledge
model: claude-sonnet-4-5
tools: jira_get_agile_boards, jira_get_board_issues, jira_get_sprints_from_board
---

## Variables
FEATURE: $ARGUMENT0 - IMPORTANT: If no feature is described stop directly and ask for a description.
OUTPUT: $ARGUMENT1 or "plan.md" if not specified
OUTPUT-FOLDER: $ARGUMENT2 or "./docs" if not specified
THINKING-MODE: $ARGUMENT3 or "think hard" if not specified
JIRA-BOARD: TFB

## Workflow
1. [THINKING-MODE]
2. Create a plan to build a [FEATURE].
   a. Use the jira tools to find a story or task with more context for the plan on board [JIRA-BOARD]
   b. Which parts need to be modified and why?
   c. Which tests would you write and why?
4. Make the plan compact. Don't use code in the plan yet. Describe what has to be done.
5. Write your plan in [OUTPUT] in [OUTPUT-FOLDER].

## Output
Write me a short overview of what you planed and tell me the destination you safed the plan at. 