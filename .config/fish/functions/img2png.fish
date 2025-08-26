function img2png --description "Convert image to optimized lossless PNG"
    magick $argv[1] -strip \
        -define png:compression-filter=5 \
        -define png:compression-level=9 \
        -define png:compression-strategy=1 \
        -define png:exclude-chunk=all \
        (string replace -r '\.[^.]+$' '.png' $argv[1])
end