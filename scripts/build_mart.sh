echo "Building mart tables..."

bq query --use_legacy_sql=false < sql/mart/mart_cohort.sql
bq query --use_legacy_sql=false < sql/mart/mart_last_visit.sql
bq query --use_legacy_sql=false < sql/mart/mart_chronic_score.sql

echo "Mart build completed!"