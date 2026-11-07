# Download NBA game data (ESPN, via the hoopR package) and save it as a CSV.
# Only needs to be run once; analysis.Rmd reads the CSV in data/ directly.
# install.packages("hoopR")
suppressMessages({library(hoopR); library(tidyverse)})

s <- load_nba_schedule(seasons = 2015:2025)

g <- s |>
  filter(status_type_completed, season_type %in% c(2, 3)) |>   # 2 = regular season, 3 = playoffs
  transmute(game_id, season, game_date = as.Date(game_date),
            season_type = if_else(season_type == 3, "Playoffs", "Regular"),
            home_team = home_abbreviation, away_team = away_abbreviation,
            home_score, away_score, attendance, neutral_site, venue = venue_full_name)

# Drop All-Star games and other games not between the 30 NBA teams
teams <- g |> count(home_team) |> filter(n > 100) |> pull(home_team)
g <- g |>
  filter(home_team %in% teams, away_team %in% teams) |>
  distinct(game_id, .keep_all = TRUE) |>
  arrange(game_date)

dir.create("data", showWarnings = FALSE)
write_csv(g, "data/nba_games_2015_2025.csv")
cat(nrow(g), "games;", length(teams), "teams\n")
