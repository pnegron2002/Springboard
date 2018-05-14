# import the dplyr package
library(dplyr)
library(ggmap)
library(tidyr)
path <- file.path("~", "Springboard", "titanic3_origiinal.csv")
print(path)
refine2 <- read.csv(path, stringsAsFactors= TRUE)
titanic_table <- tbl_df(refine2)

titanic_table$embarked
summary(titanic_table$embarked)


titanic_table$embarked <- as.character(titanic_table$embarked)
titanic_table$embarked[titanic_table$embarked == ""] <- "S"
titanic_table$embarked <- as.factor(titanic_table$embarked)

titanic_table$embarked
summary(titanic_table$embarked)

# one way to do it!
#titanic_mean <- mean(titanic_table$age, na.rm = TRUE)
#titanic_mean
#titanic_table[c("age")][is.na(titanic_table[c("age")])] <- titanic_mean

titanic_table$age[is.na(titanic_table$age)] <- mean(titanic_table$age, na.rm = TRUE)
titanic_table$age

titanic_table$boat
titanic_table$boat[titanic_table$boat == ""] <- NA
titanic_table$boat

titanic_table$cabin
cabin_number <- ifelse(titanic_table$cabin == "", 0, 1)
titanic_table['has_cabin_number'] <- cabin_number
titanic_table$has_cabin_number

write.csv(titanic_table, file='/Users/pnegron/Desktop/titanic_clean.csv')
