import pandas as pd

# Load synthetic data
df = pd.read_csv("data/synthetic_ip_claims.csv")

# Standardize columns
df.columns = [c.lower() for c in df.columns]

# Feature engineering
df["admit_date"] = pd.to_datetime(df["admit_date"])
df["discharge_date"] = pd.to_datetime(df["discharge_date"])

df["length_of_stay"] = (df["discharge_date"] - df["admit_date"]).dt.days
df["high_cost_flag"] = (df["payment"] > 15000).astype(int)

# Aggregate at beneficiary level
agg = df.groupby(["bene_id"]).agg(
    total_payment=("payment", "sum"),
    avg_los=("length_of_stay", "mean"),
    claim_count=("payment", "count")
).reset_index()

agg.to_csv("data/etl_output_bene_level.csv", index=False)

print("ETL complete")
