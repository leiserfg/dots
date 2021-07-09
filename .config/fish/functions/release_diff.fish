# Defined in /tmp/fish.KUctYJ/release_diff.fish @ line 2
function release_diff
  set last  (git tag --sort=-creatordate|head -n 1)
  git tag --sort=-creatordate|head -n 2|tac|xargs git diff | filterdiff -x"*CHANGES.rst"  -x"*.tf" -x"*.tfvars" -x"*.hcl" "-x*Dockerfile" "-x*.yml" "-x*celery.conf" > /tmp/$last.diff 
  echo /tmp/$last.diff
end
