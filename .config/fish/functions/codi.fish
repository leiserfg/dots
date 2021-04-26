# Defined in /tmp/fish.n32CYr/codi.fish @ line 2
function codi --argument lang
  set -q lang[1] || set lang python
  echo $lang
  nvim -c \
    "let g:startify_disable_at_vimenter = 1 |\
    set bt=nofile ls=0 noru nonu nornu |\
    hi ColorColumn ctermbg=NONE |\
    hi VertSplit ctermbg=NONE |\
    hi NonText ctermfg=0 |\
    Codi $lang"
end
