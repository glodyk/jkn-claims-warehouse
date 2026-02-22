-- definisi cohort diabetes
-- exclude: amputasi, gagal ginjal terminal
-- gap stabilitas: 30 hari tanpa kunjungan
-- buat tabel icd chapter 10 dan 9 cm
-- diagnosa syok kardiogenik
-- metafisik
jumlah kasus, biaya tagih, biaya verifikasi
rasio klaim layak per total klaim diajukan
interval pengajuan dan register klaim
-- diagnosa syok kardiogenik
-- potensi prb, ambil cohort diagnosa yang paling banyak
-- metafisik -> saring di pending (ambil metafisik yang baru adalah setelah tanggal klaim pending) dari klaim pending -> sandingkan dengan data all inacbgs lalu tentukan pending, layak, tidak layak buatkan rumus tema utk verifikasi per RS

-- buat datamart fisioterapi > 30 hari adalah episode baru

SELECT 'catatan awal project JKN' AS note;

cari sevel 3, kelompokkan diagnosa, cari yang paling sering menyebabkan sevel naik
kalo sempat cari sevel 2

-- rujukan normal
-- rujukan antar poli
-- rujukan ke rs lain
-- rujukan ke poli igd
-- rujukan nonspesialistik dengan tacc


-- nekrosis pulpa dan pulpitis disertai root canal, menggunakan cohort
--- frekuensi
--- interval
--- distribusi normal dan analisis lain chatgpt

#================
procedure 560 berulang bentuk cohort seperti canal root
ambil semua procedure dipisah dilakukan ranking, count kasus dan nokapst.
hitung kasus terbanyak dan frekuensi tersering per RS. rawat jalan dan rawat inap
#================

readmisi <= 7 hari tanpa lihat diagnosa ~ fragmentasi ranap
readmisi < = 30 hari lihat kemiripan diagnosa (dalam satu cluster) icd


- rujukan antar rs interval <= 3 
-- hari pulang sembuh dan pulang/selain rujuk & meninggal
-- pulang rujuk lihat los dan biaya rumah sakit
-- terlalu sedikit los 1-2 hari (indikasi rujuk tapi dirawat inap dulu)
-- biaya rs limit dengan biaya verifikasi <= 500 ribu (asumsi plafon habis)
ambil nama dokternya (self referral)
ambil nama rs tertinggi yang merujuk (kualitas layanan)
readmisi (kualitas layanan) < 7 hari

persalinan di FKTP tanpa anc (di dorong anc)
persalinan di FKTP anc di fktp dan di RS (normal)
persalinan di RS dibedakan pervaginam dan SC
persalinan di RS anc di rs  > =4 (normal) lihat risiko
persalinan di RS anc di fktp  saja  (anomali)
persalinan RS anc di rs < 4
(anomali)

tonometry pada setiap control paska phaco

Flag Anomali Hip Knee
kdsr = 'RR-04-III-HIP' AND (CONTAINS([Procedure],"8154") OR CONTAINS([Procedure],"8155"))

Flag Appendecomty
CONTAINS([Procedure], "4709") OR
CONTAINS([Procedure], "4719") OR
CONTAINS([Procedure], "4711") OR
CONTAINS([Procedure], "4701")

Flag Braciterapi
CONTAINS([Procedure],'9220') OR 
CONTAINS([Procedure],'9227')

Flag CKD N189
CONTAINS([Diagsekunder],"N189")

Flag HD
CONTAINS([Procedure],'3995')

Flag Graft Aorta
CONTAINS([Procedure],'3973') OR CONTAINS([Procedure],'3971')

Flag Kemoterapi
CONTAINS([Nminacbgs],"KEMOTERAPI")

Flag Tonsilectomy
CONTAINS([Procedure], "Tonsillectomy")

Flag Ventilator >96 jam
CONTAINS([Procedure],'9672')

Flag MRI
CONTAINS([Procedure], "8891") OR
CONTAINS([Procedure], "8892") OR
CONTAINS([Procedure], "8893") OR
CONTAINS([Procedure], "8894") OR
CONTAINS([Procedure], "8895") OR
CONTAINS([Procedure], "8897")

Histerectomy
CONTAINS([Procedure],'hysterectomy') OR 
CONTAINS([Procedure], 'Hysterectomy')


IF CONTAINS([Kddiagprimer],'A09') AND CONTAINS([Diagsekunder],'A01') THEN 'GE-Demam Thyphoid Kode kombinasi dengan A01'
ELSEIF (CONTAINS([Kddiagprimer],'J18') AND CONTAINS([Diagsekunder],'A01')) THEN 'Pneumonia-Demam Thyphoid. Kaidah Koding Dagger asterisk A01†J17*'
ELSEIF ((CONTAINS([Kddiagprimer],'J440') OR CONTAINS([Kddiagprimer],'J448') OR CONTAINS([Kddiagprimer],'J449')) AND CONTAINS([Diagsekunder],'J18')) OR (CONTAINS([Kddiagprimer],'J18') AND (CONTAINS([Diagsekunder],'J440') OR CONTAINS([Diagsekunder],'J448') OR CONTAINS([Diagsekunder],'J449'))) OR ((CONTAINS([Diagsekunder],'J440') OR CONTAINS([Diagsekunder],'J448') OR CONTAINS([Diagsekunder],'J449')) AND CONTAINS([Diagsekunder],'J18')) THEN 'PPOK-Pneumonia. Diagnosa Kombinasi kode dengan J44.0'
ELSEIF (CONTAINS([Kddiagprimer],'J44') AND CONTAINS([Diagsekunder],'J43')) OR (CONTAINS([Kddiagprimer],'J43') AND CONTAINS([Diagsekunder],'J44')) THEN 'PPOK-Emphysema, Koding J44 meng-exclude-kan J43'
ELSEIF (CONTAINS([Kddiagprimer],'N18') AND CONTAINS([Diagsekunder],'I50')) OR (CONTAINS([Kddiagprimer],'I50') AND CONTAINS([Diagsekunder],'N18')) THEN 'CKD-CHF. Perhatikan apakah ada diagnosis HT! Jika ada, dikoding dengan I13.2'
ELSEIF (CONTAINS([Kddiagprimer],'N18') AND CONTAINS([Diagsekunder],'I110')) OR (CONTAINS([Kddiagprimer],'I110') AND CONTAINS([Diagsekunder],'N18')) THEN 'CKD-HHD-CHF, kode gabungan I13.2'
ELSEIF (CONTAINS([Kddiagprimer],'I111') OR CONTAINS([Kddiagprimer],'I130') OR CONTAINS([Kddiagprimer],'I132')) AND CONTAINS([Diagsekunder],'J81') OR (CONTAINS([Diagsekunder],'I111') OR CONTAINS([Diagsekunder],'I130') OR CONTAINS([Diagsekunder],'I132')) AND CONTAINS([Kddiagprimer],'J81') THEN 'HHD-Renal Diease-Pulmonary Edema, J81 tidak perlu coding lagi'
ELSEIF (CONTAINS([Kddiagprimer],'N20') AND (CONTAINS([Diagsekunder],'N10') OR CONTAINS([Diagsekunder],'N11') OR CONTAINS([Diagsekunder],'N12'))) OR ((CONTAINS([Kddiagprimer],'N10') OR CONTAINS([Kddiagprimer],'N11') OR CONTAINS([Kddiagprimer],'N12')) AND CONTAINS([Diagsekunder],'N20')) THEN 'BSK-Pyelonephritis, Code gabungan N20.9'
ELSEIF (CONTAINS([Kddiagprimer],'N20') AND CONTAINS([Diagsekunder],'N13')) OR (CONTAINS([Kddiagprimer],'N13') AND CONTAINS([Diagsekunder],'N20')) THEN 'BSK-Hydronefrosis, Code gabungan N13.2'
ELSEIF (CONTAINS([Kddiagprimer],'N132') AND CONTAINS([Diagsekunder],'N39')) OR  (CONTAINS([Kddiagprimer],'N39') AND CONTAINS([Diagsekunder],'N13.2')) THEN 'BSK-Hydronefrosis-ISK, Code gabungan N13.6'
ELSEIF (CONTAINS([Kddiagprimer],'N20') OR CONTAINS([Kddiagprimer],'N21') OR CONTAINS([Kddiagprimer],'N22') OR CONTAINS([Kddiagprimer],'N23')) AND CONTAINS([Diagsekunder],'N39') THEN 'BSK-ISK, N39.0 tidak perlu coding lagi'
ELSEIF CONTAINS([Kddiagprimer],'Z47') AND (CONTAINS([Code 2],'S') OR CONTAINS([Code 2],'T')) OR [Nmtkp]='RITP' THEN 'Aff Pen-Fracture / Aff Implant Union Fracture, Fracture tidak perlu dicoding lagi' 
ELSEIF (CONTAINS([Code 1],'S') OR CONTAINS([Code 1],'T') OR CONTAINS([Code 1],'O')) AND CONTAINS([Diagsekunder],'R57') THEN 'Code S/T/O - R57, R57 pada trauma dicoding T79.4 dan pada Persalinan O75.1'
ELSEIF CONTAINS([Kddiagprimer],'B20') AND (CONTAINS([Diagsekunder],'A15') OR CONTAINS([Diagsekunder],'A16')) THEN 'HIV-TB, Kode gabungan cukup B20.0'
ELSEIF ((CONTAINS([Kddiagprimer],'K35') OR CONTAINS([Kddiagprimer],'K36') OR CONTAINS([Kddiagprimer],'K37')) AND CONTAINS([Diagsekunder],'K65')) OR (CONTAINS([Kddiagprimer],'K65') AND (CONTAINS([Diagsekunder],'K35') OR CONTAINS([Diagsekunder],'K36') OR CONTAINS([Diagsekunder],'K37]'))) THEN 'Acute App - Peritonitis, Code gabungan K35.2/K35.3'
ELSEIF (CONTAINS([Kddiagprimer],'A15') OR CONTAINS([Kddiagprimer],'A16')) AND CONTAINS([Diagsekunder],'J47') THEN 'TB - Bronchiectasis, Harusnya cukup Satu Code A15 atau A16 saja karena sudah include'
ELSEIF (CONTAINS([Kddiagprimer],'A15') OR CONTAINS([Kddiagprimer],'A16')) AND CONTAINS([Diagsekunder],'J93') OR (CONTAINS([Diagsekunder],'A15') OR CONTAINS([Diagsekunder],'A16')) AND CONTAINS([Kddiagprimer],'J93') THEN 'TB - Pneumothorax, Harusnya cukup Satu Code A15 atau A16 saja karena sudah include'
ELSEIF (CONTAINS([Diagsekunder],'O0') OR CONTAINS([Diagsekunder],'O1') OR  CONTAINS([Diagsekunder],'O2') OR CONTAINS([Diagsekunder],'O3') OR  CONTAINS([Diagsekunder],'O4') OR CONTAINS([Diagsekunder],'O5') OR  CONTAINS([Diagsekunder],'O6') OR CONTAINS([Diagsekunder],'O7') OR  CONTAINS([Diagsekunder],'O8') OR CONTAINS([Diagsekunder],'O9'))  AND NOT CONTAINS([Code 1],'O') AND [Kdcmg] = 'O' THEN 'Selain O-Kehamilan, Untuk kasus kehamilan seharusnya yang menjadi DU adalah koding O'
ELSEIF CONTAINS([Code 1],'P') AND (CONTAINS([Diagsekunder],'G91') OR CONTAINS([Diagsekunder],'A41') OR CONTAINS([Diagsekunder],'R09') OR CONTAINS([Diagsekunder],'B37')) THEN 'Code P - G91/A41/R09/B37, G91 pada neonatus menggunakan coding Q03, A41.9 pada neonatus menggunakan P36, R09.0 pada neonatus menggunakan P21, B37 pada neonatus menggunakan P37.5'
ELSEIF (CONTAINS([Diagsekunder],'P0') OR CONTAINS([Diagsekunder],'P1') OR CONTAINS([Diagsekunder],'P2') OR CONTAINS([Diagsekunder],'P3') OR CONTAINS([Diagsekunder],'P4') OR CONTAINS([Diagsekunder],'P5') OR CONTAINS([Diagsekunder],'P6') OR CONTAINS([Diagsekunder],'P7') OR CONTAINS([Diagsekunder],'P8') OR CONTAINS([Diagsekunder],'P9')) AND NOT (CONTAINS([Kddiagprimer],'P') OR CONTAINS([Kddiagprimer],'Q')) AND [Nmtkp]='RITL' AND [Umur]=0 THEN 'Selain P dan Q - Code P, seharusnya coding DU juga menggunakan coding P atau Q'
ELSEIF CONTAINS([Code 1],'C') AND CONTAINS([Diagsekunder],'J90')  THEN 'Kanker - Efusi Pleura, C78.2 sebagai diagnosa sekunder untuk J90 pada kasus keganasan bronchus dan paru'
ELSEIF ((CONTAINS([Kddiagprimer],'I51') OR CONTAINS([Kddiagprimer],'I110')  OR CONTAINS([Kddiagprimer],'I130') OR CONTAINS([Kddiagprimer],'I132')  OR CONTAINS([Kddiagprimer],'I139')) AND CONTAINS([Diagsekunder],'J81'))  OR  ((CONTAINS([Diagsekunder],'I51') OR CONTAINS([Diagsekunder],'I110')  OR CONTAINS([Diagsekunder],'I130') OR CONTAINS([Diagsekunder],'I132')  OR CONTAINS([Diagsekunder],'I139')) AND CONTAINS([Diagsekunder],'J81'))  OR  ((CONTAINS([Diagsekunder],'I51') OR CONTAINS([Diagsekunder],'I110')  OR CONTAINS([Diagsekunder],'I130') OR CONTAINS([Diagsekunder],'I132')  OR CONTAINS([Diagsekunder],'I139')) AND CONTAINS([Kddiagprimer],'J81')) THEN 'J81 dgn Heart Disease/Heart Failure, J81 tidak perlu dikoding lagi'
ELSEIF CONTAINS([Kddiagprimer],'I517') AND (CONTAINS([Diagsekunder],'I50') OR CONTAINS([Diagsekunder],'I514') OR CONTAINS([Diagsekunder],'I515')  OR CONTAINS([Diagsekunder],'I516') OR CONTAINS([Diagsekunder],'I517') OR CONTAINS([Diagsekunder],'I518') OR CONTAINS([Diagsekunder],'I519') OR CONTAINS([Diagsekunder],'I11') OR CONTAINS([Diagsekunder],'I13')) THEN 'Cardiomegali - Jantung, Cardiomegali I51.7 tidak perlu dicoding lagi'
ELSEIF CONTAINS([Kddiagprimer],'J40') AND CONTAINS([Diagsekunder],'J45') THEN 'Asthma - Bronkitis, Kode gabungan  J45.9'
ELSEIF (CONTAINS([Kddiagprimer],'N11') OR CONTAINS([Kddiagprimer],'N12')) AND CONTAINS([Diagsekunder],'N20') THEN 'Nephritis - Batu Ginjal dan Ureter, Kode gabungan N20.9'
ELSEIF CONTAINS([Diagsekunder],'J18') AND (CONTAINS([Diagsekunder],'A15') OR CONTAINS([Diagsekunder],'A16')) THEN 'J18 - A15/A16, Kode Gabungan cukup coding A15/A16'
ELSEIF CONTAINS([Kddiagprimer],'O410') AND CONTAINS([Diagsekunder],'O421') THEN 'O41.0 - O42.1, Kode gabungan O42.1'
ELSEIF (CONTAINS([Kddiagprimer],'B200') AND CONTAINS([Diagsekunder],'B206')) OR (CONTAINS([Diagsekunder],'B200') AND CONTAINS([Diagsekunder],'B206')) THEN 'HIV TB- HIV Pneumonia Kode gabungan B20.0'
ELSEIF ([Kddiagprimer]="E105" OR [Kddiagprimer]="E115" OR [Kddiagprimer]="E135" OR [Kddiagprimer]="E145") AND (CONTAINS([Diagsekunder],"R02") OR CONTAINS([Diagsekunder],"L97") OR CONTAINS([Diagsekunder],"L98")) AND [Nmtkp]="RITL" THEN  "Cek seharusnya pada DU DM komplikasi gangrene dengan kode L97-98 atau R02 tidak perlu dikode sebagai DS"
ELSEIF [Kddiagprimer]="J90" AND (CONTAINS([Diagsekunder],"A15") OR CONTAINS([Diagsekunder],"A16"))  AND [Nmtkp]="RITL" THEN "HAPUS J90 sebagai DU karena exclude pada A15-A16"
ELSEIF (CONTAINS([Kddiagprimer],"N11") OR CONTAINS([Kddiagprimer],"N12")) AND CONTAINS([Kddiagprimer],"N20") THEN "Nephritis - Batu Ginjal dan Ureter. Kode gabungan N20.9"
ELSEIF CONTAINS([Diagsekunder],"J18") AND (CONTAINS([Diagsekunder],"A15") OR CONTAINS([Diagsekunder],"A16")) AND [Nmtkp]="RITL" THEN "Pneumonia dengan TB. Kode Gabungan cukup A15 atau A16"
ELSEIF CONTAINS([Kddiagprimer],"O410") AND CONTAINS([Diagsekunder],"O42") AND [Nmtkp]="RITL" THEN "Oligohidroamnion dengan KPD. Kode gabungan O42.-"
ELSEIF ((CONTAINS([Kddiagprimer],"K631") AND CONTAINS([Diagsekunder],"K352")) OR (CONTAINS([Diagsekunder],"K631") AND CONTAINS([Kddiagprimer],"K352"))) AND [Nmtkp]="RITL" THEN "Appendicitis dengan Perforasi.Kondisi peritonitis dan atau perforasi, abses peritoneal yang disertai apendisitis cukup menggunakan kode gabungan K35.-"
DIAGKOMBINASI

ELSEIF (CONTAINS([Kddiagprimer],"A15") OR CONTAINS([Kddiagprimer],"A16")) AND CONTAINS([Diagsekunder],"J90") OR ((CONTAINS([Diagsekunder],"A15") OR CONTAINS([Diagsekunder],"A16")) AND CONTAINS([Kddiagprimer],"J90"))  THEN "Tb dengan Efusi Pleura. J90 tidak dikoding terpisah jika ada TB"
ELSEIF CONTAINS([Kddiagprimer],"O") AND (CONTAINS([Diagsekunder],"N30") OR CONTAINS([Diagsekunder],"N31") OR CONTAINS([Diagsekunder],"N32") OR CONTAINS([Diagsekunder],"N33") OR CONTAINS([Diagsekunder],"N34") OR CONTAINS([Diagsekunder],"N35")) AND [Nmtkp]="RITL" THEN "Urinary Tract Infection pada Kehamilan. ISK pada kehamilan menggunakan kode O"
ELSEIF (CONTAINS([Kddiagprimer],"G72") AND (CONTAINS([Diagsekunder],"E875") OR CONTAINS([Diagsekunder],"E876"))) OR (CONTAINS([Diagsekunder],"G72") AND (CONTAINS([Kddiagprimer],"E875") OR CONTAINS([Kddiagprimer],"E876"))) THEN "Kondisi kelemahan otot diakibatkan myotonic atau angguan kalemic  sudah termasuk dalam kode G723- (periodic paralysis)"
ELSEIF CONTAINS([Kddiagprimer],"E116") AND CONTAINS([Diagsekunder],"I2") AND [Nmtkp]="RITL" THEN "DM tipe 2 tidak seharusnya menjadi DU. Cek apakah DM berhubungan dengan Jantung pada Resume Medis. Jika DM komplikasi Jantung cukup E11.6, penyakit jantung iskemik tidak perlu dikode. Jika jantung bukan karena komplikasi DM maka kode jantung menjadi DU, DM tanpa komplikasi menjadi DS"
END
