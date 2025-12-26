#Install or update required development packages
#fmt: skip

install.packages(
  pkgs = c(
    "devtools",         #https://devtools.r-lib.org/
    "roxygen2",         #https://roxygen2.r-lib.org/
    "usethis",          #https://usethis.r-lib.org/
    "here",             #https://here.r-lib.org/
    "roxyglobals",      #https://github.com/anthonynorth/roxyglobals
    "rhub",             #https://r-hub.github.io/rhub/
    "covr",             #https://covr.r-lib.org/
    "codetools",        #https://cran.r-project.org/package=codetools
    "pkgnet",           #https://uptake.github.io/pkgnet/
    "microbenchmark",   #https://github.com/joshuaulrich/microbenchmark/
    "goodpractice",     #https://docs.ropensci.org/goodpractice/
    "rcmdcheck",        #https://rcmdcheck.r-lib.org/
    "profvis"          #https://profvis.r-lib.org/
  ),
  Ncpus = parallel::detectCores() - 1
)
