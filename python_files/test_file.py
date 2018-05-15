import pandas as pd

df = pd.read_excel('/Users/pnegron/Desktop/2016-stc-category.xls')

pd2 = pd.to_numeric(df['AMOUNT'])


