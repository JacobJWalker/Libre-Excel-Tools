# LET4Dates Julian Date Table Generator
# By Jacob J. Walker (although I don't want to fully admit to that!)
# 2018-02-05
#
# This script generates a tibble (dataframe) which contains all dates (pre-Gregorian) 
# from 1 January 0001 
# to 15 October 1582  (the date of Gregorian reform to the Christian calendar)
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
p_load('cwhmisc')

Date_Tibble <- tibble(
  Julian_Daystamp=integer(),
  Date=character(),
  Year=integer(),
  Month=integer(),
  Day=integer()
)

# Determine the Start and End Julian Daystamps
Start_Julian = Dat2Jul(1,1,1)
End_Julian = Dat2Jul(1582,10,15)

for (iteration in Start_Julian:End_Julian) {
  full_date <- Jul2Dat(iteration)
  Date_Tibble <- Date_Tibble %>% add_row(
    Julian_Daystamp=iteration,
    Date=(paste(str_pad(full_date['yr'], width=4, pad=0), "-", str_pad(full_date['mo'], width=2, pad=0), "-", str_pad(full_date['dy'], width=2, pad=0), sep="")),
    Year=full_date['yr'],
    Month=full_date['mo'],
    Day=full_date['dy'])
  if (mod(full_date['yr'],100)==0 & full_date['mo']==1 & full_date['dy']==1) {print(as.integer(full_date['yr']))}
}


