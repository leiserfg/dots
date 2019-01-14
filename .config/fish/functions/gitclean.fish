function gitclean
	git filter-branch --force --index-filter \
'git rm -r  --cached --ignore-unmatch '{$argv[1]} \
--prune-empty --tag-name-filter cat -- --all
end
