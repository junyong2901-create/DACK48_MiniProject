import pandas as pd

customers = pd.read_csv(r"C:\Users\dungt\Documents\DA\Python\DAC Python\Customer Master.csv")
employees = pd.read_excel(r"C:\Users\dungt\Documents\DA\Python\DAC Python\Employee.xlsx")
sales = pd.read_csv(r"C:\Users\dungt\Documents\DA\Python\DAC Python\Sales Transaction.csv")

print(employees.info())
print(employees.columns)