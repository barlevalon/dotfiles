function dots -w git
 git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME $argv
end

function ldots -w lazygit
  lazygit --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME $argv
end