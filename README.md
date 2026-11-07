# Does Home-Court Advantage Disappear Without Fans?

An applied statistics project using NBA data from 2015 to 2025. It uses the COVID-19 era as a
natural experiment to test whether home-court advantage comes from crowds or from
travel and arena familiarity.

**Author:** Nan Xiao

## Research questions

1. Was the home team's winning percentage lower in games played without fans?
2. Does the difference hold after controlling for the relative strength of the two teams?
3. Does playing in the home arena *without* fans still help, compared with the neutral-site 2020 bubble?

## Why COVID creates a natural experiment

| Condition | Fans | Travel advantage | Arena familiarity |
|---|:---:|:---:|:---:|
| Normal games (full crowd) | ✅ | ✅ | ✅ |
| 2020–21 home arena, no fans | ❌ | ✅ | ✅ |
| 2020 Orlando bubble | ❌ | ❌ | ❌ |

## Key findings

| Crowd condition | Games | Home win % | Avg home margin |
|---|---:|---:|---:|
| Full crowd | 12,857 | 57.1% | +2.5 |
| Limited fans | 522 | 58.6% | +2.2 |
| Home arena, no fans | 576 | 50.3% | −0.2 |
| Bubble (neutral, no fans) | 171 | 52.0% | +1.3 |

- Home win rate dropped significantly without fans (two-proportion test, p ≈ 0.002), and so did the home point margin (Welch t-test, p < 0.001).
- After controlling for team strength, the odds of a home win without fans were **0.72×** those with a full crowd (95% CI: 0.60–0.86).
- Home teams playing in their own arena without fans did about as well as "home" teams in the bubble, which suggests **crowds** are the main source of home-court advantage.
- Limitation: home advantage was already declining before COVID (58.6% → 55.5% post-COVID), so the true crowd effect is likely somewhat smaller than the raw gap.

## Methods

- Exploratory data analysis with `ggplot2`
- Two-proportion z-test, Welch two-sample t-test, exact binomial test
- Logistic regression (home win) and linear regression (point margin), controlling for team strength and playoff games
- Model diagnostics: residual plots, Q-Q plot, VIF, and calibration plot

## Project structure

```
nba-home-advantage/
├── analysis.Rmd                    # Main report (code + write-up)
├── analysis.html                   # Rendered report
├── get_data.R                      # Downloads the raw data (run once)
└── data/
    └── nba_games_2015_2025.csv     # 14,126 games, 2014–15 to 2024–25 seasons
```

## How to reproduce

1. Install [R](https://cran.r-project.org) and [RStudio](https://posit.co/download/rstudio-desktop).
2. Install the required packages:
   ```r
   install.packages(c("tidyverse", "broom", "car", "rmarkdown", "knitr"))
   ```
3. Open `analysis.Rmd` in RStudio and click **Knit**.

The data are already included in `data/`. To re-download them, run `get_data.R`, which also needs `install.packages("hoopR")`.

## Data source

Game results and attendance from ESPN, accessed through the [`hoopR`](https://hoopR.sportsdataverse.org) R package.
Covers all completed regular-season and playoff games from the 2014–15 through 2024–25 seasons.
