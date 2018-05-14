library(dplyr)
library(ggmap)
library(ggplot2)
library(tidyr)

path <- file.path("~", "Springboard", 
                  "Nutrition__Physical_Activity__and_Obesity_Behavioral_Risk_Factor_Surveillance_System.csv")
print(path)
nutrition<- read.csv(path, stringsAsFactors= FALSE)

dim(nutrition)
nutrition_2011 <- subset(nutrition, YearStart == '2011')
dim(nutrition_2011)
str(nutrition_2011)
del_list <- c('Datasource', 'Class', 'Data_Value_Unit', 'Data_Value_Type', 'Data_Value_Footnote_Symbol',
              'Data_Value_Footnote','GeoLocation', 'ClassID', 'QuestionID', 'DataValueTypeID',
              'LocationID', 'Data_Value_Alt','StratificationCategory1', 'StratificationCategoryId1', 'StratificationID1','YearStart',
              'YearEnd', 'TopicID', 'Topic')
for (x in del_list) {
  nutrition_2011[x] <- NULL
}

nut_male <- ifelse(nutrition_2011$Stratification1 == 'Male', 1, 0)
nut_female <- ifelse(nutrition_2011$Stratification1 == 'Female', 1, 0)
less_hs <- ifelse(nutrition_2011$Stratification1 == 'Less than high school', 1, 0)
hs <- ifelse(nutrition_2011$Stratification1 == 'High school graduate', 1, 0)
some_c <- ifelse(nutrition_2011$Stratification1 == 'Some college or technical school', 1, 0)
cg <- ifelse(nutrition_2011$Stratification1 == 'College graduate', 1, 0)
age18_24 <- ifelse(nutrition_2011$Stratification1 == '18 - 24', 1, 0)
age25_34 <- ifelse(nutrition_2011$Stratification1 == '25 - 34', 1, 0)
age35_44 <- ifelse(nutrition_2011$Stratification1 == '35 - 44', 1, 0)
age45_54 <- ifelse(nutrition_2011$Stratification1 == '45 - 54', 1, 0)
age55_64 <- ifelse(nutrition_2011$Stratification1 == '55 - 64', 1, 0)
age65_older <- ifelse(nutrition_2011$Stratification1 == '65 or older', 1, 0)
income15_24 <- ifelse(nutrition_2011$Stratification1 == '$15,000 - $24,999', 1, 0)
income25_34 <- ifelse(nutrition_2011$Stratification1 == '$25,000 - $34,999', 1, 0)
income35_44 <- ifelse(nutrition_2011$Stratification1 == '$35,000 - $44,999', 1, 0)
income50_74 <- ifelse(nutrition_2011$Stratification1 == '$50,000 - $74,999', 1, 0)
income75_greater <- ifelse(nutrition_2011$Stratification1 == '$75,000 or greater', 1, 0)
nutrition_2011['Male'] <- nut_male
nutrition_2011['Female'] <- nut_female
nutrition_2011['Less than high school'] <- less_hs
nutrition_2011['High school graduate'] <- hs
nutrition_2011['Some college or technical school'] <- some_c
nutrition_2011['College graduate'] <- cg

nutrition_2011['18 - 24'] <- age18_24
nutrition_2011['25 - 34'] <- age25_34
nutrition_2011['35 - 44'] <- age35_44
nutrition_2011['45 - 54'] <- age45_54
nutrition_2011['55 - 64'] <- age45_54
nutrition_2011['65 or older'] <- age65_older

nutrition_2011['18 - 24'] <- income15_24
nutrition_2011['25 - 34'] <- income25_34
nutrition_2011['35 - 44'] <- income35_44
nutrition_2011['50 - 74'] <- income50_74
nutrition_2011['75 or higher'] <- income75_greater

nutrition_2011$Stratification1 <- NULL
del_list2 <- c('Gender', 'Age.years.', 'Income', 'Race.Ethnicity', 'Education' )
for (y in del_list2) {
  nutrition_2011[y] <- NULL
  }
head(nutrition_2011)

# THIS IS NEW CODE
all_males <- nutrition_2011[nutrition_2011$Male == 1, ]
all_females <- nutrition_2011[nutrition_2011$Female == 1, ]

#new_males <- gather(all_males, key , value , Question, -Data_Value)


obese <- ifelse(all_males$Question == 'Percent of adults aged 18 years and older who have obesity', 1, 0)
ow <- ifelse(all_males$Question == 'Percent of adults aged 18 years and older who have an overweight classification', 1, 0) 
no_fruit <- ifelse(all_males$Question == 'Percent of adults who report consuming fruit less than one time daily', 1, 0)
no_veggies <- ifelse(all_males$Question == 'Percent of adults who report consuming vegetables less than one time daily', 1, 0)
level1 <- ifelse(all_males$Question == 'Percent of adults who achieve at least 150 minutes a week of moderate-intensity aerobic physical activity or 75 minutes a week of vigorous-intensity aerobic activity (or an equivalent combination)', 1, 0)
level2 <- ifelse(all_males$Question == 'Percent of adults who achieve at least 150 minutes a week of moderate-intensity aerobic physical activity or 75 minutes a week of vigorous-intensity aerobic physical activity and engage in muscle-strengthening activities on 2 or more days a week', 1, 0)
level3 <- ifelse(all_males$Question == 'Percent of adults who achieve at least 300 minutes a week of moderate-intensity aerobic physical activity or 150 minutes a week of vigorous-intensity aerobic activity (or an equivalent combination)', 1, 0)
level4 <- ifelse(all_males$Question == 'Percent of adults who engage in muscle-strengthening activities on 2 or more days a week', 1, 0)
level5 <- ifelse(all_males$Question == 'Percent of adults who engage in no leisure-time physical activity', 1, 0)
all_males['obese'] <- obese
all_males['ow'] <- ow
all_males['no_fruit'] <- no_fruit
all_males['no_veggies'] <- no_veggies
all_males['level1'] <- level1
all_males['level2'] <- level2
all_males['level3'] <- level3
all_males['level4'] <- level4
all_males['level5'] <- level5
all_males['Question'] <- NULL

#all_males
filter(all_males, no_veggies==1, level1==1)
#obese_males <- all_males[all_males$level5 == 2, ]
##obese_males
#obese_males <- obese_males[obese_males$LocationDesc != 'National',]
#ggplot(obese_males, aes(x=obese_males$Low_Confidence_Limit, y=obese_males$Sample_Size)) + 
#barplot(obese_males, main ="obese_males", xlab="all_males$level5")
#  facet_grid(. ~ sex)
#write.csv(all_males, file='/Users/pnegron/Desktop/all_males_clean.csv')
# This is a changed file
