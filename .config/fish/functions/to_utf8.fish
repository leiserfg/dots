function to_utf8
	iconv -f  (uchardet $argv[1]) -t UTF-8 $argv[1] ;
end
