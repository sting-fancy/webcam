# 24/7 Live Mountain Stream & Automation Engine

This repository contains the architecture and automation configurations used to continuously broadcast an IP camera feed to YouTube Live, while simultaneously generating a local time-lapse snapshot for automated Git tracking.

---

## 1. Hardware Architecture

* **IP Camera:** Xytron XY-IP Cam
  * **Video Format:** H.265 (HEVC) @ 1440p (2560x1440), 12 FPS
  * **Audio Format:** PCM Alaw (Mono, 8000 Hz)
  * **Connection:** RTSP over TCP (Port 554)
* **Host Server:** HP ProDesk 350 G3 (`hp350`)
  * **OS:** Ubuntu 22.04 LTS
  * **Graphics Processing:** Integrated Intel HD Graphics via `/dev/dri/renderD128` (VAAPI)

---

## 2. Stream & Capture Workflow

The system splits the incoming raw camera feed into two distinct simultaneous outputs:

1. **Output 1: YouTube Live Stream**
   * Transcodes the video down to 1080p H.264 inside GPU VRAM (`h264_vaapi`).
   * Upsamples audio to stereo AAC at 44.1kHz, completely muted (`volume=0.0`).
   * Pushes the live feed via RTMP to YouTube.

2. **Output 2: Local Snapshot**
   * Copies the running video frame out of GPU VRAM down to system memory (`hwdownload`).
   * Drops the frequency down to 1 frame every 60 seconds using `fps=1/60`.
   * Overwrites a static JPEG snapshot file at `~/.local/tmp/webcam_live.jpg`.

---

## 3. Directory Inventory

* `systemd/youtube-stream.service` — Core dual-output hardware acceleration pipeline.
* `upload_webcam.sh` — Automation script executed by cron every 5 minutes.
* `youtube-stream.env.example` — Template mapping required variables without exposing active secrets.
