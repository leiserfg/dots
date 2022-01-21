function release_diff
  set last  (git tag --sort=-creatordate|head -n 1)
  git tag --sort=-creatordate|head -n 2|tac|xargs -n2 sh -c 'git diff --binary $1 $2 \':!*CHANGES.rst\' \':!/*.tf\'  \':!/*.ini\'  \':!/*.tfvars\'  \':!/*.hcl\' \':!/*Dockerfile\' \':!/*.yml\'  \':!/*celery.conf\'  \':!/*settings.py\'  ' sh > /tmp/$last.diff
  # "| filterdiff -x"*CHANGES.rst"  -x"*.tf" -x"*.tfvars" -x"*.hcl" "-x*Dockerfile" "-x*.yml" "-x*celery.conf" > /tmp/$last.diff 
  echo /tmp/$last.diff
end
