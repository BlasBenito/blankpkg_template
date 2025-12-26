#DON'T RUN!
#reference of functions used to create the main package skeleton

library(usethis)
library(here)
library(roxyglobals)

#move one folder up
setwd(here::here())
setwd("..")

#create skeleton
#restarts Rstudio
#moves root folder to the project folder
usethis::create_package("blankpkg")

#setup git
usethis::use_git()

#package license
usethis::use_mit_license()

#create testthat infra
usethis::use_testthat()

#allow using markdown in roxygen2 docs
usethis::use_roxygen_md()

#setup infra for package website
usethis::use_pkgdown()

#add words to the spell check dictionary
usethis::use_spell_check()

#create NEWS.md (asks about commiting the file)
usethis::use_news_md(open = FALSE)

#sets air (https://posit-dev.github.io/air/) as formatter
usethis::use_air(vscode = FALSE)

#setup autodetection of global variables
#https://github.com/anthonynorth/roxyglobals
#adds roxygen tag @autoglobal
#add it to every function
roxyglobals::use_roxyglobals()
roxyglobals::options_set_unique(TRUE)
