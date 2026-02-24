CREATE OR REPLACE TABLE `bpjs-kediri.mart.provider_risk` AS
SELECT
  provider_id,
  provider_name,
  kabupaten,
  jenis_faskes,

  COUNT(*) AS total_delivery,

  SUM(CASE WHEN anomaly_flag = 'IMPOSSIBLE' THEN 1 ELSE 0 END) AS impossible_case,

  SUM(CASE WHEN anomaly_flag IN ('IMPOSSIBLE','EXTREME') THEN 1 ELSE 0 END) AS high_risk_case,

  SAFE_DIVIDE(
    SUM(CASE WHEN anomaly_flag = 'IMPOSSIBLE' THEN 1 ELSE 0 END),
    COUNT(*)
  ) AS impossible_rate

FROM `bpjs-kediri.mart.patient_anomaly`
GROUP BY provider_id, provider_name, kabupaten, jenis_faskes;