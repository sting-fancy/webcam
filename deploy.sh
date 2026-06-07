#!/bin/bash

# Deploy script to sync local systemd files to /etc/systemd/system/
# Run this with sudo

set -e

SERVICE_DIR="/home/frans/webcam/systemd"
TARGET_DIR="/etc/systemd/system"

echo "Deploying youtube-stream.service..."
cp "$SERVICE_DIR/youtube-stream.service" "$TARGET_DIR/youtube-stream.service"
chmod 644 "$TARGET_DIR/youtube-stream.service"

echo "Reloading systemd daemon..."
systemctl daemon-reload

echo "Restarting youtube-stream service..."
systemctl restart youtube-stream

echo "Deployment complete."
