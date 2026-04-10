library(dplyr)
library(lubridate)

claims <- read.csv("data/synthetic_ip_claims.csv")

# 1. Missingness check
missing_summary <- sapply(claims, function(x) sum(is.na(x)))

# 2. Duplicate claims check
duplicate_count <- sum(duplicated(claims))

# 3. Logical consistency checks
claims_clean <- claims %>%
  mutate(
    admit_date = as.Date(admit_date),
    discharge_date = as.Date(discharge_date),
    invalid_stay = ifelse(discharge_date < admit_date, 1, 0)
  )

invalid_stays <- sum(claims_clean$invalid_stay)

# 4. Range checks (payment sanity)
outlier_payments <- sum(claims$payment < 0 | claims$payment > 50000)

# Output summary
qc_report <- list(
  missing = missing_summary,
  duplicates = duplicate_count,
  invalid_stays = invalid_stays,
  outlier_payments = outlier_payments
)

print(qc_report)
