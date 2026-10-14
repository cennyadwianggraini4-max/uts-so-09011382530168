#!/bin/bash
# Nama  : Cennya Dwi Anggraini
# NIM   : 09011382530168
# Kelas : SKU3B

# Jeda antar backup (detik), bawaan 60
INTERVAL="${INTERVAL:-60}"
SCRIPT_DIR="$(dirname "$0")"

while true; do
    "$SCRIPT_DIR/backup.sh"
    sleep "$INTERVAL"
done
