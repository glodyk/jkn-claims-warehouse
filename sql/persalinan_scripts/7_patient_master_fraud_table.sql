CREATE OR REPLACE TABLE `bpjs-kediri.mart.patient_anomaly` AS
SELECT
  a.*,
  b.flag_multi_delivery_year,
  c.flag_double_claim

FROM `bpjs-kediri.mart.patient_anomaly` a
LEFT JOIN `bpjs-kediri.mart.anomali_multi_delivery_year` b
USING(nokapst, nosjp, tgl_pulang)
LEFT JOIN `bpjs-kediri.mart.anomali_double_claim` c
USING(nokapst, nosjp, tgl_pulang);