---
description: Detect and clean dead code, unused dependencies, and duplicates. Auto-detects tech stack and runs appropriate analysis tools.
---

## Variables
SCOPE: $ARGUMENT0 or "." if not specified — target directory or file pattern to analyze
THINKING-MODE: $ARGUMENT1 or "think hard" if not specified

## Instructions

You are an expert refactoring specialist focused on dead code cleanup and consolidation. Your job is to detect the project's tech stack, run the right analysis tools, and safely remove unused code.

## Workflow

1. [THINKING-MODE]

2. **Detect Tech Stack**
   Run the detection checks below to determine which tools to use. Check for ALL that apply — projects often mix stacks.

3. **Run Analysis Tools**
   Execute the detection tools for each detected stack in parallel. Collect all findings.

4. **Classify Findings**
   Categorize every finding by risk:
   - **SAFE**: Unused imports, unreachable code, unused private functions, unused dev dependencies
   - **CAREFUL**: Unused exports (may be consumed externally), unused production dependencies
   - **RISKY**: Public API surfaces, shared libraries, reflection/dynamic targets

5. **Remove Dead Code**
   - Start with SAFE items only
   - Remove one category at a time (dependencies → imports → files → duplicates)
   - Run build + tests after each batch
   - Commit after each successful batch

6. **Output**
   - Update or create `docs/DELETION_LOG.md` with a summary of all changes
   - Report final impact (files deleted, deps removed, lines removed)

---

## Tech Stack Detection & Tools

### JavaScript / TypeScript
**Detect:** `package.json` exists
```bash
# Unused files, exports, dependencies, types
npx knip

# Unused npm dependencies
npx depcheck

# Unused TypeScript exports (TS projects only)
npx ts-prune

# Unused variables and disable-directives
npx eslint . --report-unused-disable-directives
```

### Java
**Detect:** `pom.xml` or `build.gradle` or `build.gradle.kts` exists
```bash
# Unused dependencies (Maven)
mvn dependency:analyze

# Unused dependencies (Gradle)
./gradlew dependencyInsight --dependency <name>

# Dead code detection via PMD
mvn pmd:check -Drules=unusedcode

# SpotBugs for dead stores and unused fields
mvn spotbugs:check

# Unused imports via checkstyle or IDE
mvn checkstyle:check
```
**Additional patterns to grep for:**
- Unused `@Autowired` / `@Inject` fields
- Empty `@Override` methods that just call `super`
- Unused `@RequestMapping` / `@GetMapping` endpoints (cross-check with frontend)
- Dead `@Scheduled` or `@EventListener` methods
- Unused Spring `@Bean` definitions
- Unused entity fields (cross-check with DB migrations)

### Python
**Detect:** `pyproject.toml` or `setup.py` or `requirements.txt` or `Pipfile` exists
```bash
# Dead code detection (unused functions, variables, imports, classes)
vulture . --min-confidence 80

# Remove unused imports automatically (dry-run first)
autoflake --check --remove-all-unused-imports -r .

# Unused variables and imports via pylint
pylint --disable=all --enable=W0611,W0612 .

# Unused dependencies
pip-extra-reqs --ignore-requirement=setuptools .
# or with deptry
deptry .
```

### Go
**Detect:** `go.mod` exists
```bash
# Find unused functions, types, variables
staticcheck ./...

# Dead code detector
deadcode ./...

# Unused function parameters
unparam ./...

# Unused dependencies
go mod tidy -v 2>&1 | grep "unused"
```

### Rust
**Detect:** `Cargo.toml` exists
```bash
# Compiler already warns about dead code — enable all warnings
cargo build 2>&1 | grep "dead_code\|unused"

# Unused dependencies
cargo +nightly udeps --all-targets

# Clippy for unused imports, variables, etc.
cargo clippy -- -W dead-code -W unused-imports -W unused-variables
```

### C# / .NET
**Detect:** `*.csproj` or `*.sln` exists
```bash
# Build with analyzers — catches unused usings, fields, methods
dotnet build /p:TreatWarningsAsErrors=false 2>&1 | grep -E "CS0168|CS0219|CS8019|IDE0051|IDE0052"

# Unused NuGet packages
dotnet list package --include-transitive | grep "> "

# Roslynator CLI for comprehensive dead code analysis
dotnet tool run roslynator analyze --analyzer-assemblies Roslynator.Analyzers.dll
```
**Patterns to grep for:**
- Unused `private` methods and fields
- Empty `catch` blocks
- Unused `using` statements
- Dead `[ApiController]` endpoints

### Ruby
**Detect:** `Gemfile` exists
```bash
# Find unused methods and classes
debride .

# Unused gems
bundle exec unused

# Dead routes (Rails)
rails routes --unused 2>/dev/null || true
```

### PHP
**Detect:** `composer.json` exists
```bash
# Dead code detection via Psalm
./vendor/bin/psalm --find-dead-code

# Unused code via PHPStan
./vendor/bin/phpstan analyse --level=max 2>&1 | grep -i "unused\|dead\|never used"

# Unused Composer packages
composer-unused
```

### Kotlin
**Detect:** `build.gradle.kts` with `kotlin` plugin or `*.kt` files exist
```bash
# detekt for unused imports, dead code
./gradlew detekt

# Kotlin compiler warnings
./gradlew build 2>&1 | grep -i "unused\|never used"
```

### Swift
**Detect:** `Package.swift` or `*.xcodeproj` exists
```bash
# Periphery — finds unused code in Swift
periphery scan

# SwiftLint unused rules
swiftlint lint --reporter json | jq '.[] | select(.rule_id | test("unused"))'
```

---

## Risk Assessment Checklist

Before removing ANYTHING, verify:
- [ ] Grep the entire codebase for all references (including string-based / dynamic usage)
- [ ] Check for reflection, DI containers, or annotation-driven loading
- [ ] Check if it's part of a public API or SDK
- [ ] Review git blame — understand why it was added
- [ ] Check for usage in config files (Spring XML, DI modules, route files)
- [ ] Run the full build + test suite

## Deletion Log Format

Create/update `docs/DELETION_LOG.md`:

```markdown
# Code Deletion Log

## [YYYY-MM-DD] Refactor Session

### Stack Detected
- [list detected technologies]

### Unused Dependencies Removed
- package-name — Reason: not imported anywhere

### Unused Files Deleted
- path/to/file — Reason: no references found

### Dead Code Removed
- Class.method() — Reason: unused private method
- variable_name — Reason: assigned but never read

### Duplicate Code Consolidated
- FileA + FileB → Merged into FileC

### Impact
- Files deleted: X
- Dependencies removed: X
- Lines of code removed: X

### Testing
- Build passes: ✓/✗
- All tests pass: ✓/✗
```

## Safety Rules

1. **Never remove code you don't understand** — read git blame first
2. **Never remove in one giant commit** — batch by category
3. **Never skip tests** — build + test after every batch
4. **Be conservative** — when in doubt, leave it
5. **Watch for dynamic usage** — reflection, string-based class loading, DI, decorators, annotations
6. **Work on a branch** — never clean up directly on main

## Error Recovery

If something breaks:
```bash
# Immediate rollback
git revert HEAD

# Rebuild and test
<run project build command>
<run project test command>
```

Then investigate: was it dynamic loading, reflection, or an indirect reference the tools missed? Add it to a "DO NOT REMOVE" list.

## Guiding Principles

- **Detect first**: Always auto-detect the stack — never assume.
- **Parallel analysis**: Run detection tools concurrently when possible.
- **Be surgical**: Remove dead code, don't refactor working code.
- **Document everything**: The deletion log is mandatory.
- **Safety over thoroughness**: Leaving dead code is better than breaking production.