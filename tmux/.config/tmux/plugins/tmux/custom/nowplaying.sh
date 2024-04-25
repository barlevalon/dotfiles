#!/usr/bin/env bash

if [ "$(nowplaying-cli get playbackRate)" != "1" ]; then
  echo ""
  exit 0
fi

local artist title
artist="$(nowplaying-cli get artist)"
title="$(nowplaying-cli get title)"

echo "$artist - $title"
