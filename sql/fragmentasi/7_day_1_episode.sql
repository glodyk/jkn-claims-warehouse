CREATE OR REPLACE TABLE `bpjs-kediri.cbg_layan.revisit7d_3x30d` AS
SELECT
    nokapst,
    nmppklayan,
    politujsjp,
    episode_id,

    MIN(tglplgsjp) AS tanggal_mulai_episode,
    MAX(tglplgsjp) AS tanggal_akhir_episode,

    COUNT(*) AS jumlah_revisit,
    COUNT(DISTINCT nosjp_sekarang) AS jumlah_kunjungan

FROM `bpjs-kediri.cbg_layan.revisit7d_episode`
GROUP BY nokapst, nmppklayan, politujsjp, episode_id
HAVING COUNT(*) >= 3
ORDER BY jumlah_revisit DESC;