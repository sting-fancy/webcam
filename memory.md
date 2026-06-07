# Current System Architecture

- **Live Stream**: Handled by a long-running `ffmpeg` process. 
  - Command: Uses VAAPI hardware acceleration for encoding.
  - Target: RTMP stream to YouTube.
- **Snapshot Uploads**: Handled by a system cron job.
  - Script: `/home/frans/webcam/upload_webcam.sh`
  - Schedule: Every 5 minutes (`*/5 * * * *`).
  - Logic: Copies snapshot from `/home/frans/.local/tmp/webcam_live.jpg` to the local git repo and pushes to GitHub.

Everything appears stable and verified via logs.

