#' Run Complete Test Suite with Detailed Output
#'
#' Runs all package tests without clearing the console, preserving previous
#' output. This is nearly identical to the `daily_test()` function but maintains
#' console history for debugging workflows.
#'
#' @return A test results object from `devtools::test()` (class "testthat_results"),
#'   returned invisibly. Contains information about all executed tests, including
#'   passes, failures, and skips.
#'
#' @details
#' This function provides comprehensive test execution with detailed reporting.
#' It performs the following steps:
#'
#' 1. Checks for required dependencies (installs if needed)
#' 2. Loads package code with `devtools::load_all()`
#' 3. Runs all tests in `tests/testthat/` directory
#' 4. Reports detailed results for each test file
#' 5. Highlights failures and provides summary statistics
#'
#' @section Difference from daily_test():
#' - `daily_test()` clears the console first for clean output
#' - `test_run_all()` preserves previous console output
#' - Use whichever fits your workflow preference
#'
#' @section Typical Runtime:
#' 5-15 seconds depending on package size and number of tests
#'
#' @section Prerequisites:
#' - Must be run from package root directory
#' - `tests/testthat/` directory must exist
#' - Package must use testthat for testing
#'
#' @section Notes:
#' - All tests should pass before committing or pushing
#' - Failed tests show full error details for debugging
#' - Detailed output helps identify which specific tests failed
#' - For coverage analysis, use `test_with_coverage()`
#'
#' @export
#' @autoglobal
#'
#' @examples
#' \dontrun{
#' # Run complete test suite
#' test_run_all()
#'
#' # Review failures in console history
#' # Fix issues and rerun
#' test_run_all()
#' }
test_run_all <- function() {
  # Check and install dependencies
  if (!requireNamespace("devtools", quietly = TRUE)) {
    cli::cli_alert_info("Installing required package: {.pkg devtools}")
    utils::install.packages("devtools")
  }

  # Print header (no console clearing)
  cli::cli_rule(
    left = "RUN ALL TESTS"
  )
  cli::cli_text()

  # Load and run tests
  cli::cli_alert_info("Running {.code devtools::test()} ...")
  cli::cli_text()

  start_time <- Sys.time()

  result <- devtools::test()

  # Calculate and display timing
  total_time <- difftime(Sys.time(), start_time, units = "secs")

  cli::cli_text()
  cli::cli_rule("ALL TESTS COMPLETE")
  cli::cli_alert_success(
    "Total time: {round(total_time, 1)} seconds"
  )
  cli::cli_text()
  cli::cli_alert_info(
    "Review any failures above and fix before committing"
  )
  cli::cli_rule()

  invisible(result)
}
