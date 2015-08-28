#!/usr/bin/env sh

network_down() {
  if host github.com > /dev/null; then
    return 1
  else
    return 0
  fi
}

test -x /usr/bin/git || exit 0

if network_down; then
  echo "Network is down ..."
  if network_down; then
    echo "Still down ... skip ${HOME}/Dotfiles udpate"
    exit 0
  fi
fi

echo "Updating ${HOME}/Dotfiles ..."
git -C "${HOME}/Dotfiles" pull
