function time
	set -l initial (date +%s%3N)
eval $argv
set -l final (date +%s%3N)
printf "\nIt took "(math $final-$initial)" miliseconds"
end
