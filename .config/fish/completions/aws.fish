# AWS CLI comes bundled with a completion command.
# https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-completion.html
if type -q aws_completer
    function __aws_completer
        set -lx COMP_LINE (commandline -pc)
        set -lx COMP_POINT (string length $COMP_LINE)
        aws_completer
    end

    complete -c aws -f -a "(__aws_completer)"
    exit 0
end
