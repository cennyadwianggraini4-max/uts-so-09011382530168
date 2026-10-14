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
