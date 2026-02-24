#!/bin/bash

README="README.md"
TEMP="README_tmp.md"

echo "Updating README table index..."

# Salin bagian awal README (sebelum marker)
awk '/<!-- TABLES_START -->/ {exit} {print}' $README > $TEMP

echo "" >> $TEMP
echo "## Warehouse Tables" >> $TEMP
echo "" >> $TEMP

echo "### Staging Layer" >> $TEMP
echo "" >> $TEMP

for file in docs/staging_*.md
do
    name=$(basename "$file" .md)
    table=${name#staging_}
    echo "- [$table]($file)" >> $TEMP
done

echo "" >> $TEMP
echo "### Mart Layer" >> $TEMP
echo "" >> $TEMP

for file in docs/mart_*.md
do
    name=$(basename "$file" .md)
    table=${name#mart_}
    echo "- [$table]($file)" >> $TEMP
done

echo "" >> $TEMP
echo "<!-- TABLES_START -->" >> $TEMP

mv $TEMP $README

echo "README updated successfully!"