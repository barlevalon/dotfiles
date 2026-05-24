function transcode-check --description "Check if transcoding tools are installed"
    echo "Checking transcoding tools..."
    echo ""
    
    set missing_tools
    
    # Check for ffmpeg
    if command -v ffmpeg > /dev/null
        set ffmpeg_version (ffmpeg -version 2>&1 | head -1)
        echo "✓ ffmpeg: $ffmpeg_version"
    else
        echo "✗ ffmpeg: NOT INSTALLED"
        set missing_tools $missing_tools ffmpeg
    end
    
    # Check for ImageMagick convert
    if command -v convert > /dev/null
        set convert_version (convert -version | head -1)
        echo "✓ ImageMagick: $convert_version"
    else
        echo "✗ ImageMagick: NOT INSTALLED"
        set missing_tools $missing_tools imagemagick
    end
    
    echo ""
    
    if test (count $missing_tools) -gt 0
        echo "Missing tools detected. Install with:"
        echo "  sudo pacman -S $missing_tools"
        return 1
    else
        echo "All transcoding tools are installed!"
        echo ""
        echo "Available functions:"
        echo "  transcode-video-1080p <file>  - Convert video to 1080p"
        echo "  transcode-video-4k <file>     - Convert video to optimized 4K"
        echo "  transcode-png2jpg <file>      - Convert PNG to JPG"
        echo "  transcode-batch <type> <files> - Batch process multiple files"
    end
end