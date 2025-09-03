#!/bin/bash

WORK_DIR="/home/onyxia/work"
GITHUB_REPOSITORY="https://github.com/aiml4os/WP10_tutorial_text_classification.git"
GITHUB_BRANCH="main"
NOTEBOOK_DOWNLOAD_URL="https://aiml4os.github.io/WP10_tutorial_text_classification/notebooks/chapters/3_RAG/rag_classification.out.ipynb"
DATA_DOWNLOAD_URL="https://github.com/AIML4OS/WP10_tutorial_text_classification/raw/refs/heads/main/chapters/3_RAG/data/NACE_Rev2.1_Structure_Explanatory_Notes_EN.xlsx"
BUCKET_PATH="s3/yulinhuang/tutorial/bert/"
DEST_DIR="$HOME/work/models/localsave/bert"
DEST_FILE="$DEST_DIR/$(basename "$BUCKET_PATH")"


# Download the pyproject.toml directly using git
echo $GITHUB_REPOSITORY
git clone --depth 1 --branch $GITHUB_BRANCH $GITHUB_REPOSITORY temp

# Install dependencies in system env
uv pip install -r temp/pyproject.toml --system
rm -rf temp

# Download the excel data
echo "Downloading excel"
mkdir data/
curl -L $DATA_DOWNLOAD_URL -o "${WORK_DIR}/data/NACE_Rev2.1_Structure_Explanatory_Notes_EN.xlsx"

# Download the notebook directly using curl
echo $NOTEBOOK_DOWNLOAD_URL
curl -L $NOTEBOOK_DOWNLOAD_URL -o "${WORK_DIR}/WP10_tutorial_rag_classification.ipynb"

# Ensure Quarto extension is up to date
code-server --install-extension quarto.quarto

# Additional configuration (system libs, etc.)
# sudo apt-get update
# sudo apt-get install ....