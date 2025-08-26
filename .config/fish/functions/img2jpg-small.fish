function img2jpg-small --description "Convert image to JPG resized to 1080px max width"
    magick $argv[1] -resize 1080x\> -quality 95 -strip (string replace -r '\.[^.]+$' '.jpg' $argv[1])
end