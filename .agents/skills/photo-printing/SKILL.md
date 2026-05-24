---
name: photo-printing
description: Print photos and image files from Alon's Linux system with correct CUPS/TurboPrint options, paper/media/tray selection, color-space handling, one-page test workflow, batching strategy, and printer troubleshooting. Use when printing PNG/JPEG/TIFF/PDF photos or photo layouts.
compatibility: Linux with CUPS. Includes known-good guidance for Canon imagePROGRAF PRO-300 via TurboPrint.
---

# Photo Printing

Use this skill when the user wants to print photos, image files, or photo layouts from this system.

## Principles

- Print **one test page first** before batching.
- Prefer **printer-specific driver queue** over generic driverless IPP for photo media.
- Match **paper size**, **media type**, and **feed source** between job and printer panel.
- Preserve source color space; for normal phone/camera PNG/JPEG output, assume **sRGB** unless evidence says otherwise.
- Avoid silent changes to resolution, scaling, orientation, or media profile. Ask or state exact change.
- For manual-feed photo paper, send pages one at a time unless user explicitly asks to queue multiple jobs.

## Inspect available printers/options

```bash
lpstat -t
lpoptions -p <queue> -l
```

For TurboPrint queues, inspect useful photo options:

```bash
lpoptions -p <queue> -l | rg 'PageSize|MediaType|InputSlot|Resolution|ColorModel|zedoColorspace|Intent'
```

## Known Canon PRO-300 setup

Working photo queue:

```text
Pro300-TurboPrint
```

Prefer this queue for photo paper. Avoid relying on these for serious photo printing:

- `Canon_PRO_300_series`: cups-browsed implicit class; previously stuck with `NO_DEST_FOUND`.
- `Canon_PRO_300_direct`: driverless IPP; media mapping too generic for Canon photo papers.

Known useful TurboPrint options for PRO-300:

```text
PageSize=Letter | A4 | ...
MediaType=CanonPhotoPlusGloss-Semigloss_3
InputSlot=ManualFeed | TopFeed
Resolution=600x600dpi | 601x600dpi | 602x600dpi
ColorModel=RGB
zedoColorspace=5   # sRGB
orientation-requested=4   # landscape
orientation-requested=3   # portrait
print-scaling=none
```

`CanonPhotoPlusGloss-Semigloss_3` matched Canon Photo Paper Plus Semi-gloss better than generic driverless `Photographic`.

## Build a print command

Start from these decisions:

1. Queue: usually `Pro300-TurboPrint` for PRO-300 photos.
2. File path(s): user-provided image/PDF.
3. Paper size: Letter, A4, etc.
4. Media type: exact paper when available.
5. Feed source: ManualFeed or TopFeed.
6. Orientation: portrait or landscape.
7. Scaling: usually `none` for pre-sized layouts; use `fit` only if user wants fit-to-page.
8. Color space: use sRGB (`zedoColorspace=5`) for standard PNG/JPEG unless source/profile says otherwise.

Example for a landscape Letter photo layout on Canon Photo Paper Plus Semi-gloss via manual feed:

```bash
lp -d Pro300-TurboPrint \
  -o PageSize=Letter \
  -o MediaType=CanonPhotoPlusGloss-Semigloss_3 \
  -o InputSlot=ManualFeed \
  -o Resolution=600x600dpi \
  -o ColorModel=RGB \
  -o zedoColorspace=5 \
  -o orientation-requested=4 \
  -o print-scaling=none \
  /path/to/image-or-layout.png
```

Do not treat this as universal. Adjust paper, media, feed, orientation, and scaling to user’s job.

## One-page manual-feed workflow

For manual feed:

1. Confirm settings in words: queue, paper, media, feed, orientation, scaling.
2. Send one page with `lp`.
3. Report job id from command output.
4. User loads sheet / confirms output.
5. Only then send next page.

Check queue:

```bash
lpstat -o
lpstat -p <queue> -l
```

Cancel if needed:

```bash
cancel <job-id>
cancel -a <queue>
```

## Batch workflow

Only batch after one good test print.

For auto-feed or user-approved queueing:

```bash
lp -d <queue> [options...] file1.png file2.png file3.png
```

For manual-feed safety, prefer interactive loop in shell, not a saved script:

```bash
for f in /path/to/pages/*.png; do
  lp -d <queue> [options...] "$f"
  read -p "Load next sheet, press Enter to continue: "
done
```

## Color troubleshooting

If colors look wrong:

1. Verify color space option. For TurboPrint + normal sRGB images:

```bash
-o zedoColorspace=5
```

2. Verify media type matches paper.
3. Verify color mode is RGB, not Gray or proof mode:

```bash
-o ColorModel=RGB
```

4. If blues/cyans are bad, banded, missing, or shifted:
   - run nozzle check
   - inspect cyan / photo cyan / magenta / blue channels
   - clean only if nozzle check shows issue

5. If quality is low but colors correct, discuss resolution before changing:
   - `600x600dpi` normal/medium
   - `601x600dpi` high/1200dpi
   - `602x600dpi` super/1200dpi super

## Paper mismatch troubleshooting

Error `2114` on Canon means job media/size/source does not match printer-registered paper.

Fix order:

1. Confirm printer panel registered paper for the selected feed source.
2. Confirm CUPS job options match: size, media type, input slot.
3. Use TurboPrint queue if driverless queue lacks exact media.
4. As last resort, disable printer panel `Detect paper setting mismatch`.

Do not lie about media type unless user accepts color/ink risk.

## Feed troubleshooting

If printer fails to load paper:

- Stop resending repeated jobs.
- Ask user to verify physical loading:
  - one sheet only for manual feed
  - printable side correct
  - guides snug, not tight
  - paper flat, not curled
  - rear support/output tray open
  - correct tray selected on printer and in job

If job says top feed while trying manual feed, driver/queue ignored feed option. Switch to printer-specific queue (e.g. TurboPrint for PRO-300) and use exact `InputSlot` value from `lpoptions -l`.

## Layout/image sanity checks before printing

Use ImageMagick when available:

```bash
magick identify -format '%f %m %[colorspace] %[type] %wx%h %x %y %[units]\n' file.png
```

Check:

- pixel size matches intended print size and DPI
- colorspace is sRGB/TrueColor for normal color photos
- layout orientation matches print command
- no accidental grayscale conversion
- no unexpected scaling/cropping
