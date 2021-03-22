#' parse_raw_data
#'
#' Parses the initial response from the API call. Output can have either 6 columns (boolean question) or 8 columns (multiple choice question).
#'
#' @param unparsed_data The result of a `GET` call to the OpenTriviaDB API
#' @noRd
#'
#' @return A dataframe of either 6 or 8 columns
#'
parse_raw_data <- function(unparsed_data){
  dat_parsed <- httr::content(unparsed_data, 'parsed')
  dat <- dat_parsed$results

  dat <- lapply(dat, function(x){
    as.data.frame(x)
  })

  return(dat)
}

#' add_trivia_class
#'
#' Inspects the dimensions of the returned data to determine whether the question is a multiple choice or a boolean question. This is only ever called internally
#'
#' The API returns with a field for the correct answer, and then either 1 (boolean) or 3 (multiple choice) fields for the incorrect answers. Thus, you can determine what type of question it is by inspecting the dimensions.
#'
#' Since the two types of questions have different fields, a different class is assigned for each type. This is then passed to a relevant s3 method to parse this data into a common form with a 'correct answer' field and an 'incorrect answers' field
#'
#' @param parsed_data The output of `parse_raw_data`
#' @noRd
#'
#' @return A modified dataframe (has classes added)
#'
add_trivia_class <- function(parsed_data) {
  parsed_class <- lapply(parsed_data, function(x){
    dims <- dim(x)
    dims <- dims[2]
    if(dims == 8){
      class(x) <- append("trivia_multi_choice", class(x))
    }
    else if (dims == 6){
      class(x) <- append("trivia_boolean", class(x))
    }
    else {
      stop("Field does not match the attributes of either the multi-choice or the boolean questions. Please file a bug report on github")
    }
    return(x)
  })
}






