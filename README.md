# Claude Code Sound Notification

[中文](./README_CN.md) | English

A sound notification plugin for Claude Code. Plays an audio cue when Claude needs your permission to use a tool, or when Claude finishes responding.

## Requirements

- **macOS**: built-in `afplay` (no extra install needed)
- **Linux**: `mpg123` or `ffmpeg` (`sudo apt install mpg123` or `sudo apt install ffmpeg`)

## Install

Paste the GitHub URL of this repository into Claude Code and say:

> "Help me install this: https://github.com/DingDo2333/codebell"

Claude Code will automatically download the sound files, set up the play script, and configure the hooks.

## What it does

| Event | Trigger |
|---|---|
| Claude needs permission to use a tool | Plays sound |
| Claude finishes responding | Plays sound |

## Toggle on/off

Tell Claude Code to turn off (or turn on) the notification sound. It will show the current status and ask for confirmation.

## Switch sound

Tell Claude Code to switch the notification sound and it will show you the available options:

```
Available sounds:

  1. cough    (current)
  2. chime
  3. pop

Enter a number to select:
```

## Manual Install

1. Copy files to `~/.claude/sounds/`:
   ```bash
   mkdir -p ~/.claude/sounds
   curl -L https://raw.githubusercontent.com/DingDo2333/codebell/main/sounds/cough.mp3 -o ~/.claude/sounds/cough.mp3
   curl -L https://raw.githubusercontent.com/DingDo2333/codebell/main/sounds/chime.wav -o ~/.claude/sounds/chime.wav
   curl -L https://raw.githubusercontent.com/DingDo2333/codebell/main/sounds/pop.mp3 -o ~/.claude/sounds/pop.mp3
   curl -L https://raw.githubusercontent.com/DingDo2333/codebell/main/play.sh -o ~/.claude/sounds/play.sh
   chmod +x ~/.claude/sounds/play.sh
   printf "enabled=true\nsound=cough\n" > ~/.claude/sounds/config
   ```

2. Add hooks to `~/.claude/settings.json`:
   ```json
   {
     "hooks": {
       "Stop": [
         {
           "hooks": [
             {
               "type": "command",
               "command": "bash ~/.claude/sounds/play.sh"
             }
           ]
         }
       ],
       "PermissionRequest": [
         {
           "hooks": [
             {
               "type": "command",
               "command": "bash ~/.claude/sounds/play.sh"
             }
           ]
         }
       ]
     }
   }
   ```

3. Restart Claude Code.

## Uninstall

Remove the hooks from `~/.claude/settings.json` and delete `~/.claude/sounds/`.

## License

MIT
