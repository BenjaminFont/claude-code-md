---
description: To generate a detailed plan of implementing a feature based on earlier gotten knowledge
model: claude-opus-4-1
---

## Variables
BUG: $ARGUMENT0 - IMPORTANT: If no feature is described stop directly and ask for a description.
OUTPUT: $ARGUMENT1 or "plan.md" if not specified
OUTPUT-FOLDER: $ARGUMENT2 or "./docs" if not specified
THINKING-MODE: $ARGUMENT3 or "think hard" if not specified 

## Workflow
1. [THINKING-MODE]
2. Create a plan to fix a [BUG]. 
    1a) Which files need to be modified and why? 
    1b) What is your analysis on why the bug is occuring? 
3. Write a plan on the steps you would take to fix the problem.
4. Make the plan compact. Don't use code in the plan yet. Describe what has to be done
5. Write your plan in [OUTPUT] in [OUTPUT-FOLDER].

## Output
Write me a short overview of what you planed and tell me the destination you saved the plan at. 