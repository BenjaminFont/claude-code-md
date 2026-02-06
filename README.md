# claude-code-md

A collection of custom agents and slash commands for [Claude Code](https://docs.anthropic.com/en/docs/claude-code) to supercharge your development workflow.

## What's Included

### Agents

| Agent | Description |
|-------|-------------|
| `backend-java-agent` | Java 21+ expert with Spring Boot 3.x, virtual threads, and cloud-native patterns |
| `frontend-vue-agent` | Vue 3 specialist with Composition API, Pinia, and Nuxt 3 expertise |
| `figma-agent` | Figma integration for design systems, components, and design-to-code workflows |
| `jira-agent` | Jira integration for tickets, sprints, JQL queries, and project management |

### Commands

| Command | Description |
|---------|-------------|
| `/explore` | Analyze codebase structure and load context for a topic |
| `/plan` | Generate detailed implementation plans for features |
| `/plan-bug` | Create plans specifically for bug fixes |
| `/plan-with-jira` | Generate plans linked to Jira tickets |
| `/review-plan` | Review and validate implementation plans |
| `/build` | Implement features based on a plan |
| `/recursive-review` | Execute multiple review cycles with evaluation and conclusion |

#### Workflow Commands

| Command | Description |
|---------|-------------|
| `/workflow/review` | Code review step |
| `/workflow/evaluate` | Evaluation step |
| `/workflow/conclude` | Conclusion step |

## Installation

### One-liner (install or update)

```bash
curl -fsSL https://raw.githubusercontent.com/BenjaminFont/claude-code-md/main/install.sh | bash -s -- /path/to/project
```

### With options

```bash
# Only install agents
curl -fsSL https://raw.githubusercontent.com/BenjaminFont/claude-code-md/main/install.sh | bash -s -- --agents-only /path/to/project

# Only install commands
curl -fsSL https://raw.githubusercontent.com/BenjaminFont/claude-code-md/main/install.sh | bash -s -- --commands-only /path/to/project
```

### Shell Function (recommended)

Add this to your `~/.zshrc` or `~/.bashrc`:

```bash
# Install/update claude-code-md in current directory (or specified path)
claude-md() {
  local target="${1:-.}"
  shift 2>/dev/null
  curl -fsSL https://raw.githubusercontent.com/BenjaminFont/claude-code-md/main/install.sh | bash -s -- "$@" "$target"
}
```

Then reload your shell:

```bash
source ~/.zshrc
```

**Usage:**

```bash
claude-md                      # Install in current directory
claude-md /path/to/project     # Install in specific path
claude-md . --agents-only      # Current dir, only agents
claude-md . --commands-only    # Current dir, only commands
```

## Updating

Run the same install command again. It will overwrite existing files with the latest versions from GitHub.

## File Structure

After installation, your project will have:

```
your-project/
└── .claude/
    ├── agents/
    │   ├── backend-java-agent.md
    │   ├── frontend-vue-agent.md
    │   ├── figma-agent.md
    │   └── jira-agent.md
    └── commands/
        ├── explore.md
        ├── plan.md
        ├── plan-bug.md
        ├── plan-with-jira.md
        ├── review-plan.md
        ├── build.md
        ├── recursive-review.md
        └── workflow/
            ├── review.md
            ├── evaluate.md
            └── conclude.md
```

## Customization

After installing, you can customize any file in your project's `.claude/` folder. Your changes will persist until you run the install command again.

If you want to keep customizations while updating, back up your modified files before running the installer.

## Requirements

- [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code)
- `curl` (pre-installed on macOS and most Linux distributions)
- Some agents require MCP integrations (Figma, Jira) to be configured

## License

MIT
