# uts-so-09011382530168

## Identitas
- Nama  : Cennya Dwi Anggraini
- NIM   : 09011382530168
- Kelas : SKU3B

## Deskripsi
Proyek ini berisi tiga script untuk mem-backup file catatan praktikum.

- `script/backup.sh`: menyimpan lokasi dalam variabel (`SRC_DIR`, `DEST_DIR`, `LOG_FILE`), membuat `~/backup_09011382530168` dengan `mkdir -p`, lalu mencari semua file `.txt` (termasuk subdirektori) di `~/data_09011382530168` dengan `find`. Daftar hasilnya disimpan ke file teks, lalu diarsipkan dan dikompresi dengan `tar -czvf` menjadi `backup_09011382530168_TANGGAL_JAM.tar.gz`. Isi arsip ditampilkan dengan `tar -tzvf`, dan satu baris log ditambahkan ke `backup.log` dengan `>>`. Format log: `tanggal jam | nama arsip | jumlah file | ukuran`.
- `script/backup_loop.sh`: menjalankan `backup.sh` berulang dengan `while true` dan `sleep`. Jedanya diatur variabel `INTERVAL` (bawaan 60 detik).
- `script/alias.sh`: berisi alias `bk168` untuk menjalankan `backup.sh`. Baris yang sama juga ditambahkan ke `~/.bashrc`.

## Cara menjalankan
```
# backup sekali
./script/backup.sh

# backup berulang di background (jeda bawaan 60 detik)
./script/backup_loop.sh &

# backup berulang dengan jeda 10 detik
INTERVAL=10 ./script/backup_loop.sh &

# hentikan background job
kill %1

# lewat alias (setelah source ~/.bashrc)
bk168
```

## Fitur pengembangan
**Rotasi arsip**: hanya 5 arsip terbaru yang disimpan, arsip yang lebih lama dihapus otomatis di akhir `backup.sh`.

Cara mencoba:
1. Jalankan `bk168` minimal 7 kali (beri jeda 1 detik agar nama arsip berbeda).
2. Jalankan `ls ~/backup_09011382530168/*.tar.gz`.
3. Hasilnya hanya 5 arsip, contohnya:
```
/home/cennya/backup_09011382530168/backup_09011382530168_20261014_154317.tar.gz
/home/cennya/backup_09011382530168/backup_09011382530168_20261014_154320.tar.gz
/home/cennya/backup_09011382530168/backup_09011382530168_20261014_154321.tar.gz
/home/cennya/backup_09011382530168/backup_09011382530168_20261014_154323.tar.gz
/home/cennya/backup_09011382530168/backup_09011382530168_20261014_154324.tar.gz
```

## Bukti job control
Keluaran `tar` yang tercampur di terminal dipotong dan ditandai `[...]`.

```
$ ./backup_loop.sh &
[1] 4688
[... keluaran tar dari backup.sh ...]
$ jobs -l
[1]+  4688 Running                 ./backup_loop.sh &
$ fg
./backup_loop.sh
^Z
[1]+  Stopped                 ./backup_loop.sh
$ bg
[1]+ ./backup_loop.sh &
$ ps x
    PID TTY      STAT   TIME COMMAND
   3458 pts/0    Ss     0:00 bash
   4688 pts/0    S      0:00 /bin/bash ./backup_loop.sh
   4730 pts/0    S      0:00 sleep 60
   4732 pts/0    R+     0:00 ps x
$ kill %1
[1]+  Terminated              ./backup_loop.sh
```
Proses `backup_loop.sh` (PID 4688) dan `sleep 60` terlihat di `ps x`. Setelah `kill %1`, job berstatus Terminated.

## Kendala
1. **`mkdir: cannot create directory ... File exists`** saat membuat `~/data_09011382530168`. Folder itu ternyata sudah ada, jadi saya cek isinya dengan `ls -R` dan hanya melengkapi yang kurang.
2. **Folder `script` tidak muncul di GitHub.** Commit awal hanya berisi `nim.txt` karena Git tidak menyimpan folder kosong. Setelah `backup.sh` dibuat lalu di-`git add`, di-commit, dan di-push, folder `script` muncul.
3. **Keluaran `tar -czvf` dan `tar -tzvf` memenuhi terminal** saat `backup_loop.sh` berjalan di background, sehingga mengetik perintah (`kill`) tercampur dengan keluaran. Saya menghentikan job dengan `kill %1`.
4. **`git push` gagal: `Could not resolve host: github.com`.** Penyebabnya koneksi internet VM terputus. Setelah koneksi pulih, `git push` saya ulang dan berhasil.
5. **`jobs: -1: invalid option`.** Saya salah mengetik `jobs -1` (angka satu), seharusnya `jobs -l` (huruf L).
