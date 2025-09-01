#!/bin/bash

# === Description ===
# This script downloads a data file from an S3 bucket using `mc` (MinIO client)
# and stores it in the ~/work/data directory.

# === Config ===
BUCKET_PATH="s3/donnees-insee/diffusion/ETAT_CIVIL/2020/DECES_COM_1019.csv"
DEST_DIR="$HOME/work/data"
DEST_FILE="$DEST_DIR/$(basename "$BUCKET_PATH")"

# === Ensure destination folder exists ===
mkdir -p "$DEST_DIR"

# === Download the file ===
echo "Downloading $BUCKET_PATH to $DEST_FILE..."
mc cp "$BUCKET_PATH" "$DEST_DIR"

# === Check success ===
if [ $? -eq 0 ]; then
  echo "✅ File downloaded successfully to $DEST_FILE"
else
  echo "❌ Failed to download file from $BUCKET_PATH"
  exit 1
fi
