
<!-- README.md is generated from README.Rmd. Please edit that file -->

# opentriviadb

<!-- badges: start -->
<!-- badges: end -->

The goal of opentriviadb is to provide an R interface to the [Open
Trivia Database](https://opentdb.com/). You can access and download
samples of the questions available and make them available from within
R.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("condwanaland/opentriviadb")
```

## Example

To download questions, simply call `get_questions()`

``` r
library(opentriviadb)
dat <- get_questions(number = 10)
dat
#>                      category     type difficulty
#> 1                         Art multiple       easy
#> 2                     History multiple     medium
#> 3          Science: Computers multiple     medium
#> 4  Entertainment: Video Games multiple     medium
#> 5  Entertainment: Video Games multiple       easy
#> 6            Science & Nature  boolean       easy
#> 7                     Animals multiple       hard
#> 8  Entertainment: Video Games multiple       hard
#> 9                   Geography multiple     medium
#> 10        Entertainment: Film multiple     medium
#>                                                                                                                                    question
#> 1                                                                                                                Who painted the Mona Lisa?
#> 2                                                                                      Who was the first explorer to sail to North America?
#> 3                                                              Which one of these is not an official development name for a Ubuntu release?
#> 4                                                                            What was the name of the first MMORPG to popularize the genre?
#> 5                                                                                                          When was Left 4 Dead 2 released?
#> 6                                                                                          An average human can go two weeks without water.
#> 7                                                                                          Which species is a &quot;mountain chicken&quot;?
#> 8  In the &quot;Ace Attorney&quot; series, who was the truly responsible of the forging of the autopsy report of the pivotal IS-7 incident?
#> 9                                                                    What is the northernmost human settlement with year round inhabitants?
#> 10                                                                              Johnny Depp made his big-screen acting debut in which film?
#>                                                                              possible_answers
#> 1                            Leonardo da Vinci; Pablo Picasso; Claude Monet; Vincent van Gogh
#> 2                    Leif Erikson; Christopher Columbus; Amerigo Vespucci; Ferdinand Magellan
#> 3                                  Mystic Mansion; Trusty Tahr; Utopic Unicorn; Wily Werewolf
#> 4                                   Ultima Online; World of Warcraft; Meridian 59; Guild Wars
#> 5                            November 17, 2009; May 3, 2008; November 30, 2009; June 30, 2010
#> 6                                                                                  True/False
#> 7                                                                   Frog; Chicken; Horse; Fly
#> 8                 Bansai Ichiyanagi; Manfred Von Karma; Gregory Edgeworth; Tateyuki Shigaraki
#> 9  Alert, Canada; Nagurskoye, Russia; McMurdo Station, Antarctica ; Honningsv&aring;g, Norway
#> 10                 A Nightmare on Elm Street; My Bloody Valentine; Halloween; Friday the 13th
#>               correct_answer
#> 1          Leonardo da Vinci
#> 2               Leif Erikson
#> 3             Mystic Mansion
#> 4              Ultima Online
#> 5          November 17, 2009
#> 6                      False
#> 7                       Frog
#> 8          Bansai Ichiyanagi
#> 9              Alert, Canada
#> 10 A Nightmare on Elm Street
```

You can control the category, difficulty, and type (multiple
choice/boolean) of the returned questions

``` r
dat <- get_questions(10, category = "Sports", difficulty = "easy", type = "multiple")
dat
#>    category     type difficulty
#> 1    Sports multiple       easy
#> 2    Sports multiple       easy
#> 3    Sports multiple       easy
#> 4    Sports multiple       easy
#> 5    Sports multiple       easy
#> 6    Sports multiple       easy
#> 7    Sports multiple       easy
#> 8    Sports multiple       easy
#> 9    Sports multiple       easy
#> 10   Sports multiple       easy
#>                                                                         question
#> 1                  In golf, what name is given to a hole score of two under par?
#> 2                               In what sport is a &quot;shuttlecock&quot; used?
#> 3                              Which country has hosted the 2018 FIFA World Cup?
#> 4       Which driver has been the Formula 1 world champion for a record 7 times?
#> 5                                                What team won the 2016 MLS Cup?
#> 6                       What year did the New Orleans Saints win the Super Bowl?
#> 7                 What team did England beat to win in the 1966 World Cup final?
#> 8       In bowling, what is the term used for getting three consecutive strikes?
#> 9  Who is often called &quot;the Maestro&quot; in the men&#039;s tennis circuit?
#> 10                                    Which two teams played in Super Bowl XLII?
#>                                                                                                                                                                                                  possible_answers
#> 1                                                                                                                                                                                 Eagle; Birdie; Bogey; Albatross
#> 2                                                                                                                                                                         Badminton; Table Tennis; Rugby; Cricket
#> 3                                                                                                                                                                    Russia; Germany; United States; Saudi Arabia
#> 4                                                                                                                                                    Michael Schumacher; Ayrton Senna; Fernando Alonso; Jim Clark
#> 5                                                                                                                                                  Seattle Sounders; Colorado Rapids; Toronto FC; Montreal Impact
#> 6                                                                                                                                                                                          2010; 2008; 2009; 2011
#> 7                                                                                                                                                                    West Germany; Soviet Union; Portugal; Brazil
#> 8                                                                                                                                                                                 Turkey; Flamingo; Birdie; Eagle
#> 9                                                                                                                                                          Roger Federer; Bill Tilden; Boris Becker; Pete Sampras
#> 10 The New York Giants &amp; The New England Patriots; The Green Bay Packers &amp; The Pittsburgh Steelers; The Philadelphia Eagles &amp; The New England Patriots; The Seattle Seahawks &amp; The Denver Broncos
#>                                        correct_answer
#> 1                                               Eagle
#> 2                                           Badminton
#> 3                                              Russia
#> 4                                  Michael Schumacher
#> 5                                    Seattle Sounders
#> 6                                                2010
#> 7                                        West Germany
#> 8                                              Turkey
#> 9                                       Roger Federer
#> 10 The New York Giants &amp; The New England Patriots
```

To view all available categories, `opentriviadb` provides a helper
function `get_categories`, which provides a dataframe of all available
categories.

``` r
categories <- get_categories()
categories
#>    id                            categories
#> 1   9                     General Knowledge
#> 2  10                  Entertainment: Books
#> 3  11                   Entertainment: Film
#> 4  12                  Entertainment: Music
#> 5  13    Entertainment: Musicals & Theatres
#> 6  14             Entertainment: Television
#> 7  15            Entertainment: Video Games
#> 8  16            Entertainment: Board Games
#> 9  17                      Science & Nature
#> 10 18                    Science: Computers
#> 11 19                  Science: Mathematics
#> 12 20                             Mythology
#> 13 21                                Sports
#> 14 22                             Geography
#> 15 23                               History
#> 16 24                              Politics
#> 17 25                                   Art
#> 18 26                           Celebrities
#> 19 27                               Animals
#> 20 28                              Vehicles
#> 21 29                 Entertainment: Comics
#> 22 30                      Science: Gadgets
#> 23 31 Entertainment: Japanese Anime & Manga
#> 24 32   Entertainment: Cartoon & Animations
```

## Roadmap

-   Incorporate session tokens to eliminate repeated questions
-   Get more than 50 questions by repeatedly hitting the API and saving
    intermediates
