#' get_questions
#'
#' Document
#'
#' @param number Number of questions to return. Max of 50.
#' @param category Category of questions. Leave blank for random categories.
#' @param difficulty Difficulty of questions.
#' @param type Multiple choice or true/false questions.
#'
#' @return Dataframe of questions and answers
#' @export
#'
#' @examples
#' library(opentriviadb)
#' dat <- get_questions(2, "General Knowledge", "medium", "boolean")
get_questions <- function(number=10,
                          category,
                          difficulty = c("any", "easy", "medium", "hard"),
                          type = c("any", "multiple", "boolean")){
  number <- as.numeric(number)
  difficulty <- match.arg(difficulty)
  type <- match.arg(type)

  if (number > 50){
    stop("Number must be less than or equal to 50", call. = FALSE)
  }

  api_url <- create_api_url(number, category, difficulty, type)

  # Hit API
  #api_reponse <- httr::RETRY(GET, api_url)
  api_response <- httr::GET(api_url)

  # Parse Response
  parsed <- parse_raw_data(api_response)
  parsed_class <- add_trivia_class(parsed)
  parsed_data <- lapply(parsed_class, parse_trivia_df)

  # Bind into single frame
  full_data <- dplyr::bind_rows(parsed_data)


  return(full_data)

}

#' make_category_string
#'
#' Builds a string for the category block of the API
#'
#' @noRd
#' @param category The trivia category
#' @importFrom rlang .data
make_category_string <- function(category){
  if (missing(category)){
    category_string <- ""
  }
  else{
    cats <- get_categories()
    cats <- dplyr::filter(cats, .data$categories == category)
    cats <- dplyr::select(cats, .data$id)
    cats <- cats[1,1]
    category_string <- paste0("&category=", cats)
  }

  return(category_string)
}

make_difficulty_string <- function(difficulty){
  if (difficulty == "any"){
    difficulty_string <- ""
  }
  else{
    difficulty_string <- paste0("&difficulty=", difficulty)
  }

  return(difficulty_string)
}

make_type_string <- function(type){
  if (type == "any"){
    type_string <- ""
  }
  else{
    type_string <- paste0("&type=", type)
  }

  return(type_string)
}

create_api_url <- function(number, category, difficulty, type){
  baseurl <- "https://opentdb.com/api.php?"
  numbered_url <- paste0(baseurl, "amount=", number)

  ## Create strings for API URL
  category_string <- make_category_string(category)
  difficulty_string <- make_difficulty_string(difficulty)
  type_string <- make_type_string(type)

  # Paste URL
  api_url <- paste0(numbered_url,
                    category_string,
                    difficulty_string,
                    type_string)

  return(api_url)
}
