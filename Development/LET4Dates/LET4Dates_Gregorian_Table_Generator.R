# LET4Dates Gregorian Date Table Generator
# By Jacob J. Walker (although I don't want to fully admit to that!)
# 2018-02-03
# 
#
# This script generates a tibble (dataframe) which contains all dates 
# from 15 October 1582 1582 (the date of Gregorian reform to the Christian calendar)
# to 01 January 3000 (pretty far into the future)
# and then exports these to a CSV
#
# This script uses a really really poorly performing algorithm
# but the practical cost of making the script elegant vs. a philosophy of "git 'er done"
# had no contest, when the script only had to run once
#
# Note: The final table in LET4Dates had other scripts involved as well as Excel formulas

# Load Libraries =============================================================
# Loads pacman package manager and then loads packages using pacman
if (!require("pacman")) install.packages("pacman")
library('pacman')
p_load('plyr')
p_load('tidyverse')
p_load('dplyr')
p_load('lubridate')
p_load('stringr')
p_load('testit')
p_load('gmp')

Date_Tibble <- tibble(
  Date=character(),
  Year=integer(),
  Month=integer(),
  Day=integer(),
  Excel_Daystamp=integer(),
  SecondsStamp=character(),
  TSUUID_Timestamp=character()
)

iteration <- -287

for (year_iterator in 1582:3000) {
  for (month_iterator in 1:12) {
    for (day_iterator in 1:31) {
      if(!has_error(as.Date(paste(year_iterator, "-", month_iterator, "-", day_iterator, sep="")))) {
        Temp_Timestamp <- str_pad(as.character(as.bigz(iteration*24*60*60*10000000), b=16), width=15, pad=0)
        Date_Tibble <- Date_Tibble %>% add_row(
          Date=(paste(year_iterator, "-", str_pad(month_iterator, width=2, pad=0), "-", str_pad(day_iterator, width=2, pad=0), sep="")),
          Year=year_iterator,
          Month=month_iterator,
          Day=day_iterator,
          Excel_Daystamp = iteration,
          SecondsStamp = as.character(as.bigz(iteration*24L*60*60)),
          TSUUID_Timestamp = str_c(
            str_sub(Temp_Timestamp, start=1, end=8),
            "-",
            str_sub(Temp_Timestamp, start=9, end=12),
            "-0",
            str_sub(Temp_Timestamp, start=13, end=15))
          )
        iteration <- iteration+1
        }
    }
  }
}

