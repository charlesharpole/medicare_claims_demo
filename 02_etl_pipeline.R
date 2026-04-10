library(dplyr)

ip <- read.csv("data/synthetic_ip_claims.csv")

etl_claims <- ip %>%
  mutate(
    service_year = format(as.Date(admit_date), "%Y"),
    high_cost = ifelse(payment > 15000, 1, 0)
  ) %>%
  group_by(bene_id, service_year) %>%
  summarise(
    total_payment = sum(payment),
    avg_length_stay = mean(length_stay),
    claims_count = n()
  )
