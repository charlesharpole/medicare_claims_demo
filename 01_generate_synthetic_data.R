set.seed(123)

n <- 5000

claims_ip <- data.frame(
  bene_id = sample(1:1000, n, replace = TRUE),
  claim_type = "IP",
  admit_date = sample(seq.Date(as.Date("2022-01-01"), as.Date("2023-12-31"), by="day"), n, replace=TRUE),
  length_stay = sample(1:10, n, replace=TRUE),
  diagnosis = sample(c("CHF", "COPD", "PNEUMONIA", "SEPSIS"), n, replace=TRUE),
  payment = round(runif(n, 5000, 20000), 2)
)

claims_ip$discharge_date <- claims_ip$admit_date + claims_ip$length_stay
