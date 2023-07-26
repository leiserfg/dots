function cbuf --wraps=printf\ \'\\033\[2J\\033\[3J\\033\[1\;1H\' --description alias\ cbuf\ printf\ \'\\033\[2J\\033\[3J\\033\[1\;1H\'
  printf '\033[2J\033[3J\033[1;1H' $argv
        
end
