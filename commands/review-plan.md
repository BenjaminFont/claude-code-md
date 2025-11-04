---
description: Analyse a feature plan in depth and figure out how to make it better
model: claude-opus-4-1
---

## Variables
PATH-TO-PLAN: $ARGUMENTS IMPORTANT if now provided stop the work and ask the user to provide a path to a plan
THINKING-MODE: $ARGUMENT3 or "think hard" if not specified


## Workflow 
A senior dev from my team has created a plan to build a new feature.
1. [THINKING-MODE]
2. You can find the plan in [PATH-TO-PLAN]. 
3. Review this plan. Be critical. What are the strengths and weaknesses of the plan? Would you change anything about this plan and what?. 
4. From [PATH-TO-PLAN] get the version number at the end.
5. Write your revised version of the plan beside [PATH-TO-PLAN] and increment the version. If no version specified append -v2.md.


## Output
Short summary of the review and the path of the version you created.