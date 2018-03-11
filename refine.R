# import the dplyr package
library(dplyr)

path <- file.path("~", "ipwsp-aci/springboard_files", "refine.csv")

refine <- read.csv(path, stringsAsFactors= FALSE)

refine_df <- tbl_df(refine)

caps_refine <- mutate(refine_df, company = toupper(company))

print(caps_refine)

df <- caps_refine %>%
  separate("Product.code...number", sep="-", c("Product_code", "Product_number"))

df
df$Product_code <- ifelse(df$Product_code == "p", "SmartPhone", df$Product_code)
df$Product_code <- ifelse(df$Product_code == "v", "TV", df$Product_code)
df$Product_code <- ifelse(df$Product_code == "x", "Laptop", df$Product_code)
df$Product_code <- ifelse(df$Product_code == "q", "Tablet", df$Product_code)
print(df)

paul <- geocode(c(df$address), output = 'latlona', source='google', messaging = FALSE)
df['full_address'] <- paul$address
df  

company_smartphone <- ifelse(df$Product_code == 'SmartPhone', 1, 0)
company_tv <- ifelse(df$Product_code == 'TV', 1, 0)
company_laptop <- ifelse(df$Product_code == 'Laptop', 1, 0)
company_tablet <- ifelse(df$Product_code == 'Tablet', 1, 0)

company_phillips <- ifelse(df$company == 'PHILLIPS', 1, 0)
company_azko <- ifelse(df$company == 'AKZO', 1, 0)
company_houten <- ifelse(df$company == 'VAN_HOUTEN', 1, 0)
company_unilever <- ifelse(df$company == 'UNILEVER', 1, 0)

df['product_smartphone'] <- company_smartphone
df['product_tv'] <- company_tv
df['product'] <- company_laptop
df['product'] <- company_tablet

df['company_philips'] <- company_phillips
df['company_azko'] <- company_azko
df['company_houten'] <- company_houten
df['company_unilever'] <- company_unilever

print(df)

write.csv('/Users/pnegron/Desktop/refine_clean.csv')
