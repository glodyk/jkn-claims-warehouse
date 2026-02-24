WITH all_diag AS (
SELECT nosjp, nmppklayan, DATE(tglplgsjp) tgl, diag_primer_clean AS icd
FROM `bpjs-kediri.enriched.inacbgs_enriched`

UNION ALL

SELECT nosjp, nmppklayan, DATE(tglplgsjp), sec
FROM `bpjs-kediri.enriched.inacbgs_enriched`,
UNNEST(diag_sekunder_kode) sec
)

SELECT
  nmppklayan,
  FORMAT_DATE('%Y-%m', tgl) bulan,
  d.chapter_title,
  COUNT(DISTINCT nosjp) kasus
FROM all_diag a
LEFT JOIN `bpjs-kediri.reference.icd10` d
  ON d.icd10 = a.icd
GROUP BY nmppklayan, bulan, d.chapter_title
ORDER BY nmppklayan, bulan, kasus DESC;