#!/bin/bash
# Cross-platform audio player for sound notifications
# Reads ~/.claude/sounds/config to determine which sound and volume to play

SOUNDS_DIR="$(dirname "$0")"
CONFIG_FILE="$SOUNDS_DIR/config"

# Read selected sound from config, default to cough
if [[ -f "$CONFIG_FILE" ]]; then
  SOUND_NAME=$(grep '^sound=' "$CONFIG_FILE" | cut -d'=' -f2)
  VOLUME=$(grep "^volume_${SOUND_NAME}=" "$CONFIG_FILE" | cut -d'=' -f2)
fi
SOUND_NAME="${SOUND_NAME:-cough}"
VOLUME="${VOLUME:-0.3}"

# Find the sound file (support mp3 and wav)
SOUND_FILE=$(find "$SOUNDS_DIR" -maxdepth 1 -name "${SOUND_NAME}.*" | head -1)

if [[ -z "$SOUND_FILE" ]]; then
  exit 1
fi

if [[ "$(uname)" == "Darwin" ]]; then
  afplay -v "$VOLUME" "$SOUND_FILE" &
elif command -v mpg123 &>/dev/null; then
  mpg123 -q "$SOUND_FILE" &
elif command -v ffplay &>/dev/null; then
  ffplay -nodisp -autoexit -loglevel quiet "$SOUND_FILE" &
fi
