# Claude Code status line — install

This directory holds `statusline.sh`, the script Claude Code runs to render the
status line at the bottom of the interface. The canonical copy lives here in the
dotfiles repo; each machine references it via a symlink from `~/.claude/`.

Once installed, Claude Code will display a status line that looks like
`Opus 4.8 [=                   ] 4.0% (38.5k / 1000.0k)`, showing the model, a
context-usage bar with percentage, the token counts, and the current git branch
when applicable.

## 1. Symlink the script into `~/.claude/`

Point `~/.claude/statusline.sh` at the copy in this repo:

```bash
mkdir -p ~/.claude
ln -sf ~/.dotfiles/claude/statusline.sh ~/.claude/statusline.sh
```

- `ln -s` creates a symlink; `-f` replaces any existing file/symlink at that path.
- The script must be executable (it already is in the repo). If needed:
  `chmod +x ~/.dotfiles/claude/statusline.sh`.

Verify the link resolves and the script runs:

```bash
ls -la ~/.claude/statusline.sh   # should show -> ~/.dotfiles/claude/statusline.sh
echo '{"model":{"display_name":"Opus"},"workspace":{"current_dir":"/tmp"},"context_window":{"used_percentage":1,"total_input_tokens":100,"context_window_size":200000}}' \
  | bash ~/.claude/statusline.sh
```

## 2. Configure `~/.claude/settings.json`

Tell Claude Code to use the script by adding a `statusLine` block to
`~/.claude/settings.json` (merge it into the existing JSON object — don't
overwrite other settings):

```json
{
  "statusLine": {
    "type": "command",
    "command": "~/.claude/statusline.sh"
  }
}
```

- `type: "command"` means "run this shell command."
- `command` points at the symlink, so it works unchanged on every machine.

Settings reload automatically; the new status line appears on your next
interaction with Claude Code.

## Dependencies

The script uses `jq` and `awk`. Install `jq` if it's missing
(`brew install jq` on macOS). `git` is optional — the branch segment is simply
omitted when `git` is missing or the directory isn't a repo.
