EXPORT DATA OPTIONS(
  uri='gs://bpjs-analytics/output/revisit7d_auditor_*.csv',
  format='CSV',
  overwrite=true,
  header=true
)
AS
SELECT * 
FROM `bpjs-kediri.audit.revisit7d_for_auditor`;