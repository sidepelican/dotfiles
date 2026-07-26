#!/bin/sh

DRY_RUN=false

for arg in "$@"; do
  case "$arg" in
    -d|--dry-run)
      DRY_RUN=true
      ;;
  esac
done

if [ "$DRY_RUN" = true ]; then
  echo "dryRun enabled."
fi

do_cmd() {
  printf "\033[36m❯ %s\033[0m\n" "$1"

  if [ "$DRY_RUN" = true ]; then
    return 0
  fi

  eval "$1"
  status=$?
  if [ $status -ne 0 ]; then
    printf "\033[31mError: exit status %d\033[0m\n" "$status"
  fi
}

# ディレクトリ作成
do_cmd 'mkdir -p "$HOME/.config"'
do_cmd 'mkdir -p "$HOME/Library/Application Support/Code/User"'

# シンボリックリンク作成
do_cmd 'ln -ins "$HOME/projects/dotfiles/.vimrc" "$HOME/.vimrc"'
do_cmd 'ln -ins "$HOME/projects/dotfiles/.config/karabiner" "$HOME/.config/karabiner"'
do_cmd 'ln -ins "$HOME/projects/dotfiles/Library/Application Support/Code/User/keybindings.json" "$HOME/Library/Application Support/Code/User/keybindings.json"'
do_cmd 'ln -ins "$HOME/projects/dotfiles/Library/Application Support/Code/User/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"'

