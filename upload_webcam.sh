#!/bin/bash

# Configuration
IMAGE_PATH="/home/frans/.local/tmp/webcam_live.jpg"
REPO_DIR="/home/frans/webcam"
SSH_REPO_URL="git@github.com:sting-fancy/webcam.git"

git config --global --add safe.directory /home/frans/webcam
git config --global user.email "franslight@gmail.com"
git config --global user.name "sting-fancy"

if [ ! -f "$IMAGE_PATH" ]; then
    echo "Image file not found yet. Waiting for FFmpeg..."
    exit 1
fi

if [ ! -d "$REPO_DIR" ]; then
    cd /home/frans
    git clone "$SSH_REPO_URL"
fi

cp "$IMAGE_PATH" "${REPO_DIR}/live.jpg"

cd "$REPO_DIR"
git add live.jpg
git commit -m "Update webcam snapshot [skip ci]" --quiet
git push origin main --quiet
