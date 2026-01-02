#' Run Quick Test Suite for Rapid Development
#'
#' Loads the package and runs all tests with minimal overhead. This is the
#' fastest way to verify your code changes during active development.
#'
#' @return Test results object from `devtools::test()`, returned invisibly.
#'
#' @details
#' This function provides a streamlined testing workflow optimized for rapid
#' iteration during development. It performs the following steps:
#'
#' 1. Checks for required dependencies (installs if needed)
#' 2. Clears the console for clean output
#' 3. Loads the package code with `devtools::load_all()`
#' 4. Runs all tests with `devtools::test()`
#' 5. Reports test results and timing
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
#' - Much faster than full R CMD check; use this for quick iteration
#' - `load_all()` simulates package installation without building
#' - Tests run in the current R session
#' - Fix all failing tests before committing code
#' - For more comprehensive testing, use `test_with_coverage()`
#'
#' @export
#' @autoglobal
#'
#' @examples
#' \dontrun{
#' # Run quick test during development
#' daily_test()
#'
#' # Typical workflow:
#' # 1. Make code changes
#' # 2. daily_test() to verify tests pass
#' # 3. Iterate until all green
#' # 4. check() before committing
#' }
daily_test <- function() {
  # Check and install dependencies
  if (!requireNamespace("devtools", quietly = TRUE)) {
    cli::cli_alert_info("Installing required package: {.pkg devtools}")
    utils::install.packages("devtools")
  }

  # Clear console
  cat("\014")

  # Print header
  cli::cli_rule(
    left = "DAILY WORKFLOW: RUN TESTS",
    line = 2
  )
  cli::cli_text()

  # Load package
  cli::cli_alert_info("Running {.code devtools::load_all()} ...")
  cli::cli_text()
  start_time <- Sys.time()

  devtools::load_all(quiet = TRUE)

  cli::cli_alert_success("Package loaded")
  cli::cli_text()

  # Run tests
  cli::cli_alert_info("Running {.code devtools::test()} ...")
  cli::cli_text()

  result <- devtools::test()

  # Calculate and display timing
  total_time <- difftime(Sys.time(), start_time, units = "secs")

  cli::cli_text()
  cli::cli_rule("TEST COMPLETE")
  cli::cli_alert_success(
    "Total time: {round(total_time, 1)} seconds"
  )
  cli::cli_rule()

  invisible(result)
}
