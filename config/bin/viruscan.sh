#!/usr/bin/env bash
################################
# Scan for viruses with clamav #
################################
usage () {
  echo "Usage: ./viruscan.sh DIR"
  echo "Update virus definitions and scan directory."
  echo "Use clamav configuration files for the log file or a SCAN_LOG environment variable."
}
ARG="$1"
if [ "$ARG" == "--help" ] || [ "$ARG" == "-h" ]; then
  usage
  exit 0
elif [ -z "$ARG" ]; then
  echo "Error: must specify a directory to scan."
  usage
  exit 1
fi

if [ -z "$SCAN_LOG" ]; then
  LOG_ARG=""
else
  LOG_ARG="--log=${SCAN_LOG}"
fi

echo "Updating virus definitions and scanning data directory. These run as root, so you will be prompted for your password. The scan runs in the background."

# update virus definitions
sudo nice freshclam

# scan data directory, redirect output to log file but not to stdout
sudo nice nohup clamscan -r "$SCAN_DIR" "$LOG_ARG" &
