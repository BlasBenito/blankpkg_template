library(covr)

covr::with_coverage(
  testthat::test_dir("path/to/test/directory"),
  covr::package_coverage()
)
