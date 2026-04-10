library(dplyr)

# Load synthetic claims data
df <- read.csv("data/synthetic_ip_claims.csv")

# Ensure correct types
df$payment <- as.numeric(df$payment)
df$length_of_stay <- as.numeric(df$length_of_stay)

# ---------------------------------------------------
# Step 1: Define benchmark (fee-for-service proxy)
# ---------------------------------------------------

benchmark <- mean(df$payment, na.rm = TRUE)

# ---------------------------------------------------
# Step 2: Episode-level aggregation (beneficiary level)
# ---------------------------------------------------

episode <- df %>%
  group_by(bene_id) %>%
  summarise(
    total_payment = sum(payment, na.rm = TRUE),
    claim_count = n(),
    avg_los = mean(length_of_stay, na.rm = TRUE)
  ) %>%
  ungroup()

# ---------------------------------------------------
# Step 3: Expected payment under simplified model
# (utilization + intensity adjustment)
# ---------------------------------------------------

episode <- episode %>%
  mutate(
    expected_payment = benchmark * claim_count *
      (avg_los / mean(avg_los, na.rm = TRUE))
  )

# ---------------------------------------------------
# Step 4: Observed-to-Expected (O/E) ratio
# ---------------------------------------------------

episode <- episode %>%
  mutate(
    oe_ratio = total_payment / expected_payment
  )

# ---------------------------------------------------
# Step 5: Payment model performance flags
# ---------------------------------------------------

upper_cut <- quantile(episode$oe_ratio, 0.95, na.rm = TRUE)
lower_cut <- quantile(episode$oe_ratio, 0.05, na.rm = TRUE)

episode <- episode %>%
  mutate(
    performance_flag = case_when(
      oe_ratio > upper_cut ~ "Above Expected Spend",
      oe_ratio < lower_cut ~ "Below Expected Spend",
      TRUE ~ "Within Expected Range"
    )
  )

# ---------------------------------------------------
# Step 6: Policy-style summary output
# ---------------------------------------------------

summary_table <- episode %>%
  group_by(performance_flag) %>%
  summarise(
    count = n(),
    pct = n() / nrow(episode)
  )

print(summary_table)

cat("\nMean O/E Ratio:", mean(episode$oe_ratio, na.rm = TRUE), "\n")

# ---------------------------------------------------
# Step 7: Save results
# ---------------------------------------------------

write.csv(episode, "data/payment_model_evaluation_results.csv", row.names = FALSE)
