---
description: To implement a feature which was earlier planned with a specified plan.
model: claude-sonnet-4-5
---

## Variables
BRANCH: $ARGUMENT0 - IMPORTANT: if not specified directly stop and ask user to provide 
PLAN: $ARGUMENT1 - IMPORTANT: if not specified directly stop and ask user to provide


## Workflow
1. Before doing anything, create a branch named [BRANCH] on the project an all submodules (team-finder-frontend & team-finder-backend).
   In the parent folder (team-finder) you also need to create a branch.
2. Implement the feature according to the plan in [PLAN]. 


