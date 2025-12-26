# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Package Overview

This is a template R package (`blankpkg`) configured with modern development infrastructure including:
- `roxyglobals` for automatic global variable detection
- `air` formatter for code styling
- `testthat` for testing
- `pkgdown` for documentation website
- `rhub` for cross-platform CRAN checks

## Essential Development Commands

### Documentation and Building
```r
devtools::document()        # Generate documentation from roxygen2 comments
devtools::load_all()        # Load package for interactive testing
devtools::install()         # Install package locally
devtools::check()           # Run R CMD check (required before completion)
```

### Testing
```r
devtools::test()                              # Run all tests
testthat::test_file("tests/testthat/test-*.R")  # Run single test file
spelling::spell_check_package()               # Check spelling
```

### Code Quality
```r
goodpractice::gp()          # Check package best practices
covr::package_coverage()    # Code coverage report
```

### CRAN Preparation
```r
devtools::check_win_devel()     # Windows check
devtools::check_mac_release()   # macOS check
rhub::rhub_check()             # Multi-platform check (see dev/check_in_rhub.R)
```

## Package Configuration

### roxyglobals Setup
- Add `@autoglobal` tag to every function
- Globals detected automatically and written to `R/globals.R`
- Config: `Config/roxyglobals/filename: globals.R` and `Config/roxyglobals/unique: TRUE`

### Roxygen Configuration
Uses markdown format with custom roclets:
```
Roxygen: list(markdown = TRUE, roclets = c("collate", "namespace", "rd", "roxyglobals::global_roclet"))
```

### Code Formatting
- Uses `air` formatter (configured in `air.toml`)
- Run formatting via air tools, not manually

## Development Scripts

The `dev/` folder contains reference scripts (not meant to be run directly):
- `create_package_skeleton.R` — Initial package setup steps
- `install_or_update_development_packages.R` — Required dev dependencies
- `check_in_rhub.R` — Multi-platform CRAN checking
- `code_coverage.R` — Coverage testing template
- `map_internal_dependencies.R` — Dependency visualization with pkgnet

## Workflow Requirements

1. **Always run `devtools::check()`** before considering any task complete
2. **Run tests with `devtools::test()`** to verify no regressions
3. **Add `@autoglobal` to new functions** for automatic global variable detection
4. **Use roxygen2 markdown format** for all documentation
5. **Check spelling** with `spelling::spell_check_package()` (custom words go in `inst/WORDLIST`)
