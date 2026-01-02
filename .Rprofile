# ==============================================================================
# .Rprofile - Project-level R configuration
# ==============================================================================
#
# This file runs automatically when R starts in this directory.
# It sets up the development environment for this R package.
#
# ==============================================================================

# Quiet startup
if (interactive()) {
  # --------------------------------------------------------------------------
  # Package development helpers
  # --------------------------------------------------------------------------

  # Load devtools if available (for convenience)
  if (requireNamespace("devtools", quietly = TRUE)) {
    suppressMessages(library(devtools))
  }

  # --------------------------------------------------------------------------
  # Load development functions
  # --------------------------------------------------------------------------

  # Source all dev/ functions to make them available in the global environment
  if (dir.exists("dev")) {
    # Get all .R files in dev/ folder
    dev_files <- list.files("dev", pattern = "\\.R$", full.names = TRUE)

    # Exclude certain files that shouldn't be sourced
    exclude_patterns <- c(
      "pre_commit_hook", # Git hook, not an R file
      "setup_new_package\\.R" # Reference documentation only
    )

    # Filter out excluded files
    for (pattern in exclude_patterns) {
      dev_files <- dev_files[!grepl(pattern, dev_files)]
    }

    # Source each file silently
    for (file in dev_files) {
      tryCatch(
        {
          source(file, local = FALSE) # Load into global environment
        },
        error = function(e) {
          # Silently skip files that can't be sourced
          # (some template files may have placeholder code)
        }
      )
    }
  }

  # Set options for package development
  options(
    # Use browser for help
    help_type = "html",

    # Warn on partial matches
    warnPartialMatchArgs = TRUE,
    warnPartialMatchAttr = TRUE,
    warnPartialMatchDollar = TRUE,

    # Show more in error traces
    error = rlang::entrace,

    # Timezone
    tz = "UTC"
  )

  # --------------------------------------------------------------------------
  # Startup message
  # --------------------------------------------------------------------------

  cat("\n")
  cat("R Package Development Environment Loaded\n")
  cat("=========================================\n")

  # Show package info if DESCRIPTION exists
  if (file.exists("DESCRIPTION")) {
    desc_lines <- readLines("DESCRIPTION", n = 10)
    pkg_line <- grep("^Package:", desc_lines, value = TRUE)
    ver_line <- grep("^Version:", desc_lines, value = TRUE)

    if (length(pkg_line) > 0) {
      pkg_name <- trimws(sub("^Package:", "", pkg_line))
      cat(sprintf("Package: %s\n", pkg_name))
    }
    if (length(ver_line) > 0) {
      version <- trimws(sub("^Version:", "", ver_line))
      cat(sprintf("Version: %s\n", version))
    }
  }
}
