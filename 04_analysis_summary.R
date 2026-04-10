library(dplyr)
library(ggplot2)

claims <- read.csv("data/synthetic_ip_claims.csv")

claims$admit_date <- as.Date(claims$admit_date)

# 1. Total utilization by diagnosis
util_summary <- claims %>%
  group_by(diagnosis) %>%
  summarise(
    total_claims = n(),
    total_payment = sum(payment),
    avg_payment = mean(payment)
  )

print(util_summary)

# 2. Time trend (monthly volume)
claims$month <- format(claims$admit_date, "%Y-%m")

monthly_trend <- claims %>%
  group_by(month) %>%
  summarise(claim_count = n())

ggplot(monthly_trend, aes(x = month, y = claim_count, group = 1)) +
  geom_line() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  ggtitle("Monthly Claims Volume (Synthetic Medicare IP Data)")
