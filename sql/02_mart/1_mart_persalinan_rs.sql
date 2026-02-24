CREATE OR REPLACE TABLE `bpjs-kediri.mart.persalinan_rs` AS

WITH base AS (
SELECT
  nosjp,
  nokapst,
  umur,
  jkpst,
  nmtkp,
  nmdati2layan AS kabupaten,
  kdppklayan AS provider_id,
  nmppklayan AS provider_name,
  kdinacbgs,
  nminacbgs,
  kddiagprimer,
  nmdiagprimer,
  diagsekunder,
  diag_sekunder_kode AS diag_sekunder,
  prosedur_kode AS prosedur,
  tgldtgsjp AS tgl_masuk,
  tglplgsjp AS tgl_pulang,
  diag_primer_clean,
  diag_sekunder_kode,
  prosedur_kode,
  nmjnspulang,
  SAFE_CAST(biayaverifikasi AS NUMERIC) AS biayaverifikasi,

  -- ===== PAKSA SEMUA JADI ARRAY (AMAN UNTUK STRING & ARRAY) =====
  SPLIT(
    REGEXP_REPLACE(TO_JSON_STRING(diag_sekunder_kode), r'[\[\]"]', ''),
    ','
  ) AS diagsek_array,

  SPLIT(
    REGEXP_REPLACE(TO_JSON_STRING(prosedur_kode), r'[\[\]"]', ''),
    ','
  ) AS prosedur_array

FROM `bpjs-kediri.enriched.inacbgs_enriched`
),

-- ================= DETEKSI DELIVERY EVENT =================
flag_persalinan AS (
SELECT *,

CASE
  -- BAYI LAHIR (PALING KUAT)
  WHEN EXISTS (
        SELECT 1
        FROM UNNEST(diagsek_array) d
        WHERE TRIM(d) LIKE 'Z37%'
  ) THEN 1

  -- SC
  WHEN EXISTS (
        SELECT 1
        FROM UNNEST(prosedur_array) p
        WHERE LEFT(TRIM(p),2) = '74'
  ) THEN 1

  -- Forceps/Vacuum
  WHEN EXISTS (
        SELECT 1
        FROM UNNEST(prosedur_array) p
        WHERE LEFT(TRIM(p),2) = '72'
  ) THEN 1

  ELSE 0
END AS is_persalinan

FROM base
),

-- ================= KLASIFIKASI =================
klasifikasi AS (
SELECT *,

CASE

  -- SC
  WHEN EXISTS (
        SELECT 1 FROM UNNEST(prosedur_array) p
        WHERE LEFT(TRIM(p),2) = '74'
  )
       OR diag_primer_clean LIKE 'O82%'
       OR EXISTS (
            SELECT 1 FROM UNNEST(diagsek_array) d
            WHERE TRIM(d) LIKE 'O82%'
         )
  THEN 'SC'

  -- Vacuum/Forceps
  WHEN EXISTS (
        SELECT 1 FROM UNNEST(prosedur_array) p
        WHERE LEFT(TRIM(p),2) = '72'
  )
       OR diag_primer_clean LIKE 'O81%'
       OR EXISTS (
            SELECT 1 FROM UNNEST(diagsek_array) d
            WHERE TRIM(d) LIKE 'O81%'
         )
  THEN 'Vacuum/Forceps'

  -- Multiple
  WHEN diag_primer_clean LIKE 'O84%'
       OR EXISTS (
            SELECT 1 FROM UNNEST(diagsek_array) d
            WHERE TRIM(d) LIKE 'O84%'
         )
  THEN 'Multiple'

  -- NORMAL (Z37 TANPA SC)  ← INI YANG MENYELAMATKAN DATA KAMU
  WHEN EXISTS (
        SELECT 1
        FROM UNNEST(diagsek_array) d
        WHERE TRIM(d) LIKE 'Z37%'
  )
  AND NOT EXISTS (
        SELECT 1
        FROM UNNEST(prosedur_array) p
        WHERE LEFT(TRIM(p),2)='74'
  )
  THEN 'Normal'

  -- fallback O80
  WHEN diag_primer_clean LIKE 'O80%'
       OR EXISTS (
            SELECT 1 FROM UNNEST(diagsek_array) d
            WHERE TRIM(d) LIKE 'O80%'
         )
  THEN 'Normal'

  ELSE 'Other'
END AS jenis_persalinan

FROM flag_persalinan
WHERE is_persalinan = 1
)
,
-- ================= REMOVE DUPLICATE BY NOSJP =================
dedup_nosjp AS (
SELECT *
FROM (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY nosjp
            ORDER BY 
                tgl_pulang DESC,
                biayaverifikasi DESC
        ) AS rn
    FROM klasifikasi
)
WHERE rn = 1
)

SELECT
  nosjp,
  nokapst,
  umur,
  jkpst,
  nmtkp,
  kabupaten,
  provider_id,
  provider_name,
  kdinacbgs,
  nminacbgs,
  kddiagprimer,
  nmdiagprimer,
  diagsekunder,
  diag_sekunder,
  prosedur,
  tgl_masuk,
  tgl_pulang,
  'RS' AS jenis_faskes,
  diag_primer_clean,
  diag_sekunder_kode,
  prosedur_kode,
  nmjnspulang,
  SAFE_CAST(biayaverifikasi AS NUMERIC) AS biayaverifikasi,
  jenis_persalinan
FROM dedup_nosjp;