CREATE OR REPLACE TABLE `bpjs-kediri.cbg_layan.revisit7d_result` AS
SELECT *
FROM `bpjs-kediri.cbg_layan.revisit7d_interval`
WHERE selisih_hari < 7
AND selisih_hari IS NOT NULL
ORDER BY nmppklayan, politujsjp, nokapst, tglplgsjp;