function img2jpg --description "Convert image to high-quality JPG"
    magick $argv[1] -quality 95 -strip (string replace -r '\.[^.]+$' '.jpg' $argv[1])
end