#' @title Convert to list
#'
#' @description Convert selected text into an (un)ordered list.
#'
#' \if{html}{
#' \out{
#'  <img src = "https://github.com/ThinkR-open/remedy/blob/master/readme_gif/list.gif?raw=true">
#' }}
#'
#' @return \code{listr()} returns an unordered markdown list
#' @export
#' @importFrom rstudioapi getSourceEditorContext insertText
#' 
listr <- function() add_multiline_prefix('+ ', as_is = FALSE)

#' @return \code{olistr()} returns an ordered markdown list
#' @export
#' @importFrom rstudioapi getSourceEditorContext insertText
#' @rdname listr
olistr <- function() add_multiline_prefix('1. ', as_is = FALSE)
