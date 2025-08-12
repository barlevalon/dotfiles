function transcode-video-1080p --description "Transcode video to 1080p for sharing"
    if test (count $argv) -eq 0
        echo "Usage: transcode-video-1080p <video-file>"
        return 1
    end
    
    set input_file $argv[1]
    
    if not test -f "$input_file"
        echo "Error: File '$input_file' not found"
        return 1
    end
    
    # Get filename without extension
    set base_name (basename "$input_file" | sed 's/\.[^.]*$//')
    set dir_name (dirname "$input_file")
    set output_file "$dir_name/$base_name-1080p.mp4"
    
    echo "Transcoding '$input_file' to 1080p..."
    echo "Output: $output_file"
    
    # Use ffmpeg to transcode to 1080p with good quality/size balance
    ffmpeg -i "$input_file" \
        -vf scale=1920:1080 \
        -c:v libx264 \
        -preset fast \
        -crf 23 \
        -c:a copy \
        "$output_file"
    
    if test $status -eq 0
        echo "✓ Successfully created: $output_file"
        # Show file sizes for comparison
        set input_size (du -h "$input_file" | cut -f1)
        set output_size (du -h "$output_file" | cut -f1)
        echo "  Original: $input_size → Output: $output_size"
    else
        echo "✗ Transcoding failed"
        return 1
    end
end