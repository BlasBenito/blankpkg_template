# TODO - blankpkg Template Development

## Migrating Scripts to Functions

### Objective

Convert all development scripts in `dev/` into proper R package functions that can be distributed as a CRAN package. This allows users to access the template's development workflow directly from R without needing to source scripts.

**Goal:** Create a package that makes R package development as simple and fast as possible by providing streamlined, zero-configuration development functions.

### Migration Rules

Based on the conversion of `setup_rcpp_infrastructure.R` → `setup_rcpp_infrastructure()`:

#### Function Design
1. **Remove all arguments** - Functions should have no parameters or minimal parameters with sensible defaults
2. **Keep it simple** - Prioritize speed and simplicity over configurability
3. **Use consistent naming** - Function name should match the script name (e.g., `setup_rcpp_infrastructure.R` → `setup_rcpp_infrastructure()`)

#### Documentation
4. **Complete roxygen2 documentation** - Include all standard tags:
   - `@title` and description
   - `@return` - Usually `invisible(TRUE)` on success
   - `@details` - Explain what the function does step-by-step
   - `@section` - For additional sections (Prerequisites, Notes, etc.)
   - `@export` - Make function available to users
   - `@autoglobal` - Required for automatic global variable detection
   - `@examples` - Wrap in `\dontrun{}` if they modify the package

#### Code Style
5. **Use explicit namespace calls** - Always `package::function()`, never `@importFrom`
6. **Use cli for all messages** - Replace all `cat()`, `message()`, `print()` with cli functions:
   - `cli::cli_rule()` - Headers and dividers
   - `cli::cli_h2()`, `cli::cli_h3()` - Section headers
   - `cli::cli_alert_success()` - Success messages
   - `cli::cli_alert_danger()` - Errors (or `cli::cli_abort()`)
   - `cli::cli_alert_info()` - Information
   - `cli::cli_text()` - Regular text
   - `cli::cli_code()` - Code examples
   - `cli::cli_ul()` - Bullet lists
   - Inline markup: `{.code ...}`, `{.file ...}`, `{.url ...}`

#### Function Behavior
7. **Check and install dependencies** - Use `requireNamespace()` and `utils::install.packages()` at function start
8. **Return invisibly** - End with `invisible(TRUE)` for success
9. **Use cli::cli_abort()** - For errors that should stop execution
10. **Preserve all guidance** - Keep all instructional messages, examples, and next steps from the original script

#### File Organization
11. **Create `*_function.R` version first** - Keep original script intact during development
12. **Test thoroughly** - Verify function works before removing script version
13. **Update TODO.md after each migration** - Mark the script as complete and update the total count

### Progress Tracking

#### Setup & Installation (4 functions)
- [x] `setup_rcpp_infrastructure.R` → `setup_rcpp_infrastructure()`
- [x] `install_dev_dependencies.R` → `install_dev_dependencies()`
- [x] `install_linter_jarl.R` → `install_linter_jarl()` (instructional only)
- [x] `install_formatter_air.R` → `install_formatter_air(vscode = FALSE)` - Wraps `usethis::use_air()`, exposes `vscode` argument

#### Daily Development (3 scripts)
- [x] `daily_document_and_check.R` → Split into `check()` and `check_full()`
- [ ] `daily_test.R` → `daily_test()`
- [ ] `daily_load_all.R` → `daily_load_all()`

#### Testing Suite (3 scripts)
- [ ] `test_run_all.R` → `test_run_all()`
- [ ] `test_with_coverage.R` → `test_with_coverage()`
- [ ] `test_spelling.R` → `test_spelling()`

#### Checking Suite (4 scripts)
- [x] `check_local.R` → Removed (redundant with `check_full()`)
- [ ] `check_good_practice.R` → `check_good_practice()`
- [ ] `check_win_devel.R` → `check_win_devel()`
- [ ] `check_mac_release.R` → `check_mac_release()`
- [ ] `check_rhub_multi_platform.R` → `check_rhub_multi_platform()`

#### Build Tools (2 scripts)
- [ ] `build_readme.R` → `build_readme()`
- [ ] `build_vignettes.R` → `build_vignettes()`

#### Pkgdown Website (2 scripts)
- [ ] `pkgdown_build_site.R` → `pkgdown_build_site()`
- [ ] `pkgdown_customize_site.R` → `pkgdown_customize_site()`

#### Release Workflow (4 scripts)
- [ ] `release_01_prepare.R` → `release_01_prepare()`
- [ ] `release_02_local_checks.R` → `release_02_local_checks()`
- [ ] `release_03_remote_checks.R` → `release_03_remote_checks()`
- [ ] `release_04_submit_to_cran.R` → `release_04_submit_to_cran()`

#### Analysis Tools (5 scripts)
- [ ] `analyze_code_coverage.R` → `analyze_code_coverage()`
- [ ] `analyze_code_quality.R` → `analyze_code_quality()`
- [ ] `analyze_dependencies.R` → `analyze_dependencies()`
- [ ] `analyze_package_structure.R` → `analyze_package_structure()`
- [ ] `analyze_performance.R` → `analyze_performance()`

#### Development Helpers (2 scripts)
- [ ] `create_example_data.R` → `create_example_data()`
- [ ] `create_example_function.R` → `create_example_function()`

**Total: 6/31 functions migrated (19.4%)**

**Note:** `daily_document_and_check.R` was split into two functions (`check()` and `check_full()`) for better development workflow. `check_local.R` was removed as redundant with `check_full()`.

---

## Other TODOs

### Future Enhancements

#### Add check_cran() for CRAN-specific validation
Create a `check_cran()` function that runs the full test suite with CRAN-specific checks:
- Use `devtools::check(cran = TRUE)` for CRAN policy compliance
- Validate against CRAN submission requirements
- More strict checking than `check_full()`
- Use before running `release_*` scripts

#### Automate jarl installation
Currently `install_linter_jarl()` only displays instructions - users must manually copy/paste commands into their terminal. Consider adding automated installation:

**Implementation approach:**
- Add optional `install_now` parameter (default `FALSE` for safety)
- Use `system2()` to run platform-specific installer scripts
- Add confirmation prompt with `utils::askYesNo()` before running system commands
- Clearly warn about system-level changes and permission requirements
- Handle errors from `system2()` calls gracefully
- Verify installation with `system2("jarl", "--version", stdout = TRUE)`
- Note that PATH updates may not take effect until terminal restart

**Challenges to address:**
- Security concerns with running remote scripts from within R
- Different security policies across operating systems
- May require elevated permissions (sudo/admin)
- Firewall or antivirus software may block downloads
- Installation success but command not available until terminal restart
- Windows PowerShell execution policy restrictions

**Alternative approach:**
- Use `clipr::write_clip()` to copy installation command to clipboard
- Notify user that command is ready to paste in terminal
- Still instructional but reduces manual copy/paste friction
