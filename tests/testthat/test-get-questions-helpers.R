test_that("Category string generates correctly", {
  expect_equal(make_category_string(), "")
  expect_equal(make_category_string("General Knowledge"), "&category=9")
  expect_equal(make_category_string("Sports"), "&category=21")
  expect_equal(make_category_string("Animals"), "&category=27")
})

test_that("Difficulty string generates correctly", {
  expect_equal(make_difficulty_string("any"), "")
  expect_equal(make_difficulty_string("easy"), "&difficulty=easy")
  expect_equal(make_difficulty_string("medium"), "&difficulty=medium")
  expect_equal(make_difficulty_string("hard"), "&difficulty=hard")
  expect_error(make_difficulty_string(), 'argument "difficulty" is missing')
})

test_that("Type string generates correctly", {
  expect_equal(make_type_string("any"), "")
  expect_equal(make_type_string("multiple"), "&type=multiple")
  expect_equal(make_type_string("boolean"), "&type=boolean")
  expect_error(make_type_string(), 'argument "type" is missing')
})

test_that("Create API URL works correctly", {
  expect_equal(
    create_api_url(2, "General Knowledge", "medium", "any"),
    "https://opentdb.com/api.php?amount=2&category=9&difficulty=medium")
  expect_equal(
    create_api_url(15, "Sports", "hard", "boolean"),
    "https://opentdb.com/api.php?amount=15&category=21&difficulty=hard&type=boolean")
  expect_equal(
    create_api_url(15, "Sports", "any", "any"),
    "https://opentdb.com/api.php?amount=15&category=21")
  expect_equal(
    create_api_url(15, difficulty = "any", type = "any"),
    "https://opentdb.com/api.php?amount=15"
  )
})
