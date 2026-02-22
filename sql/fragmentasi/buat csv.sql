CREATE OR REPLACE TABLE `bpjs-kediri.audit.revisit7d_for_auditor` AS
SELECT
  * REPLACE(

    -- text protection (biar Excel tidak scientific notation)
    CONCAT("'", nokapst) AS nokapst,
    CONCAT("'", nmppklayan) AS nmppklayan,
    CONCAT("'", politujsjp) AS politujsjp,
    CONCAT("'", namadpjp) AS namadpjp,
    CONCAT("'", kddiagprimer) AS kddiagprimer,
    CONCAT("'", nmdiagprimer) AS nmdiagprimer,
    CONCAT("'", diagsekunder) AS diagsekunder,
    CONCAT("'", prosedure) AS prosedure,
    CONCAT("'", kdinacbgs) AS kdinacbgs,
    CONCAT("'", nminacbgs) AS nminacbgs,
    CONCAT("'", episode_id) AS episode_id,
    CONCAT("'", nosjp) AS nosjp,
    CONCAT("'", nosjp_sebelumnya) AS nosjp_sebelumnya,

    -- tanggal -> format Indonesia + anti auto date Excel
    CONCAT("'", FORMAT_DATE('%d-%m-%Y', tgldtgsjp)) AS tgldtgsjp,
    CONCAT("'", FORMAT_DATE('%d-%m-%Y', tglplgsjp)) AS tglplgsjp,
    CONCAT("'", FORMAT_DATE('%d-%m-%Y', tgl_kunjungan_sebelumnya)) AS tgl_kunjungan_sebelumnya,

    -- angka interval (biar tidak dianggap tanggal)
    CONCAT("'", CAST(selisih_hari AS STRING)) AS selisih_hari

  )
FROM `bpjs-kediri.cbg_layan.revisit7d_audit_detail`;