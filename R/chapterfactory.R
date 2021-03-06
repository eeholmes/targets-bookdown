# R/chapterfactory.R
#' @title Chapter target factory.
#' @description This one won't work with equations.
#' Define 2 targets:
#' 1. Chapter Rmd file.
#' 2. Render the file.
#' @return A list of target objects.
#' @export
#' @param file Character, data file path.
target_factory <- function(name, dir="chapters") {
  require(magrittr)
  name_chap <- deparse(substitute(name))
  name_file <- paste0(name_chap, "_file")
  sym_file <- as.symbol(name_file)
  outfile <- file.path('rendered-chapters', paste0(name_chap, ".Rmd"))
  command_render <- substitute(
    knit_file <- knitr::knit(file, outfile),
    env = list(file = sym_file, outfile=outfile))
  list(
    tar_target_raw(name_file, file.path(dir, paste0(name_chap, ".Rmd")), format = "file"),
    tar_target_raw(
      name_chap,
      command_render,
      format = 'file'
    )
  )
}