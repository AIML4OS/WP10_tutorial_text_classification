#!/bin/bash

# Get the name of the repo
MY_REPO=$(ls -d "/home/onyxia/work"/*/ | head -n 1 | xargs basename)

# Install all dependencies in the system folder
uv pip install -r $MY_REPO/pyproject.toml --system

# Download data
sh $MY_REPO/download_data.sh