" vim: set foldmethod=marker foldlevel=0 nomodeline:
" Plug Setup{{{
call plug#begin('~/.config/nvim/plugged')
Plug 'terryma/vim-multiple-cursors'
Plug 'Olical/vim-enmasse'
Plug 'semanser/vim-outdated-plugins'

" Extra operators
Plug 'tpope/vim-commentary'  "gc
Plug 'tpope/vim-surround'  "ys, ds, cs
Plug 'junegunn/vim-easy-align'  "ga
Plug 'vim-scripts/ReplaceWithRegister'  " gr
Plug 'vim-scripts/vis'  " :'<,'>B

Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-repeat'
Plug 'AndrewRadev/splitjoin.vim' " gS/gJ
Plug 'AndrewRadev/switch.vim'    " -

" better search
Plug 'junegunn/vim-slash'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
Plug 'lucasteles/SWTC.Vim' | Plug 'dahu/vim-rng'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'


" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'mhinz/vim-signify'
Plug 'ruanyl/vim-gh-line'

"Completion
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'ncm2/ncm2' | Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-github'
Plug 'ncm2/ncm2-vim' | Plug 'Shougo/neco-vim'
Plug 'ncm2/ncm2-ultisnips'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'lambdalisue/suda.vim'
Plug 'tpope/vim-eunuch'

Plug 'ekalinin/Dockerfile.vim'
Plug 'direnv/direnv.vim'
Plug 'hashivim/vim-terraform'
Plug 'sheerun/vim-polyglot'
Plug 'tweekmonster/django-plus.vim'

Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'

Plug 'francoiscabrol/ranger.vim' | Plug 'rbgrouleff/bclose.vim'

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
call plug#end()
" }}}

" User interface {{{
" Show line numbers
set number
set relativenumber
set wildmenu
set ruler " Show current position
set modelines=2 "Allow modelines
" Setup backspace
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set synmaxcol=500 "Make vim faster sometimes

set ignorecase smartcase " Ignore case when searching
set smartcase " Smart cases when searching
set hlsearch " Highlight search results
set incsearch " Make search act as in modern browsers
set hidden
set showmatch " Show matching brackets
set mat=2 " Length of blink for matching brackets
" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" More natural split
set splitbelow
set splitright

set nojoinspaces " remove spaces while joining
set foldenable
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set autoread " autoreload file changes
set nocursorline " cursorline is slow
" }}}

" General {{{
" Extend %% as current file's folder 
cabbr <expr> %% expand('%:p:h')
set clipboard+=unnamedplus
let g:python_host_prog='/usr/bin/python3'
let g:python3_host_prog='/usr/bin/python3'

syntax enable
set encoding=utf8

" Use spaces instead of tabs
set expandtab
set smarttab
" show tabs and trailing spaces
set list
set showbreak=↪\ 
set listchars=tab:→\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨
set virtualedit=block "Flexible block selection
" tab per 4 spaces
set shiftwidth=4
set softtabstop=4

" Linebreak on
set lbr
set tw=100

set ai "Auto indent
set si "Smart indent
set wrap! "Wrap lines

set signcolumn=yes

" Fast saving
nmap <leader>w :w!<cr>

" Easier shortcut for exiting the terminal
tnoremap <Esc> <C-\><C-n>

" }}}

" File, backups and undo {{{
set nobackup
set noswapfile
" }}}
" Moving around, tabs, windows and buffers {{{
" ----------------------------------------------------------------------------
" Buffers
" ----------------------------------------------------------------------------
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

" ----------------------------------------------------------------------------
" Tabs
" ----------------------------------------------------------------------------
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" }}}

" Editing mappings {{{
" Remap leader
let mapleader=" "

"Move current lines
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

vnoremap <silent> <C-h> <<
vnoremap <silent> <C-l> >>
nnoremap <silent> <C-h> <<
nnoremap <silent> <C-l> >>

" Make Y behave like other capitals
nnoremap Y y$

" qq to record, Q to replay
nnoremap Q @q


" jk | Escaping 
inoremap jk <Esc>
" xnorecmap ii <Esc>
cnoremap jk <C-c>

nnoremap <leader>w :w<cr>

" ----------------------------------------------------------------------------
" Readline-style key bindings in command-line (excerpt from rsi.vim)
" ----------------------------------------------------------------------------
cnoremap        <C-A> <Home>
cnoremap        <C-B> <Left>
cnoremap <expr> <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"
cnoremap <expr> <C-F> getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"
cnoremap        <M-b> <S-Left>
cnoremap        <M-f> <S-Right>
silent! exe "set <S-Left>=\<Esc>b"
silent! exe "set <S-Right>=\<Esc>f"

" ----------------------------------------------------------------------------
" }}}

" Custom Text Objects {{{


" ----------------------------------------------------------------------------
" ?ii / ?ai | indent-object
" ?io       | strictly-indent-object
" ----------------------------------------------------------------------------
function! s:indent_len(str)
  return type(a:str) == 1 ? len(matchstr(a:str, '^\s*')) : 0
endfunction

function! s:indent_object(op, skip_blank, b, e, bd, ed)
  let i = min([s:indent_len(getline(a:b)), s:indent_len(getline(a:e))])
  let x = line('$')
  let d = [a:b, a:e]

  if i == 0 && empty(getline(a:b)) && empty(getline(a:e))
    let [b, e] = [a:b, a:e]
    while b > 0 && e <= line('$')
      let b -= 1
      let e += 1
      let i = min(filter(map([b, e], 's:indent_len(getline(v:val))'), 'v:val != 0'))
      if i > 0
        break
      endif
    endwhile
  endif

  for triple in [[0, 'd[o] > 1', -1], [1, 'd[o] < x', +1]]
    let [o, ev, df] = triple

    while eval(ev)
      let line = getline(d[o] + df)
      let idt = s:indent_len(line)

      if eval('idt '.a:op.' i') && (a:skip_blank || !empty(line)) || (a:skip_blank && empty(line))
        let d[o] += df
      else | break | end
    endwhile
  endfor
  execute printf('normal! %dGV%dG', max([1, d[0] + a:bd]), min([x, d[1] + a:ed]))
endfunction
xnoremap <silent> ii :<c-u>call <SID>indent_object('>=', 1, line("'<"), line("'>"), 0, 0)<cr>
onoremap <silent> ii :<c-u>call <SID>indent_object('>=', 1, line('.'), line('.'), 0, 0)<cr>
xnoremap <silent> ai :<c-u>call <SID>indent_object('>=', 1, line("'<"), line("'>"), -1, 1)<cr>
onoremap <silent> ai :<c-u>call <SID>indent_object('>=', 1, line('.'), line('.'), -1, 1)<cr>
xnoremap <silent> io :<c-u>call <SID>indent_object('==', 0, line("'<"), line("'>"), 0, 0)<cr>
onoremap <silent> io :<c-u>call <SID>indent_object('==', 0, line('.'), line('.'), 0, 0)<cr>


" ----------------------------------------------------------------------------
" ?ie | entire object
" ----------------------------------------------------------------------------
xnoremap <silent> ie gg0oG$
onoremap <silent> ie :<C-U>execute "normal! m`"<Bar>keepjumps normal! ggVG<CR>

" ----------------------------------------------------------------------------
" ?il | inner line
" ----------------------------------------------------------------------------
xnoremap <silent> il <Esc>^vg_
onoremap <silent> il :<C-U>normal! ^vg_<CR>

" }}} Custom Text Objects "

" Plugins {{{

" Start interactive EasyAlign in visual mode
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign with a Vim movement
nmap ga <Plug>(EasyAlign)
nmap gaa ga_

xmap <Leader>ga   <Plug>(LiveEasyAlign)

" ----------------------------------------------------------------------------
" vim-signify
" ----------------------------------------------------------------------------
let g:signify_vcs_list = ['git']
let g:signify_skip_filetype = { 'journal': 1 }
let g:signify_sign_add          = '│'
let g:signify_sign_change       = '│'
let g:signify_sign_changedelete = '│'

" ----------------------------------------------------------------------------
" vim-emoji :dog: :cat: :rabbit:!
" ----------------------------------------------------------------------------
" command! -range EmojiReplace <line1>,<line2>s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g

" goyo.vim + limelight.vim {{{ "
let g:limelight_paragraph_span = 1
let g:limelight_priority = -1

function! s:goyo_enter()
  Limelight
  let &l:statusline = '%M'
  hi StatusLine ctermfg=red guifg=red cterm=NONE gui=NONE
endfunction

function! s:goyo_leave()
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

nnoremap <F11> :Goyo<CR>
" }}} "
"
" FZF {{{
" ============================================================================
let $FZF_DEFAULT_OPTS .= ' --inline-info'

" Hide statusline of terminal buffer
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

function! s:plug_help_sink(line)
  let dir = g:plugs[a:line].dir
  for pat in ['doc/*.txt', 'README.md']
    let match = get(split(globpath(dir, pat), "\n"), 0, '')
    if len(match)
      execute 'tabedit' match
      return
    endif
  endfor
  tabnew
  execute 'Explore' dir
endfunction

command! PlugHelp call fzf#run(fzf#wrap({
  \ 'source': sort(keys(g:plugs)),
  \ 'sink':   function('s:plug_help_sink')}))

" }}} FZF "

 " switch.vim {{{
let g:switch_mapping = '-'
let g:switch_custom_definitions = [
\   ['MON', 'TUE', 'WED', 'THU', 'FRI'],
\   ['staging', 'production']
\ ]


autocmd FileType python let b:switch_custom_definitions =
\ [
\ ['True', 'False']
\ ]

autocmd FileType gitrebase let b:switch_custom_definitions =
\ [
\   [ 'pick', 'reword', 'edit', 'squash', 'fixup', 'exec' ]
\ ]
" }}} "
" ----------------------------------------------------------------------------
" Multiple cursors {{{
let g:multi_cursor_quit_key = '<Esc>'
" }}}

" LSP {{{
let g:LanguageClient_serverCommands = { 'python': ['pyls']}

" The default value brake the quickfix list
let g:LanguageClient_diagnosticsList = 'Location' 

function! LC_maps()
    if has_key(g:LanguageClient_serverCommands, &filetype)
        nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>
        nnoremap <buffer> <silent> gD :call LanguageClient#textDocument_definition({ "gotoCmd": "split" })<CR>
        nnoremap <buffer> <silent> gvD :call LanguageClient#textDocument_definition({ "gotoCmd": "vsplit" })<CR>
        nnoremap <leader>= :call LanguageClient#textDocument_formatting()<CR>
    endif
endfunction

autocmd FileType python call LC_maps()

" }}}

" UltiSnips {{{

let g:UltiSnipsSnippetDirectories=['~/.config/nvim/UltiSnips', 'UltiSnips']


inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger= "<c-j>"
let g:UltiSnipsJumpBackwardTrigger= "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings=0
" }}}

" Completion {{{
let g:ncm2#matcher="substrfuzzy"
autocmd BufEnter * call ncm2#enable_for_buffer()
" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
set shortmess+=c
set completeopt=noinsert,menuone,noselect

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>


" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" }}}

" Terraform {{{
let g:terraform_align=1
let g:terraform_fold_sections=1
let g:terraform_commentstring='//%s'
" }}}

" Netrw {{{
let g:netrw_banner = 0
let g:netrw_winsize = 15
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
" }}}

" }}} "

" Operators {{{
" ----------------------------------------------------------------------------
" EX | chmod +x
" ----------------------------------------------------------------------------
command! EX if !empty(expand('%'))
         \|   write
         \|   call system('chmod +x '.expand('%'))
         \|   silent e
         \| else
         \|   echohl WarningMsg
         \|   echo 'Save the file first'
         \|   echohl None
         \| endif
" }}} Operators "

" Theme {{{
set termguicolors
set background=dark
colorscheme gruvbox 
" }}}
