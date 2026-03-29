#!/usr/bin/env bash

if [[ "$1" == "--open" ]]; then
  FILE_ABS=$(realpath "$2" 2>/dev/null || echo "$PWD/$2")
  
  tmux send-keys -t '{up-of}' ":" "open $FILE_ABS:$3" Enter
  tmux select-pane -t '{up-of}'
  exit 0
fi

THIS_SCRIPT=$(realpath "$0")

CURRENT_REL_HOME="${PWD/#$HOME/\~}"

[[ "$CURRENT_REL_HOME" != */ ]] && CURRENT_REL_HOME="${CURRENT_REL_HOME}/"
read -p "Search for: " KEYWORD
KEYWORD=${KEYWORD:-"."}

read -p "Search for "$KEYWORD" in files matching wildcard (default all): " GLOB
GLOB=${GLOB:-"*"}

read -e -i "./" -p "Base directory: " TARGET_DIR

TARGET_DIR=${TARGET_DIR:-.}

rg --color=always --line-number --no-heading --smart-case -g "$GLOB" "$KEYWORD" "$TARGET_DIR" | \
  fzf --ansi \
      --delimiter ':' \
      --preview 'batcat --style=numbers --color=always --highlight-line {2} {1}' \
      --preview-window 'right,50%,+{2}+3/3,~3' \
      --height '100%' \
      --prompt "select: " \
      --bind "enter:execute-silent(bash \"$THIS_SCRIPT\" --open {1} {2})"
