#!/bin/bash

WORK_DIR="/home/onyxia/work"
GITHUB_REPOSITORY="https://github.com/InseeFrLab/AIML4OS-template-quarto-python.git"
NOTEBOOK_DOWNLOAD_URL="https://inseefrlab.github.io/AIML4OS-template-quarto-python/chapters/chapter1.ipynb"
BUCKET_PATH="s3/donnees-insee/diffusion/ETAT_CIVIL/2020/DECES_COM_1019.csv"
DEST_DIR="$HOME/work/data"
DEST_FILE="$DEST_DIR/$(basename "$BUCKET_PATH")"


# Download the pyproject.toml directly using git
echo $GITHUB_REPOSITORY
git clone --depth 1 $GITHUB_REPOSITORY temp

# Install dependencies in system env
uv pip install -r temp/pyproject.toml --system
rm -rf temp

# Download the dataset
echo "Downloading $BUCKET_PATH to $DEST_FILE..."
mc cp "$BUCKET_PATH" "$DEST_DIR"

# Download the notebook directly using curl
echo $NOTEBOOK_DOWNLOAD_URL
curl -L $NOTEBOOK_DOWNLOAD_URL -o "${WORK_DIR}/exercise.ipynb"

# Ensure Quarto extension is up to date
code-server --install-extension quarto.quarto

# Additional configuration (system libs, etc.)
# sudo apt-get update
# sudo apt-get install ....