#' Analyze Test Coverage for Package Code
#'
#' Calculates test coverage for all package code and displays summary statistics.
#' Optionally generates an interactive HTML report.
#'
#' @return Coverage object from `covr::package_coverage()`, returned invisibly.
#'   Contains coverage statistics for each source file.
#'
#' @details
#' This function takes no parameters and analyzes test coverage for your entire
#' package. It performs the following steps:
#'
#' 1. Checks for required dependencies (installs if needed)
#' 2. Calculates test coverage for all package code
#' 3. Displays coverage summary in console
#' 4. Shows coverage percentage per file
#' 5. Reports overall package coverage percentage
#'
#' To view a detailed interactive HTML report after running this function:
#' `covr::report(result)`
#'
#' @section Coverage Goals:
#' - Aim for > 80% overall coverage
#' - Focus on covering critical functionality
#' - Some code may be difficult to test (error handlers, edge cases)
#' - CRAN doesn't require specific coverage percentage
#'
#' @section Understanding Coverage:
#' - Coverage shows which lines are executed during tests
#' - Low coverage doesn't always mean bad tests
#' - High coverage doesn't guarantee bug-free code
#' - Focus on meaningful tests, not just coverage numbers
#'
#' @section Prerequisites:
#' - Must be run from package root directory
#' - Package must have tests in tests/testthat/
#' - Package should be in working state
#'
#' @section Notes:
#' - Coverage calculation runs all tests (may take time)
#' - Look for files with < 80% coverage
#' - Interactive report highlights untested code in red
#' - Report shows line-by-line coverage
#'
#' @export
#' @autoglobal
#'
#' @examples
#' \dontrun{
#' # Analyze code coverage
#' result <- analyze_code_coverage()
#'
#' # View interactive HTML report
#' covr::report(result)
#'
#' # Check coverage for specific files
#' print(result)
#' }
analyze_code_coverage <- function() {
  # Check and install dependencies
  if (!requireNamespace("covr", quietly = TRUE)) {
    cli::cli_alert_info("Installing required package: {.pkg covr}")
    utils::install.packages("covr")
  }

  # Print header
  cli::cli_rule(
    left = "CODE COVERAGE ANALYSIS",
    line = 2
  )
  cli::cli_text()

  # Calculate coverage
  cli::cli_alert_info("Running {.code covr::package_coverage()} ...")
  cli::cli_alert_info("This may take a moment as all tests are executed")
  cli::cli_text()

  coverage <- covr::package_coverage()

  # Print coverage summary
  print(coverage)

  # Calculate total coverage percentage
  total_coverage <- covr::percent_coverage(coverage)

  cli::cli_text()
  cli::cli_rule("COVERAGE RESULTS")
  cli::cli_alert_success(
    "Overall coverage: {round(total_coverage, 1)}%"
  )
  cli::cli_rule()
  cli::cli_text()

  # Offer interactive report
  cli::cli_alert_info(
    "To view detailed interactive HTML report, run:"
  )
  cli::cli_code("covr::report(coverage)")
  cli::cli_text()

  invisible(coverage)
}
