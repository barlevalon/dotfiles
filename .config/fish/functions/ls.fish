function ls --wraps='exa --icons --group-directories-first' --description 'alias ls=exa --icons --group-directories-first'
  eza -a --icons --group-directories-first $argv; 
end
