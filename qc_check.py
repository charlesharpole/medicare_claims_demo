import pandas as pd

df = pd.read_csv("data/synthetic_ip_claims.csv")

# Missing values
missing = df.isnull().sum()

# Duplicate checks
dupes = df.duplicated().sum()

# Logical checks
invalid_stays = (df["length_stay"] <= 0).sum()

print("Missing:", missing)
print("Duplicates:", dupes)
print("Invalid stays:", invalid_stays)
