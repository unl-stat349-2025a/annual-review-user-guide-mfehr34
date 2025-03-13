
### Data Cleaning - Example
### Author: Mitchell Fehr

# R Version
version # 4.3.1

## Step 0. Import libraries
library(tidyverse)
packageVersion('DescTools') # 0.99.59
library(DescTools)
packageVersion('tidyverse') # 2.0.0


## Step 1. Import data
df <- read_csv("country.csv")
head(df)


## Step 2. Remove duplicates
# Find duplicates
duplicates <- df[duplicated(df),]
duplicates
# Get rid of duplicates
df <- distinct(df)
df


## Step 3. Change Column Data Types
# View types
head(df)
# or
typeof(df$Country)
# Change types
df$ID <- as.character(df$ID)
df$GDPRank <- as.integer(df$GDPRank)
head(df)


## Step 4. Correct Missing Values
# View missing value counts
colSums(is.na(df))

# - 5a. Dropping Columns
df <- select(df, -GDP_Millions)
head(df)

# - 5b. Dropping Rows
df_dropNA <- na.omit(df)
colSums(is.na(df_dropNA)) # should be 0

# - 5c. Imputing Missing Values
# Calculate mean
mean <- mean(df$Population_Millions, na.rm = TRUE)
mean
# Calculate mfv (mode)
mfv <- Mode(df$Continent, na.rm = TRUE)
mfv
# Imputation
df <- mutate(df, Population_Millions = ifelse(is.na(Population_Millions), mean, Population_Millions))
df <- mutate(df, Continent = ifelse(is.na(Continent), mfv, Continent))


# Cleaned dataframe
df





