function code_search
  open "https://github.com/search?q=""$argv"&type=code
end

function code_search_xPnA
  set -l encoded_repo_prefix repo%3Asibp%2FxPnA
  code_search $encoded_repo_prefix+$argv
end

function code_search_xPnAOps
  set -l encoded_repo_prefix repo%3Asibp%2FxPnAOps
  code_search $encoded_repo_prefix+$argv
end

abbr -a cs code_search
abbr -a csx code_search_xPnA 
abbr -a cso code_search_xPnAOps

