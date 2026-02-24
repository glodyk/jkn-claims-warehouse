SELECT
  nmppklayan,
  diag_primer_group,
  COUNT(DISTINCT nosjp) kasus
FROM `bpjs-kediri.enriched.inacbgs_enriched`
GROUP BY nmppklayan, diag_primer_group
ORDER BY nmppklayan, kasus DESC;