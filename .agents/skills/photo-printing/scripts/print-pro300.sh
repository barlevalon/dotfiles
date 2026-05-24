#!/usr/bin/env bash
set -euo pipefail

QUEUE="Pro300-TurboPrint"
PAGE_SIZE="Letter"
MEDIA_TYPE="CanonPhotoPlusGloss-Semigloss_3"
INPUT_SLOT="ManualFeed"
RESOLUTION="600x600dpi"
COLOR_MODEL="RGB"
COLORSPACE="5" # TurboPrint sRGB
ORIENTATION="4" # landscape
SCALING="none"
DRY_RUN=0

usage() {
  cat <<'EOF'
Usage: print-pro300.sh [options] FILE...

Print image/photo layout pages on Canon PRO-300 via TurboPrint.
Defaults match Alon's working setup: Letter, semigloss, manual feed, landscape, sRGB.

Options:
  --queue NAME          CUPS queue (default: Pro300-TurboPrint)
  --top                 Use top feed
  --manual              Use manual feed (default)
  --letter              Letter page size (default)
  --a4                  A4 page size
  --portrait            Portrait orientation
  --landscape           Landscape orientation (default)
  --resolution VALUE    TurboPrint resolution (default: 600x600dpi)
  --dry-run             Print command, do not run
  -h, --help            Show help

Examples:
  print-pro300.sh print-layouts-letter/pages/page-13.png
  print-pro300.sh --top page.png
EOF
}

files=()
while (($#)); do
  case "$1" in
    --queue) QUEUE=${2:?missing queue}; shift 2 ;;
    --top) INPUT_SLOT="TopFeed"; shift ;;
    --manual) INPUT_SLOT="ManualFeed"; shift ;;
    --letter) PAGE_SIZE="Letter"; shift ;;
    --a4) PAGE_SIZE="A4"; shift ;;
    --portrait) ORIENTATION="3"; shift ;;
    --landscape) ORIENTATION="4"; shift ;;
    --resolution) RESOLUTION=${2:?missing resolution}; shift 2 ;;
    --dry-run) DRY_RUN=1; shift ;;
    -h|--help) usage; exit 0 ;;
    --) shift; files+=("$@"); break ;;
    -*) echo "Unknown option: $1" >&2; usage >&2; exit 2 ;;
    *) files+=("$1"); shift ;;
  esac
done

if ((${#files[@]} == 0)); then
  usage >&2
  exit 2
fi

cmd=(lp -d "$QUEUE"
  -o "PageSize=$PAGE_SIZE"
  -o "MediaType=$MEDIA_TYPE"
  -o "InputSlot=$INPUT_SLOT"
  -o "Resolution=$RESOLUTION"
  -o "ColorModel=$COLOR_MODEL"
  -o "zedoColorspace=$COLORSPACE"
  -o "orientation-requested=$ORIENTATION"
  -o "print-scaling=$SCALING")

for f in "${files[@]}"; do
  if [[ ! -f "$f" ]]; then
    echo "Missing file: $f" >&2
    exit 1
  fi
  if ((DRY_RUN)); then
    printf '%q ' "${cmd[@]}" "$f"
    printf '\n'
  else
    "${cmd[@]}" "$f"
  fi
done

if ((!DRY_RUN)); then
  sleep 1
  lpstat -o 2>/dev/null || true
fi
