# BPJS Chronic Disease Analytics (BigQuery Data Warehouse)

## Overview

This project builds a healthcare analytics warehouse using Indonesian National Health Insurance (BPJS) claims data.

The goal is to:

* Construct a diabetes patient cohort (2017–2025)
* Detect 30-day visit stability gaps
* Identify high-risk chronic patients
* Predict next-year high-cost members

## Architecture

Raw Files → Google Cloud Storage → BigQuery Staging → BigQuery Mart → Analytics / Machine Learning

## Tech Stack

* Google Cloud Storage
* BigQuery
* SQL
* VS Code
* GitHub

## Data Models

### Staging

Cleaned transactional tables derived from raw claims files.

### Mart

Analytical tables:

* Cohort table
* Last visit table
* Chronic risk score

### Analytics

Derived indicators:

* 30-day stability gap
* Readmission risk

## How to Run

1. Upload raw files to GCS
2. Load into staging tables
3. Execute mart SQL scripts

```
bq query --use_legacy_sql=false < sql/mart/mart_cohort.sql
```
