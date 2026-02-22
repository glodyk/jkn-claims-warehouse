SELECT
  klasifikasi_kunjungan,
  COUNT(*) AS jml
FROM `bpjs-kediri.staging.non_kapitasi_stg1`
GROUP BY 1
ORDER BY 2 DESC;