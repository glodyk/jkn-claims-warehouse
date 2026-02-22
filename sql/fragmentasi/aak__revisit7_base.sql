CREATE OR REPLACE TABLE `bpjs-kediri.cbg_layan.revisit7d_base` AS
WITH dedup AS (
SELECT
    nokapst,
    nosjp,
    nmppklayan,
    politujsjp,
    namadpjp,
    nmtkp,
    kddiagprimer,
    nmdiagprimer,
    diagsekunder,
    prosedure,
    kdinacbgs,
    nminacbgs,
    tgl_pulang,

    DATE(tgldtgsjp) AS tgldtgsjp,
    DATE(tglplgsjp) AS tglplgsjp,

    ROW_NUMBER() OVER (
        PARTITION BY nosjp
        ORDER BY tgl_pulang DESC
    ) AS rn

FROM `bpjs-kediri.staging_inacbgs.inacbgs_stg`

WHERE EXTRACT(YEAR FROM DATE(tgl_pulang)) = 2025

-- HANYA RAWAT JALAN
AND nmtkp = 'RJTL'

-- EXCLUDE POLI: HDL, IRM, IGD
AND NOT REGEXP_CONTAINS(
        LOWER(politujsjp),
        r'hdl|irm|igd'
    )

-- EXCLUDE CKD STAGE 5 (ICD10 N18.5 / N185) DIAG PRIMER
AND NOT REGEXP_CONTAINS(
        LOWER(kddiagprimer),
        r'n18\.?5'
    )

-- EXCLUDE CKD STAGE 5 DIAG SEKUNDER (STRING PANJANG)
AND NOT REGEXP_CONTAINS(
        LOWER(diagsekunder),
        r'n18\.?5'
    )
)

SELECT * EXCEPT(rn)
FROM dedup
WHERE rn = 1;