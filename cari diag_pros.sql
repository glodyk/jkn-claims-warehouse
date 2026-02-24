SELECT
  nmppklayan,
  COUNT(DISTINCT nosjp) kasus_transfusi
FROM `bpjs-kediri.enriched.inacbgs_enriched`
WHERE '3995' IN UNNEST(prosedur_kode)
GROUP BY nmppklayan
ORDER BY kasus_transfusi DESC;