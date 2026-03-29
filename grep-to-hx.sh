#!/usr/bin/env bash

if [[ "$1" == "--open" ]]; then
  FILE_ABS=$(realpath "$2" 2>/dev/null || echo "$PWD/$2")
  
  tmux send-keys -t '{up-of}' ":" "open $FILE_ABS:$3" Enter
  tmux select-pane -t '{up-of}'
  exit 0
fi

THIS_SCRIPT=$(realpath "$0")

read -p "Search for: " KEYWORD
[[ -z "$KEYWORD" ]] && exit 0

read -e -p "Base directory: " TARGET_DIR
TARGET_DIR=${TARGET_DIR:-.}
TARGET_DIR="${TARGET_DIR/#\~/$HOME}"

rg --color=always --line-number --no-heading --smart-case "$KEYWORD" "$TARGET_DIR" | \
  fzf --ansi \
      --delimiter ':' \
      --preview 'batcat --style=numbers --color=always --highlight-line {2} {1}' \
      --preview-window 'right,50%,+{2}+3/3,~3' \
      --height '100%' \
      --prompt "select: " \
      --bind "enter:execute-silent(bash \"$THIS_SCRIPT\" --open {1} {2})"
