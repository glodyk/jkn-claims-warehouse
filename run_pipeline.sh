#!/bin/bash

echo "====================================="
echo "BPJS ANALYTICS WAREHOUSE PIPELINE"
echo "====================================="

PROJECT_ID="bpjs-analytics"

echo ""
echo "STEP 1: Building STAGING tables"
echo "--------------------------------"

bq query --use_legacy_sql=false < sql/staging/stg_peserta.sql
bq query --use_legacy_sql=false < sql/staging/stg_kunjungan.sql
bq query --use_legacy_sql=false < sql/staging/stg_diagnosa.sql

echo ""
echo "STEP 2: Building MART tables"
echo "--------------------------------"

bq query --use_legacy_sql=false < sql/mart/mart_cohort.sql
bq query --use_legacy_sql=false < sql/mart/mart_last_visit.sql
bq query --use_legacy_sql=false < sql/mart/mart_chronic_score.sql

echo ""
echo "STEP 3: Analytics Metrics"
echo "--------------------------------"

bq query --use_legacy_sql=false < sql/analytics/stability_gap.sql

echo ""
echo "====================================="
echo "PIPELINE COMPLETED SUCCESSFULLY"
echo "====================================="