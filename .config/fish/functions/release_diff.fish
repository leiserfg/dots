# Defined in /tmp/fish.2wxrHE/release_diff.fish @ line 2
function release_diff --wraps='git tag --sort=-creatordate|head -n 2|tac|xargs git diff > /tmp/(git tag --sort=-creatordate|head -n 1).diff'
  set last  (git tag --sort=-creatordate|head -n 1)
  git tag --sort=-creatordate|head -n 2|tac|xargs git diff > /tmp/$last.diff $argv; 
  echo $last
end
