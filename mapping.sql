CREATE OR REPLACE TABLE `bpjs-kediri.reference.icd10_map` AS
SELECT icd10 AS match_code, icd10, title, chapter_title, block_title FROM `bpjs-kediri.reference.icd10`
UNION ALL
SELECT SUBSTR(icd10,1,4), icd10, title, chapter_title, block_title FROM `bpjs-kediri.reference.icd10`
UNION ALL
SELECT SUBSTR(icd10,1,3), icd10, title, chapter_title, block_title FROM `bpjs-kediri.reference.icd10`;