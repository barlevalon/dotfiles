function transcode-batch --description "Batch transcode multiple files"
    if test (count $argv) -lt 2
        echo "Usage: transcode-batch <type> <files...>"
        echo "Types:"
        echo "  1080p  - Transcode videos to 1080p"
        echo "  4k     - Transcode videos to optimized 4K"
        echo "  jpg    - Convert PNGs to JPG"
        echo ""
        echo "Example: transcode-batch 1080p *.mp4"
        echo "Example: transcode-batch jpg ~/Pictures/*.png"
        return 1
    end
    
    set type $argv[1]
    set files $argv[2..-1]
    
    set count 0
    set total (count $files)
    
    echo "Processing $total files..."
    echo ""
    
    for file in $files
        if test -f "$file"
            set count (math $count + 1)
            echo "[$count/$total] Processing: $file"
            
            switch $type
                case 1080p
                    transcode-video-1080p "$file"
                case 4k
                    transcode-video-4k "$file"
                case jpg
                    transcode-png2jpg "$file"
                case '*'
                    echo "Unknown type: $type"
                    return 1
            end
            
            echo ""
        else
            echo "Skipping (not found): $file"
        end
    end
    
    echo "Batch processing complete: $count files processed"
end