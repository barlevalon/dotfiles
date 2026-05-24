function transcode-png2jpg --description "Convert PNG to JPG (great for wallpapers)"
    if test (count $argv) -eq 0
        echo "Usage: transcode-png2jpg <png-file> [quality]"
        echo "  quality: 1-100 (default: 95)"
        return 1
    end
    
    set input_file $argv[1]
    set quality 95
    
    if test (count $argv) -ge 2
        set quality $argv[2]
    end
    
    if not test -f "$input_file"
        echo "Error: File '$input_file' not found"
        return 1
    end
    
    # Check if it's a PNG file
    if not string match -q "*.png" "$input_file"
        echo "Warning: File doesn't have .png extension"
        read -P "Continue anyway? (y/n) " confirm
        if not string match -q "y*" "$confirm"
            return 1
        end
    end
    
    # Get filename without extension
    set base_name (basename "$input_file" .png)
    set dir_name (dirname "$input_file")
    set output_file "$dir_name/$base_name.jpg"
    
    echo "Converting '$input_file' to JPG..."
    echo "Quality: $quality"
    echo "Output: $output_file"
    
    # Use ImageMagick's magick command (v7) or convert (v6)
    if command -v magick > /dev/null
        magick "$input_file" \
            -quality $quality \
            -strip \
            "$output_file"
    else
        convert "$input_file" \
            -quality $quality \
            -strip \
            "$output_file"
    end
    
    if test $status -eq 0
        echo "✓ Successfully created: $output_file"
        # Show file sizes for comparison
        set input_size (du -h "$input_file" | cut -f1)
        set output_size (du -h "$output_file" | cut -f1)
        echo "  PNG: $input_size → JPG: $output_size"
        
        # Calculate compression ratio
        set input_bytes (stat -c%s "$input_file")
        set output_bytes (stat -c%s "$output_file")
        set ratio (math "round($output_bytes * 100 / $input_bytes)")
        echo "  Size reduced to $ratio% of original"
    else
        echo "✗ Conversion failed"
        return 1
    end
end