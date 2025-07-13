function ls --wraps='eza --icons --group-directories-first' --description 'alias ls=eza --icons --group-directories-first'
  eza -a --icons --group-directories-first $argv; 
end
