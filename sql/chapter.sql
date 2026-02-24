SELECT
  nmppklayan,
  FORMAT_DATE('%Y-%m', DATE(tglplgsjp)) AS bulan,
  diag_primer_chapter,
  COUNT(DISTINCT nosjp) jumlah_kasus
FROM `bpjs-kediri.enriched.inacbgs_enriched`
GROUP BY nmppklayan, bulan, diag_primer_chapter
ORDER BY nmppklayan, bulan, jumlah_kasus DESC;