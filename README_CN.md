# Claude Code 提示音

中文 | [English](./README.md)

为 Claude Code 添加音效通知。在 Claude 需要你批准权限或执行完毕时播放提示音。

## 环境要求

- **macOS**：系统自带 `afplay`，无需额外安装
- **Linux**：需要 `mpg123` 或 `ffmpeg`（`sudo apt install mpg123` 或 `sudo apt install ffmpeg`）

## 安装

将本仓库地址发给 Claude Code，并说：

> "帮我安装这个：https://github.com/DingDo2333/codebell"

Claude Code 会自动下载音效文件、配置播放脚本并写入 hook。

## 触发时机

| 事件 | 触发条件 |
|---|---|
| Claude 需要你批准工具权限时 | 播放提示音 |
| Claude 执行完毕时 | 播放提示音 |

## 开关提示音

告诉 Claude Code 关闭（或开启）提示音，它会显示当前状态并询问确认。

## 切换音效

告诉 Claude Code 切换提示音，它会列出可用选项：

```
可用音效：

  1. cough    （当前）
  2. chime
  3. pop

请输入编号选择：
```

## 手动安装

1. 复制文件到 `~/.claude/sounds/`：
   ```bash
   mkdir -p ~/.claude/sounds
   curl -L https://raw.githubusercontent.com/DingDo2333/codebell/main/sounds/cough.mp3 -o ~/.claude/sounds/cough.mp3
   curl -L https://raw.githubusercontent.com/DingDo2333/codebell/main/sounds/chime.wav -o ~/.claude/sounds/chime.wav
   curl -L https://raw.githubusercontent.com/DingDo2333/codebell/main/sounds/pop.mp3 -o ~/.claude/sounds/pop.mp3
   curl -L https://raw.githubusercontent.com/DingDo2333/codebell/main/play.sh -o ~/.claude/sounds/play.sh
   chmod +x ~/.claude/sounds/play.sh
   printf "enabled=true\nsound=cough\n" > ~/.claude/sounds/config
   ```

2. 在 `~/.claude/settings.json` 中添加 hook（若文件已存在请注意合并）：
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

3. 重启 Claude Code。

## 卸载

删除 `~/.claude/settings.json` 中的 hook 配置，并删除 `~/.claude/sounds/` 目录。

## License

MIT
