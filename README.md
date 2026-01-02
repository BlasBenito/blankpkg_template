
<!-- README.md is generated from README.Rmd. Please edit that file -->

# blankpkg_template: Complete R Package Template

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

> **⚠️ IMPORTANT: This is a TEMPLATE repository**
>
> This README.Rmd explains how the template works. When you use this for
> your own package, **replace this entire file** with documentation
> specific to your package.

## What is `blankpkg_template`?

It is a template for R packages that gives you a complete development
infrastructure out of the box:

- **30 development scripts** organized by workflow category
- **Automatic pre-commit hooks** for code quality
- **4-step CRAN release workflow**
- **pkgdown website configuration** with example article
- **Rcpp/C++ integration support**
- **Claude Code support** with specific subagents for R package
  development
- **Comprehensive testing and checking tools**
- **Example vignette/article** demonstrating documentation best
  practices

This template follows modern R package development best practices and
automates the tedious stuff so you can focus on writing code.

## Acknowledgements

This template would have been impossible without the outstanding effort
of the R community and the developers of the following excellent
packages:

- **devtools** (Wickham et al., 2025) - Tools to make developing R
  packages easier. The backbone of modern R package development.
  <https://devtools.r-lib.org/>

- **usethis** (Wickham et al., 2025) - Automates package and project
  setup tasks, making package infrastructure setup painless.
  <https://usethis.r-lib.org>

- **testthat** (Wickham, 2011) - Unit testing framework that makes
  testing R packages straightforward and enjoyable.
  <https://testthat.r-lib.org/>

- **covr** (Hester, 2023) - Test coverage analysis to identify untested
  code and improve package quality. <https://covr.r-lib.org/>

- **spelling** (Ooms & Hester, 2025) - Spell checking tools that catch
  typos in documentation before they reach users.
  <https://docs.ropensci.org/spelling/>

- **goodpractice** - Package quality analyzer that provides actionable
  recommendations for improving R packages.

- **rhub** (Csárdi & Salmon, 2025) - Multi-platform package checking
  infrastructure for validating packages across different systems.
  <https://r-hub.github.io/rhub/>

- **pkgdown** (Wickham et al., 2025) - Creates beautiful static HTML
  documentation websites from R packages. <https://pkgdown.r-lib.org/>

- **pkgnet** (Burns et al., 2024) - Network analysis and visualization
  of package dependencies and structure.
  <https://github.com/uptake/pkgnet>

- **codetools** (Tierney, 2024) - Static code analysis tools for
  identifying potential issues in R code.
  <https://CRAN.R-project.org/package=codetools>

- **microbenchmark** (Mersmann, 2024) - Accurate timing functions for
  performance benchmarking and optimization.
  <https://github.com/joshuaulrich/microbenchmark/>

- **profvis** (Wickham et al., 2024) - Interactive visualizations for
  profiling R code and identifying performance bottlenecks.
  <https://profvis.r-lib.org>

- **roxyglobals** (North, 2023) - Automatic global variable declarations
  for roxygen2, eliminating manual NAMESPACE management.
  <https://github.com/anthonynorth/roxyglobals>

- **cli** (Csárdi, 2025) - Powerful helpers for creating beautiful
  command line interfaces with rich formatting. <https://cli.r-lib.org>

- **desc** (Csárdi et al., 2023) - Tools for reading, writing, and
  manipulating DESCRIPTION files programmatically.
  <https://CRAN.R-project.org/package=desc>

Without these packages and their dedicated maintainers, modern R package
development would be far more tedious. This template simply brings them
together in a streamlined workflow.

## Template Features

### 1. Development Functions (30 total)

**Important Note:** All development tools have been converted from
scripts to well-documented R functions with complete roxygen2
documentation. This makes them ready for eventual extraction into a
standalone CRAN package for the R community.

All functions are in the `dev/` folder with prefix-based naming for easy
discovery via autocomplete:

**Setup & Installation (4 functions)** - `setup_rcpp_infrastructure.R` -
Configure Rcpp infrastructure for C++ code -
`install_dev_dependencies.R` - Install all development packages -
`install_linter_jarl.R` - Display jarl linter installation
instructions - `install_formatter_air.R` - Install air formatter (wraps
usethis::use_air())

**Daily Development (3 functions)** - `check.R` and `check_full.R` -
Quick vs comprehensive checks (replaced `daily_document_and_check.R`) -
`daily_test.R` - Run quick test suite - `daily_load_all.R` - Load
package for interactive development

**Testing Suite (3 functions)** - `test_run_all.R` - Run complete test
suite with detailed output - `test_with_coverage.R` - Run tests with
HTML coverage report - `test_spelling.R` - Check spelling in all
documentation

**Checking Suite (5 functions)** - `check.R` and `check_full.R` - Local
R CMD check (quick vs comprehensive) - `check_good_practice.R` - Analyze
package for R best practices - `check_win_devel.R` - Submit to Windows
R-devel builder - `check_mac_release.R` - Submit to macOS R-release
builder - `check_rhub_multi_platform.R` - Multi-platform checks via
R-Hub (20+ platforms)

**Build Tools (2 functions)** - `build_readme.R` - Render README.Rmd to
README.md - `build_vignettes.R` - Build all vignettes to inst/doc/

**Pkgdown Website (2 functions)** - `pkgdown_build_site.R` - Build
complete package website - `pkgdown_customize_site.R` - Interactive
guide for customizing \_pkgdown.yml

**CRAN Release Workflow (4 functions)** - `release_01_prepare.R` -
Preparation checklist (version, NEWS.md, spell check) -
`release_02_local_checks.R` - Local R CMD check + goodpractice -
`release_03_remote_checks.R` - Submit to remote builders (Windows +
macOS) - `release_04_submit_to_cran.R` - Final CRAN submission

**Analysis Tools (5 functions)** - `analyze_code_coverage.R` - Calculate
and display test coverage - `analyze_code_quality.R` - Static code
analysis with codetools - `analyze_dependencies.R` - Create interactive
dependency network graph - `analyze_package_structure.R` - Analyze
package organization and metrics - `analyze_performance.R` -
Benchmarking and profiling template (TEMPLATE)

**Development Helpers (2 functions)** - `create_example_data.R` -
Template for creating package datasets (TEMPLATE) -
`create_example_function.R` - Template for creating package functions
(TEMPLATE)

### 2. Pre-commit Hook System

The template includes an automatic pre-commit hook that runs before each
commit (so you don’t accidentally commit broken code):

1.  **jarl lint –fix** - Auto-fix linting issues (if installed)
2.  **air format** - Code formatting (if installed)
3.  **devtools::document()** - Update documentation (required)
4.  **devtools::check()** - CRAN-level checks (required)

The hook is automatically installed when you start R in the package
directory (via `.Rprofile`).

**Skip the hook for a single commit:**

``` bash
git commit --no-verify -m "your message"
```

### 3. Claude Code AI Agents

The template includes specialized Claude Code agents in the `.claude/`
folder:

- **roxygen-doc-reviewer** - Reviews roxygen2 documentation for
  completeness and accuracy
- **cran-submission-expert** - Assists with CRAN submission preparation
  and policy compliance

These agents integrate with Claude Code CLI to provide AI-assisted code
review and CRAN preparation. See `dev/README.md` for detailed usage
instructions.

### 4. Key Configuration Files

- `.Rprofile` - Auto-installs pre-commit hook, loads devtools
- `_pkgdown.yml` - Package website configuration (Bootstrap 5)
- `air.toml` - Air formatter configuration
- `dev/pre_commit_hook` - Git pre-commit hook script
- `dev/README.md` - Complete guide to all development scripts

### 4. All Scripts Use Automatic Package Detection

No hardcoded package names! Every script figures out your package name
automatically:

``` r
get_package_name <- function() {
  if (requireNamespace("desc", quietly = TRUE)) {
    return(desc::desc_get_field("Package"))
  }
  if (file.exists("DESCRIPTION")) {
    lines <- readLines("DESCRIPTION", n = 20)
    pkg_line <- grep("^Package:", lines, value = TRUE)
    if (length(pkg_line) > 0) {
      return(trimws(sub("^Package:", "", pkg_line[1])))
    }
  }
  basename(normalizePath("."))
}
```

## How to Use This Template

### Step 1: Create Your Package from This Template

On GitHub, click “Use this template” to create a new repository, or
clone this repository locally.

### Step 2: Customize Package Metadata

Edit `DESCRIPTION` file with your package details: - Package name -
Title and description - Author information - License - Dependencies

### Step 3: Replace This README

**⚠️ IMPORTANT:** Delete this README.Rmd and create your own. Start
fresh with: - Your package name and purpose - Installation
instructions - Usage examples - Function documentation - **Update badge
URLs:** Replace `username/blankpkg` in badges with your GitHub username
and repo name

After editing README.Rmd, generate README.md by running:

``` r
source("dev/build_readme.R")
```

### Step 4: Install Development Dependencies

``` r
source("dev/install_dev_dependencies.R")
```

Optionally install the jarl linter (recommended):

``` r
source("dev/install_linter_jarl.R")
```

### Step 5: Start Developing

Use the daily development functions:

``` r
# Most common workflow - quick check
source("dev/check.R")

# For comprehensive checking (use before commits/releases)
source("dev/check_full.R")

# Quick testing
source("dev/daily_test.R")

# Interactive development
source("dev/daily_load_all.R")
```

### Step 6: Customize pkgdown Website (Optional)

If you want a package website:

``` r
source("dev/pkgdown_customize_site.R")
```

This interactive script helps you configure themes, navigation, and
function reference organization.

### Step 7: Add Rcpp Functionality (Optional)

Need to speed things up with C++?

``` r
source("dev/setup_rcpp_infrastructure.R")
```

This sets up the complete Rcpp infrastructure with example functions to
get you started.

## Quick Reference

### Most Common Workflows

**Daily development:**

``` r
# Quick iteration
source("dev/check.R")

# Comprehensive check (before commits/releases)
source("dev/check_full.R")
```

**Before committing:** The pre-commit hook runs automatically and
catches issues before they reach your repo: - Lints and formats your
code (if jarl/air installed) - Updates documentation - Runs R CMD check

**Optional: Preparing for CRAN Release**

*Note: CRAN submission is entirely optional. This template works
perfectly for GitHub-only packages. Only use these functions if you plan
to submit to CRAN.*

``` r
# Step 1: Prepare
source("dev/release_01_prepare.R")

# Step 2: Local checks
source("dev/release_02_local_checks.R")

# Step 3: Remote checks
source("dev/release_03_remote_checks.R")

# Step 4: Submit
source("dev/release_04_submit_to_cran.R")
```

## Template Documentation

Complete documentation for all development functions is in
`dev/README.md`:

``` r
file.edit("dev/README.md")
```

## Package Development Best Practices Included

This template follows modern R package development standards:

1.  **Code Style**: snake_case consistently, prefix-based function
    families
2.  **Testing**: testthat structure with coverage analysis
3.  **Documentation**: roxygen2 with comprehensive headers
4.  **Quality Control**: Pre-commit hooks with automated checks
5.  **CRAN Compliance**: Step-by-step release workflow
6.  **Website**: pkgdown with Bootstrap 5 and customization options
7.  **Performance**: Optional Rcpp integration for speed-critical code

## What to Keep vs. Replace

### Keep These (they work for any package):

- `dev/` folder and all functions (they auto-detect your package name)
- `.claude/` folder (AI agents for documentation review and CRAN
  submission)
- `.Rprofile` (auto-installs pre-commit hook)
- `dev/pre_commit_hook` (git hook)
- `air.toml` (formatter config)
- `.Rbuildignore`, `NAMESPACE` (auto-managed)

### Replace These (make them yours):

- **README.Rmd** (THIS FILE—replace with your package documentation)
- **DESCRIPTION** (update with your package details)
- \*\*\_pkgdown.yml\*\* (customize for your package)
- `NEWS.md` (document your package changes)
- Everything in `R/`, `tests/`, `man/` (your code goes here)
- `vignettes/articles/article.Rmd` (example article—replace with your
  own documentation)

## After Customizing

Once you’ve customized the template for your package:

1.  Update README.Rmd with your package information
2.  Run `source("dev/build_readme.R")` to generate README.md
3.  Update DESCRIPTION with correct metadata
4.  Start writing your package functions in R/
5.  Add tests in tests/testthat/
6.  Use `source("dev/check.R")` regularly for quick iterations
7.  Use `source("dev/check_full.R")` before commits and releases

## License

MIT License - See LICENSE.md file for details.

## Questions or Issues?

See `dev/README.md` for comprehensive documentation on all development
functions and workflows.

------------------------------------------------------------------------

**Remember:** This README explains the template. Replace it with
documentation specific to your package—don’t keep this file!
