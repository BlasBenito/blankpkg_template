#' Submit Package for Windows R-devel Check
#'
#' Submits the package to the win-builder service for checking on Windows
#' with the development version of R.
#'
#' @return Logical value `TRUE`, returned invisibly, on successful submission.
#'
#' @details
#' This function submits your package to the win-builder service which runs
#' R CMD check on Windows with R-devel (development version). It performs
#' the following steps:
#'
#' 1. Checks for required dependencies (installs if needed)
#' 2. Builds package tarball
#' 3. Submits to win-builder service
#' 4. Runs R CMD check on Windows R-devel
#' 5. Sends results via email to package maintainer
#'
#' @section Email Results:
#' - Results sent to email specified in DESCRIPTION (maintainer)
#' - Typical arrival time: 15-60 minutes
#' - Check your spam folder if results don't arrive
#' - Results include full R CMD check output
#'
#' @section Why Check on Windows R-devel:
#' - Tests against development version of R
#' - Important for CRAN submission (CRAN uses R-devel)
#' - May find Windows-specific issues
#' - Catches compatibility problems early
#' - Free service provided by Uwe Ligges
#'
#' @section Prerequisites:
#' - Must be run from package root directory
#' - Package should pass local R CMD check first
#' - Internet connection required
#' - Valid maintainer email in DESCRIPTION file
#'
#' @section Notes:
#' - Check runs on remote Windows server
#' - Does not require Windows machine locally
#' - Tests against latest R-devel version
#' - Essential before CRAN submission
#' - Complements local checks on your platform
#'
#' @export
#' @autoglobal
#'
#' @examples
#' \dontrun{
#' # Submit to Windows R-devel builder
#' check_win_devel()
#'
#' # Wait for email with results (15-60 minutes)
#' # Review any Windows-specific issues
#' # Fix problems and resubmit if needed
#' }
check_win_devel <- function() {
  # Check and install dependencies
  if (!requireNamespace("devtools", quietly = TRUE)) {
    cli::cli_alert_info("Installing required package: {.pkg devtools}")
    utils::install.packages("devtools")
  }

  # Print header
  cli::cli_rule(
    left = "WINDOWS R-DEVEL CHECK"
  )
  cli::cli_text()

  # Important information
  cli::cli_alert_info(
    "Submitting package to win-builder for Windows R-devel check..."
  )
  cli::cli_text()

  cli::cli_h3("IMPORTANT:")
  cli::cli_ul(c(
    "Results will be emailed to the package maintainer",
    "Check may take 15-60 minutes",
    "Check your spam folder if results don't arrive",
    "Tests against development version of R on Windows"
  ))
  cli::cli_text()

  # Submit to win-builder
  cli::cli_alert_info("Running {.code devtools::check_win_devel()} ...")
  cli::cli_text()

  devtools::check_win_devel()

  cli::cli_text()
  cli::cli_rule("SUBMISSION COMPLETE")
  cli::cli_alert_success("Your package has been submitted to win-builder")
  cli::cli_alert_info(
    "Results will be emailed when the check completes"
  )
  cli::cli_rule()

  invisible(TRUE)
}
