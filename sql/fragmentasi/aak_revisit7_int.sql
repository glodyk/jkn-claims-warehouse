CREATE OR REPLACE TABLE `bpjs-kediri.cbg_layan.revisit7d_interval` AS
SELECT
    nokapst,
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

    nosjp AS nosjp_sekarang,
    tgldtgsjp,
    tglplgsjp,

    LAG(nosjp) OVER (
        PARTITION BY nokapst, nmppklayan, politujsjp
        ORDER BY tgl_pulang
    ) AS nosjp_sebelumnya,

    LAG(tglplgsjp) OVER (
        PARTITION BY nokapst, nmppklayan, politujsjp
        ORDER BY tgl_pulang
    ) AS tgl_kunjungan_sebelumnya,

    DATE_DIFF(
        tgldtgsjp,
        LAG(tglplgsjp) OVER (
            PARTITION BY nokapst, nmppklayan, politujsjp
            ORDER BY tglplgsjp
        ),
        DAY
    ) AS selisih_hari

FROM `bpjs-kediri.cbg_layan.revisit7d_base`;