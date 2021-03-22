#' parse_trivia_df
#'
#' Generic function for turning either a boolean or multi-choice question into a dataframe with the 'possible_answers' field. Used internally by the {{}} function.
#'
#' @param data A dataframe with either the 'trivia_multi_choice' or 'trivia_boolean' class. Usually this is the output of the `add_trivia_class` function
#'
#' @importFrom dplyr starts_with
#' @noRd
#'
#' @return a list of dataframes
parse_trivia_df <- function(data){
  UseMethod("parse_trivia_df")
}

#' @export
parse_trivia_df.trivia_multi_choice <- function(data){
  united_data <- tidyr::unite(data, col = "possible_answers",
                              5:8, sep = "; ", remove = FALSE)
  united_data <- dplyr::select(united_data, -starts_with("incorrect_"))
  return(united_data)
}

#' @export
parse_trivia_df.trivia_boolean <- function(data){
  data$possible_answers <- "True/False"
  data <- data[c("category", "type", "difficulty",
                 "question", "correct_answer", "possible_answers")]
  return(data)
}

#' @export
parse_trivia_df.default <- function(data){
  return(data)
}

