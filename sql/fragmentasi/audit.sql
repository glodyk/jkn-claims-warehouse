CREATE OR REPLACE TABLE `bpjs-kediri.cbg_layan.revisit7d_audit_detail` AS
SELECT
    e.nokapst,
    e.nmppklayan,
    e.politujsjp,
    e.namadpjp,
    e.kddiagprimer,
    e.nmdiagprimer,
    e.diagsekunder,
    e.prosedure,
    e.kdinacbgs,
    e.nminacbgs,
    e.episode_id,

    e.nosjp_sekarang AS nosjp,
    e.nosjp_sebelumnya,
    e.tglplgsjp,
    e.tgldtgsjp,
    e.tgl_kunjungan_sebelumnya,
    e.selisih_hari

FROM `bpjs-kediri.cbg_layan.revisit7d_episode` e
JOIN `bpjs-kediri.cbg_layan.revisit7d_3x30d` r
ON  e.nokapst = r.nokapst
AND e.nmppklayan = r.nmppklayan
AND e.politujsjp = r.politujsjp
AND e.episode_id = r.episode_id
ORDER BY
    e.nmppklayan,
    e.politujsjp,
    e.nokapst,
    e.tglplgsjp;