CREATE OR REPLACE VIEW `bpjs-kediri.mart.persalinan_fktp_match_rs` AS
SELECT
  -- identitas
  CAST(nosjp AS STRING) AS nosjp,
  CAST(nokapst AS STRING) AS nokapst,

  CAST(umur AS INT64) AS umur,
  CAST(jkpst AS STRING) AS jkpst,
  CAST(nmtkp AS STRING) AS nmtkp,

  CAST(nmdati2layan AS STRING) AS kabupaten,

  -- ini biasanya penyebab error
  CAST(kdppklayan AS STRING) AS provider_id,
  CAST(nmppklayan AS STRING) AS provider_nama,
  
  -- kolom RS only
  CAST(NULL AS STRING) AS kdinacbgs,
  CAST(NULL AS STRING) AS nminacbgs,

  -- diagnosis
  CAST(kddiagnosa AS STRING) AS kddiagprimer,
  CAST(nmdiagnosa AS STRING) AS nmdiagprimer,
  CAST(NULL AS STRING) AS diagsekunder,
  ARRAY<STRING>[] AS diag_sekunder,
 
  ARRAY<STRING>[] AS prosedur,

  -- tanggal
  DATE(tglkunjungan) AS tgl_masuk,
  DATE(tglpulang) AS tgl_pulang,
  CAST(jenisppklayan AS STRING) AS jenis_faskes,

  CAST(NULL AS STRING) AS diag_primer_clean,
  ARRAY<STRING>[] AS diag_sekunder_kode,
  ARRAY<STRING>[] AS prosedur_kode,

  CAST(nmstatuspulang AS STRING) AS nmjnspulang,

  -- biaya sering numeric di RS
  CAST(biaya AS NUMERIC) AS biayaverifikasi,

  CAST(klasifikasi_kunjungan AS STRING) AS jenis_persalinan

FROM `bpjs-kediri.staging.non_kapitasi_stg1`
WHERE klasifikasi_kunjungan = 'Persalinan';