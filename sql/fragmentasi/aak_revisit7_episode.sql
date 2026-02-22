CREATE OR REPLACE TABLE `bpjs-kediri.cbg_layan.revisit7d_episode` AS
WITH mark AS (
SELECT
    *,
    CASE
        WHEN DATE_DIFF(
            tglplgsjp,
            LAG(tglplgsjp) OVER (
                PARTITION BY nokapst, nmppklayan, politujsjp
                ORDER BY tgl_pulang
            ),
            DAY
        ) > 30
        OR LAG(tglplgsjp) OVER (
                PARTITION BY nokapst, nmppklayan, politujsjp
                ORDER BY tgl_pulang
            ) IS NULL
        THEN 1
        ELSE 0
    END AS new_episode
FROM `bpjs-kediri.cbg_layan.revisit7d_result`
),

grp AS (
SELECT *,
    SUM(new_episode) OVER (
        PARTITION BY nokapst, nmppklayan, politujsjp
        ORDER BY tgl_pulang
    ) AS episode_id
FROM mark
)

SELECT * FROM grp;