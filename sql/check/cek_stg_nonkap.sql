SELECT
  COUNT(*) total,
  COUNT(DISTINCT nosjp) uniq_kunjungan
FROM `bpjs-kediri.staging.non_kapitasi_stg`;