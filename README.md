# Medicare Claims ETL & Quality Check Pipeline (Synthetic Claims Data)

## Overview
This project demonstrates a reproducible workflow for Medicare-style claims data processing, including extraction, transformation, validation, and analysis steps commonly used in CMS-funded research environments.

All data in this repository is fully synthetic and generated for demonstration purposes only.

## Data Sources (Synthetic)
- Inpatient (IP) claims
- Outpatient (OP) claims
- Carrier claims

Each dataset includes common claims fields such as:
- Beneficiary ID (synthetic)
- Dates of service
- Diagnosis codes (simplified)
- Procedure codes
- Payment amounts

## Tools Used
- R (data generation, ETL, analysis)
- Python (QC checks, pipeline automation)
- dplyr / pandas
- ggplot2 / matplotlib

## Key Components

### 1. Data Generation
Simulates Medicare-style claims datasets with realistic structure and variability.

### 2. ETL Pipeline
- Standardizes variable names
- Merges claims types
- Creates analytic-ready longitudinal dataset

### 3. Quality Control Checks
- Missingness checks
- Duplicate claims detection
- Range validation for payments and service dates
- Logical consistency checks (e.g., discharge ≥ admit date)

### 4. Analysis Example
- Basic utilization summaries
- Payment distribution analysis
- Provider-level aggregation (synthetic)

## Purpose
This project reflects the type of data engineering and analytic workflows used in CMS-quality reporting, payment model evaluation, and healthcare policy research.
