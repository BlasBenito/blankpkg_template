# TODO - blankpkg Template Development

## Project Architecture

### What This Is

This is a **template for building R packages**, NOT a typical R package itself.

When users copy this template to create their own package:
- They **USE** the development tools in `dev/` during development
- They **DELETE** the example code in `R/` and replace with their own functions
- They **DELETE** the `dev/` tools when their package is ready for release

### Directory Structure

- **R/** - Contains ONLY example code (`lm_model.R`, `data.R`) that users DELETE when building their package
- **dev/** - Contains development TOOL functions that users USE during development and optionally DELETE when done
- **Future:** The `dev/` tools will eventually become a separate CRAN package (e.g., "pkgdevtools") for package development

### Current Objective

Convert all `dev/` scripts into well-documented R functions with complete roxygen2 documentation.
These functions will eventually be moved to a new package and published to CRAN, making them available to the entire R community.

**Goal:** Create a package that makes R package development as simple and fast as possible by providing streamlined, zero-configuration development functions.

---

## Migration Status

### Completed Development Tools (30/30 - 100%)

**Note:** These functions now live in `dev/` with complete roxygen2 documentation, ready for eventual extraction into a CRAN package.

#### Setup & Installation (4 functions) ✓
- [x] `setup_rcpp_infrastructure.R` - Configure Rcpp infrastructure
- [x] `install_dev_dependencies.R` - Install all development dependencies
- [x] `install_linter_jarl.R` - Display jarl linter installation instructions
- [x] `install_formatter_air.R` - Install air formatter (wraps `usethis::use_air()`)

#### Daily Development (3 functions) ✓
- [x] `daily_document_and_check.R` → Split into `check.R` and `check_full.R`
- [x] `daily_test.R` - Run quick test suite
- [x] `daily_load_all.R` - Load package for interactive development

#### Testing Suite (3 functions) ✓
- [x] `test_run_all.R` - Run complete test suite with detailed output
- [x] `test_with_coverage.R` - Run tests with HTML coverage report
- [x] `test_spelling.R` - Check spelling in all documentation

#### Checking Suite (5 functions) ✓
- [x] `check.R` and `check_full.R` - Local R CMD check (replaced `check_local.R`)
- [x] `check_good_practice.R` - Analyze package for R best practices
- [x] `check_win_devel.R` - Submit to Windows R-devel builder
- [x] `check_mac_release.R` - Submit to macOS R-release builder
- [x] `check_rhub_multi_platform.R` - Multi-platform checks via R-Hub

#### Build Tools (2 functions) ✓
- [x] `build_readme.R` - Render README.Rmd to README.md
- [x] `build_vignettes.R` - Build all vignettes to inst/doc/

#### Pkgdown Website (2 functions) ✓
- [x] `pkgdown_build_site.R` - Build complete package website
- [x] `pkgdown_customize_site.R` - Interactive guide for customizing _pkgdown.yml

#### Release Workflow (4 functions) ✓
- [x] `release_01_prepare.R` - Preparation checklist (version, NEWS.md, spell check)
- [x] `release_02_local_checks.R` - Local R CMD check + goodpractice
- [x] `release_03_remote_checks.R` - Submit to remote builders
- [x] `release_04_submit_to_cran.R` - Final CRAN submission

#### Analysis Tools (5 functions) ✓
- [x] `analyze_code_coverage.R` - Calculate and display test coverage
- [x] `analyze_code_quality.R` - Static code analysis with codetools
- [x] `analyze_dependencies.R` - Create interactive dependency network graph
- [x] `analyze_package_structure.R` - Analyze package organization and metrics
- [x] `analyze_performance.R` - Benchmarking and profiling template

#### Development Helpers (2 functions) ✓
- [x] `create_example_data.R` - Template for creating package datasets
- [x] `create_example_function.R` - Template for creating package functions

---

## Migration Complete! 🎉

All 30 development tool scripts have been successfully converted to well-documented functions with complete roxygen2 documentation. These functions are now ready for eventual extraction into a standalone CRAN package.

---

## Migration Rules

Follow these guidelines when converting scripts to functions (based on successful migrations):

### Function Design
1. **Remove all arguments** - Functions should have no parameters or minimal parameters with sensible defaults
2. **Keep it simple** - Prioritize speed and simplicity over configurability
3. **Use consistent naming** - Function name should match the script name (e.g., `daily_test.R` → `daily_test()`)

### Documentation
4. **Complete roxygen2 documentation** - Include all standard tags:
   - `@title` and description
   - `@return` - Usually `invisible(TRUE)` on success
   - `@details` - Explain what the function does step-by-step
   - `@section` - For additional sections (Prerequisites, Notes, etc.)
   - `@export` - Make function available to users
   - `@autoglobal` - Required for automatic global variable detection
   - `@examples` - Wrap in `\dontrun{}` if they modify the package

### Code Style
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

### Function Behavior
7. **Check and install dependencies** - Use `requireNamespace()` and `utils::install.packages()` at function start
8. **Return invisibly** - End with `invisible(TRUE)` for success
9. **Use cli::cli_abort()** - For errors that should stop execution
10. **Preserve all guidance** - Keep all instructional messages, examples, and next steps from the original script

### File Organization
11. **Keep in dev/ directory** - These are development tools, not package functions
12. **Test thoroughly** - Verify function works before considering migration complete
13. **Update TODO.md after each migration** - Mark the script as complete and update the total count

---

## Future Improvements

### Code Quality - DRY Refactoring (Deferred)

**Current State:** The 24 completed dev/ functions contain significant code duplication:
- 21 instances of `requireNamespace()` dependency checks
- 70 instances of `cli::cli_rule()` header patterns
- 8 instances of timing code with `Sys.time()`

**Proposed Solution:** Create `dev/utils.R` with shared helper functions:

```r
# Eliminate 21 duplicate dependency checks
check_and_install_packages <- function(packages) {
  for (pkg in packages) {
    if (!requireNamespace(pkg, quietly = TRUE)) {
      cli::cli_alert_info("Installing required package: {.pkg {pkg}}")
      utils::install.packages(pkg)
    }
  }
  invisible(TRUE)
}

# Eliminate 70 duplicate CLI rule patterns
print_header <- function(title) {
  cli::cli_rule(left = title, line = 2)
  cli::cli_text()
}

# Eliminate duplicate footer patterns
print_success_footer <- function(message, time = NULL) {
  cli::cli_text()
  cli::cli_rule(toupper(gsub("_", " ", message)))
  if (!is.null(time)) {
    cli::cli_alert_success("Total time: {round(time, 1)} seconds")
  } else {
    cli::cli_alert_success(message)
  }
  cli::cli_rule()
}

# Eliminate 8 duplicate timing patterns
measure_time <- function(expr) {
  start_time <- Sys.time()
  result <- force(expr)
  elapsed <- difftime(Sys.time(), start_time, units = "secs")
  list(result = result, time = as.numeric(elapsed))
}
```

**Action Items:**
- [ ] Create `dev/utils.R` with shared utilities
- [ ] Refactor all 24 dev/ functions to use shared utilities
- [ ] Test each refactored function thoroughly
- [ ] Verify all functions still work after refactoring

### Next Steps

1. **Complete remaining migrations** - Convert the 6 remaining analysis and helper scripts
2. **Implement DRY refactoring** - Create and integrate shared utilities (see Code Quality section)
3. **Add comprehensive tests** - Create test suite for dev/ functions
4. **Prepare for CRAN extraction** - Plan architecture for standalone "pkgdevtools" package

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
