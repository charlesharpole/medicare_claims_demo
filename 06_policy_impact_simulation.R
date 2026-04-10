library(dplyr)

# Load episode-level results from payment model evaluation
episode <- read.csv("data/payment_model_evaluation_results.csv")

# ---------------------------------------------------
# Step 1: Baseline summary (current policy thresholds)
# ---------------------------------------------------

baseline_summary <- episode %>%
  summarise(
    mean_oe = mean(oe_ratio, na.rm = TRUE),
    pct_high = mean(oe_ratio > 1.2, na.rm = TRUE),
    pct_low  = mean(oe_ratio < 0.8, na.rm = TRUE)
  )

print("Baseline Policy Summary:")
print(baseline_summary)

# ---------------------------------------------------
# Step 2: Simulate alternative policy thresholds
# ---------------------------------------------------
# Scenario A: stricter oversight
strict_high <- 1.1
strict_low  <- 0.9

episode_strict <- episode %>%
  mutate(
    policy_flag = case_when(
      oe_ratio > strict_high ~ "Above Expected Spend",
      oe_ratio < strict_low ~ "Below Expected Spend",
      TRUE ~ "Within Expected Range"
    )
  )

strict_summary <- episode_strict %>%
  summarise(
    pct_high = mean(policy_flag == "Above Expected Spend"),
    pct_low  = mean(policy_flag == "Below Expected Spend")
  )

# ---------------------------------------------------
# Step 3: Simulate relaxed policy thresholds
# ---------------------------------------------------

relaxed_high <- 1.3
relaxed_low  <- 0.7

episode_relaxed <- episode %>%
  mutate(
    policy_flag = case_when(
      oe_ratio > relaxed_high ~ "Above Expected Spend",
      oe_ratio < relaxed_low ~ "Below Expected Range",
      TRUE ~ "Within Expected Range"
    )
  )

relaxed_summary <- episode_relaxed %>%
  summarise(
    pct_high = mean(policy_flag == "Above Expected Spend"),
    pct_low  = mean(policy_flag == "Below Expected Spend")
  )

# ---------------------------------------------------
# Step 4: Compare policy scenarios
# ---------------------------------------------------

policy_comparison <- data.frame(
  Scenario = c("Baseline", "Strict", "Relaxed"),
  High_Pct = c(
    baseline_summary$pct_high,
    strict_summary$pct_high,
    relaxed_summary$pct_high
  ),
  Low_Pct = c(
    baseline_summary$pct_low,
    strict_summary$pct_low,
    relaxed_summary$pct_low
  )
)

print("Policy Impact Comparison:")
print(policy_comparison)

# ---------------------------------------------------
# Step 5: Interpretive output (CMS-style framing)
# ---------------------------------------------------

cat("\nInterpretation:\n")
cat("Stricter thresholds increase the proportion of providers flagged for review,\n")
cat("while relaxed thresholds reduce administrative burden but may decrease sensitivity\n")
cat("for identifying potential over- or under-utilization patterns.\n")

# ---------------------------------------------------
# Step 6: Save outputs
# ---------------------------------------------------

write.csv(policy_comparison, "data/policy_impact_comparison.csv", row.names = FALSE)
