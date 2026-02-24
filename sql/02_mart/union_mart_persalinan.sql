CREATE OR REPLACE TABLE `bpjs-kediri.mart.persalinan_all` AS

SELECT *
FROM `bpjs-kediri.mart.persalinan_rs`
WHERE DATE(tgl_pulang) >= DATE '2021-01-01'

UNION ALL

SELECT *
FROM `bpjs-kediri.mart.persalinan_fktp_match_rs`
WHERE DATE(tgl_pulang) >= DATE '2021-01-01';