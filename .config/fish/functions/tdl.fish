# Create a Tmux Dev Layout with editor, ai, and terminal
function tdl
    if test (count $argv) -lt 1
        echo "Usage: tdl <command> [<second_command>]"
        return 1
    end

    if not set -q TMUX
        echo "You must start tmux to use tdl."
        return 1
    end

    set -l current_dir $PWD
    set -l editor_pane $TMUX_PANE
    set -l ai $argv[1]
    set -l ai2 ""
    if test (count $argv) -ge 2
        set ai2 $argv[2]
    end

    tmux rename-window -t $editor_pane (basename $current_dir)
    set -l ai_pane (tmux split-window -h -p 30 -t $editor_pane -c $current_dir -P -F '#{pane_id}')
    tmux split-window -v -p 15 -t $editor_pane -c $current_dir

    if test -n "$ai2"
        set -l ai2_pane (tmux split-window -v -t $ai_pane -c $current_dir -P -F '#{pane_id}')
        tmux send-keys -t $ai2_pane $ai2 C-m
    end

    tmux send-keys -t $ai_pane "$ai" C-m
    tmux send-keys -t $editor_pane "$EDITOR ." C-m
    tmux select-pane -t $editor_pane
end
