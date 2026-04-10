# Medicare Claims ETL, Payment Model Evaluation & Policy Simulation (Synthetic Data)

## Overview
This project demonstrates a reproducible, end-to-end analytic workflow for Medicare-style claims data, reflecting the types of analyses conducted in CMS-funded research, quality reporting programs, and value-based payment model evaluation.

The repository integrates data engineering, statistical analysis, and policy simulation to mirror real-world healthcare consulting workflows.

All data in this repository is fully synthetic and generated for demonstration purposes only.

---

## Data Sources (Synthetic)
The project simulates core Medicare claims structures, including:
- Inpatient (IP) claims  
- Outpatient (OP) claims  
- Carrier (Part B) claims  

Each dataset includes representative fields:
- `bene_id` (synthetic beneficiary identifier)  
- `provider_id` (synthetic provider identifier)  
- Dates of service (admit/discharge)  
- Diagnosis categories (simplified)  
- Length of stay / utilization measures  
- Payment amounts  

These structures are designed to approximate CMS VRDC-style analytic datasets.

---

## Tools & Technologies
- **R**: data generation, ETL, statistical analysis, policy simulation  
- **Python**: pipeline processing, quality control, aggregation workflows  
- **Libraries**:  
  - `dplyr`, `ggplot2`  
  - `pandas`, `numpy`, `matplotlib`  

---

## Key Components

### 1. Data Generation
- Creates synthetic Medicare-style claims datasets  
- Simulates realistic variation in utilization, payment, and diagnoses  
- Generates both beneficiary- and provider-level identifiers  

---

### 2. ETL Pipeline (R & Python)
- Cleans and standardizes claims data  
- Constructs analytic datasets from raw claim-level inputs  
- Aggregates data to:
  - Beneficiary (episode-level)
  - Provider level  

---

### 3. Quality Control Checks
Implements CMS-style data validation procedures:
- Missingness assessment  
- Duplicate claim detection  
- Range and outlier checks (e.g., payments)  
- Logical validation (e.g., discharge ≥ admission date)  

---

### 4. Provider Outlier Detection (HQRP-style)
- Aggregates claims to provider-level performance metrics  
- Constructs observed-to-expected (O/E) ratios  
- Identifies high- and low-performing providers using percentile thresholds  
- Simulates quality reporting and oversight logic used in CMS programs  

---

### 5. Payment Model Evaluation
- Builds beneficiary-level “episodes” of care  
- Simulates expected payments using utilization-based adjustment  
- Evaluates performance using O/E ratios  
- Categorizes spending patterns:
  - Above expected  
  - Below expected  
  - Within expected range  

This reflects core evaluation approaches used in CMS Innovation Center models and value-based payment programs.

---

### 6. Policy Impact Simulation
- Tests alternative regulatory thresholds (strict vs. relaxed scenarios)  
- Quantifies impact on:
  - Provider classification rates  
  - Oversight sensitivity  
  - Administrative burden  

- Produces scenario comparison outputs to support policy decision-making  

---

### 7. CMS-Style Policy Memo (RMarkdown)
- Generates a PDF executive summary of findings  
- Translates analytic outputs into policy-relevant insights  
- Demonstrates communication typical of CMS rulemaking and advisory work  

---

## Purpose
This project reflects the full lifecycle of CMS-style analytics:
- Claims data engineering  
- Quality measurement and provider evaluation  
- Payment model assessment  
- Policy simulation and interpretation  

It is designed to demonstrate how quantitative analysis supports federal healthcare policy, program evaluation, and value-based care strategy.

---

## Notes
- All data are synthetic and contain no real beneficiary information  
- The project is intended for demonstration of analytic methods only  
- Methods are simplified representations of CMS workflows and do not replicate official methodologies  

---
