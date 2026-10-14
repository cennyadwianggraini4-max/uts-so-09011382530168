#!/bin/bash
# Nama  : Nama Lengkap Kamu
# NIM   : 09011382530168
# Kelas : SKU3B

# Variabel
NIM="09011382530168"
SRC_DIR="$HOME/data_$NIM"
DEST_DIR="$HOME/backup_$NIM"
LOG_FILE="$DEST_DIR/backup.log"
LIST_FILE="$DEST_DIR/filelist.txt"

# Buat direktori tujuan
mkdir -p "$DEST_DIR"

# Cari semua file .txt (termasuk subdirektori)
(cd "$SRC_DIR" && find . -type f -name "*.txt") > "$LIST_FILE"

# Buat arsip
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
ARCHIVE_NAME="backup_${NIM}_${TIMESTAMP}.tar.gz"
ARCHIVE_PATH="$DEST_DIR/$ARCHIVE_NAME"
tar -czvf "$ARCHIVE_PATH" -C "$SRC_DIR" -T "$LIST_FILE"

#Verifikasi isi arsip
tar -tzvf "$ARCHIVE_PATH"

# Catat ke log
COUNT=$(wc -l < "$LIST_FILE")
SIZE=$(du -h "$ARCHIVE_PATH" | cut -f1)
echo "$(date '+%Y-%m-%d %H:%M:%S') | $ARCHIVE_NAME | $COUNT | $SIZE" >> "$LOG_FILE"
