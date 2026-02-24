#!/bin/bash

PROJECT=$(gcloud config get-value project)

mkdir -p docs

echo "======================================"
echo "Generating BigQuery Data Dictionary"
echo "Project: $PROJECT"
echo "======================================"

generate_dataset_docs () {

    DATASET=$1

    echo ""
    echo "Scanning dataset: $DATASET"

    # ambil daftar tabel
    TABLES=$(bq ls --max_results=1000 --format=prettyjson $PROJECT:$DATASET \
        | jq -r '.[] | select(.type=="TABLE") | .tableReference.tableId')

    for TABLE in $TABLES
    do
        echo "Documenting $DATASET.$TABLE"

        FILE="docs/${DATASET}_${TABLE}.md"

        echo "# Table: $DATASET.$TABLE" > $FILE
        echo "" >> $FILE
        echo "| Column | Type | Mode |" >> $FILE
        echo "|-------|------|------|" >> $FILE

        bq show --format=prettyjson $PROJECT:$DATASET.$TABLE \
        | jq -r '.schema.fields[]? | "| \(.name) | \(.type) | \(.mode) |"' \
        >> $FILE
    done
}

# dataset warehouse kamu
generate_dataset_docs staging
generate_dataset_docs mart
generate_dataset_docs raw
generate_dataset_docs util

echo ""
echo "✔ Data Dictionary Created in /docs"