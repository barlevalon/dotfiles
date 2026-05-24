function transcode-video-4k --description "Transcode video to optimized 4K for sharing"
    if test (count $argv) -eq 0
        echo "Usage: transcode-video-4k <video-file>"
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
    set output_file "$dir_name/$base_name-optimized.mp4"
    
    echo "Transcoding '$input_file' to optimized 4K..."
    echo "Output: $output_file"
    echo "This may take a while due to slow preset..."
    
    # Use ffmpeg with H.265 for better 4K compression
    ffmpeg -i "$input_file" \
        -c:v libx265 \
        -preset slow \
        -crf 24 \
        -c:a aac \
        -b:a 192k \
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