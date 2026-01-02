#' Submit Package for macOS R-release Check
#'
#' Submits the package to the macOS builder service for checking on macOS
#' with the current release version of R.
#'
#' @return Logical value `TRUE`, returned invisibly, on successful submission.
#'
#' @details
#' This function submits your package to the macOS builder service which runs
#' R CMD check on macOS with R-release (current stable version). It performs
#' the following steps:
#'
#' 1. Checks for required dependencies (installs if needed)
#' 2. Builds package tarball
#' 3. Submits to macOS builder service
#' 4. Runs R CMD check on macOS R-release
#' 5. Sends results via email to package maintainer
#'
#' @section Email Results:
#' - Results sent to email specified in DESCRIPTION (maintainer)
#' - Typical arrival time: 15-60 minutes
#' - Check your spam folder if results don't arrive
#' - Results include full R CMD check output
#'
#' @section Why Check on macOS:
#' - Tests against current release version of R
#' - Important for CRAN submission
#' - May find macOS-specific issues
#' - Particularly useful for non-Mac developers
#' - Catches platform-specific problems
#'
#' @section Prerequisites:
#' - Must be run from package root directory
#' - Package should pass local R CMD check first
#' - Internet connection required
#' - Valid maintainer email in DESCRIPTION file
#'
#' @section Notes:
#' - Check runs on remote macOS server
#' - Does not require Mac machine locally
#' - Tests against current R-release version
#' - Essential before CRAN submission
#' - Complements local checks on your platform
#'
#' @export
#' @autoglobal
#'
#' @examples
#' \dontrun{
#' # Submit to macOS R-release builder
#' check_on_mac()
#'
#' # Wait for email with results (15-60 minutes)
#' # Review any macOS-specific issues
#' # Fix problems and resubmit if needed
#' }
check_on_mac <- function() {
  # Check and install dependencies
  if (!requireNamespace("devtools", quietly = TRUE)) {
    cli::cli_alert_info("Installing required package: {.pkg devtools}")
    utils::install.packages("devtools")
  }

  # Print header
  cli::cli_rule(
    left = "MACOS R-RELEASE CHECK"
  )
  cli::cli_text()

  # Important information
  cli::cli_alert_info(
    "Submitting package to macOS builder for R-release check..."
  )
  cli::cli_text()

  cli::cli_h3("IMPORTANT:")
  cli::cli_ul(c(
    "Results will be emailed to the package maintainer",
    "Check may take 15-60 minutes",
    "Check your spam folder if results don't arrive",
    "Tests against current release version of R on macOS"
  ))
  cli::cli_text()

  # Submit to mac-builder
  cli::cli_alert_info("Running {.code devtools::check_on_mac()} ...")
  cli::cli_text()

  devtools::check_on_mac()

  cli::cli_text()
  cli::cli_rule("SUBMISSION COMPLETE")
  cli::cli_alert_success("Your package has been submitted to the macOS builder")
  cli::cli_alert_info(
    "Results will be emailed when the check completes"
  )
  cli::cli_rule()

  invisible(TRUE)
}
