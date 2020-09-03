" vim: set foldmethod=marker foldlevel=0 nomodeline:

" Plug Setup{{{

" Automatic Download {{{
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" }}}

call plug#begin('~/.config/nvim/plugged')
Plug 'semanser/vim-outdated-plugins'

" Extra operators
Plug 'tpope/vim-commentary'  "gc
Plug 'tpope/vim-unimpaired'
" Plug 'tpope/vim-surround'  "ys, ds, cs
Plug 'machakann/vim-sandwich'

Plug 'junegunn/vim-easy-align'  "ga
Plug 'vim-scripts/ReplaceWithRegister'  " gr
Plug 'vim-scripts/vis'  " :'<,'>B

Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-repeat'
Plug 'AndrewRadev/splitjoin.vim' " gS/gJ
Plug 'AndrewRadev/switch.vim'    " -
" Plug 'andymass/vim-matchup'

" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
Plug 'machakann/vim-highlightedyank'

Plug 'Olical/vim-enmasse'
Plug 'junegunn/vim-peekaboo'  " show registers

" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'mhinz/vim-signify'
Plug 'ruanyl/vim-gh-line'
Plug 'rhysd/git-messenger.vim'
Plug 'lambdalisue/gina.vim'

Plug 'alok/notational-fzf-vim'

"Completion
Plug 'autozimu/LanguageClient-neovim', {
     \ 'branch': 'next',
     \ 'do': 'bash install.sh',
     \ }

" Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp'
" Plug 'ncm2/ncm2-vim-lsp'
" Plug 'mattn/vim-lsp-settings'

Plug 'ncm2/ncm2' | Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-github'
Plug 'ncm2/ncm2-vim' | Plug 'Shougo/neco-vim'
Plug 'ncm2/ncm2-ultisnips'


Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'jceb/emmet.snippets'

Plug 'lambdalisue/suda.vim'
Plug 'tpope/vim-eunuch'

Plug 'direnv/direnv.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tweekmonster/django-plus.vim'
" Plug 'pest-parser/pest.vim'


Plug 'plasticboy/vim-markdown'
Plug 'dhruvasagar/vim-table-mode'
Plug 'https://gitlab.com/gi1242/vim-emoji-ab'

Plug 'itchyny/lightline.vim'
Plug 'aonemd/kuroi.vim'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'leiserfg/qalc.vim', {'do': ':UpdateRemotePlugins' }

Plug 'ruanyl/vim-fixmyjs', {
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

call plug#end()
" }}}
"
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
set matchtime=2 " Length of blink for matching brackets
" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set timeoutlen=500

" More natural split
set splitbelow
set splitright

set nojoinspaces " remove spaces while joining
set foldenable
set foldlevel=2
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set autoread " autoreload file changes
set nocursorline " cursorline is slow

augroup vimrc
    autocmd!
augroup END

autocmd vimrc InsertEnter * set nohlsearch
" }}}

" General {{{
" Extend %% as current file's folder 
cabbr <expr> %% expand('%:p:h')
set clipboard+=unnamedplus
let g:python_host_prog='/usr/bin/python3'
let g:python3_host_prog='/usr/bin/python3'


set diffopt+=internal,algorithm:histogram,indent-heuristic

syntax enable
set encoding=utf8
scriptencoding utf-8

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
set linebreak
set textwidth=100

set autoindent
set smartindent
set wrap! "Wrap lines

set signcolumn=yes

" Fast saving
nmap <leader>w :w!<cr>

" Easier shortcut for exiting the terminal
tnoremap <Esc> <C-\><C-n>
" interactive replace
set inccommand=split

autocmd BufRead,BufNewFile *.md,*.rst setlocal spell spelllang=en_us
autocmd FileType gitcommit setlocal spell spelllang=en_us
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
au vimrc BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" }}}

" Editing mappings {{{
map <F1> <Esc><Esc>
imap <F1> <Esc><Esc>


" Remap leader
let mapleader=' '

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

autocmd FileType direnv setlocal commentstring=#\ %s

"" Make sandwich work like vim-surround
runtime macros/sandwich/keymap/surround.vim
"" Textobjects to select a text surrounded by braket or same characters user input.

xmap is <Plug>(textobj-sandwich-query-i)
xmap as <Plug>(textobj-sandwich-query-a)
omap is <Plug>(textobj-sandwich-query-i)
omap as <Plug>(textobj-sandwich-query-a)

"" Textobjects to select a text surrounded by same characters user input.

xmap im <Plug>(textobj-sandwich-literal-query-i)
xmap am <Plug>(textobj-sandwich-literal-query-a)
omap im <Plug>(textobj-sandwich-literal-query-i)
omap am <Plug>(textobj-sandwich-literal-query-a)

""Textobjects to select the nearest surrounded text automatically.
xmap iss <Plug>(textobj-sandwich-auto-i)
xmap ass <Plug>(textobj-sandwich-auto-a)
omap iss <Plug>(textobj-sandwich-auto-i)
omap ass <Plug>(textobj-sandwich-auto-a)

""Enable emojis

au FileType html,php,markdown,mmd,text,mail,gitcommit
    \ runtime macros/emoji-ab.vim


let g:nv_search_paths = ['~/txts']
nnoremap <silent> <leader>n :NV<CR>
let g:suda_smart_edit = 1
" ----------------------------------------------------------------------------
" vim-plug extension
" ----------------------------------------------------------------------------
function! s:plug_gx()
  let line = getline('.')
  let sha  = matchstr(line, '^  \X*\zs\x\{7,9}\ze ')
  let name = empty(sha) ? matchstr(line, '^[-x+] \zs[^:]\+\ze:')
                      \ : getline(search('^- .*:$', 'bn'))[2:-2]
  let uri  = get(get(g:plugs, name, {}), 'uri', '')
  if uri !~ 'github.com'
    return
  endif
  let repo = matchstr(uri, '[^:/]*/'.name)
  let url  = empty(sha) ? 'https://github.com/'.repo
                      \ : printf('https://github.com/%s/commit/%s', repo, sha)
  call netrw#BrowseX(url, 0)
endfunction

function! s:scroll_preview(down)
  silent! wincmd P
  if &previewwindow
    execute 'normal!' a:down ? "\<c-e>" : "\<c-y>"
    wincmd p
  endif
endfunction

function! s:plug_doc()
  let name = matchstr(getline('.'), '^- \zs\S\+\ze:')
  if has_key(g:plugs, name)
    for doc in split(globpath(g:plugs[name].dir, 'doc/*.txt'), '\n')
      execute 'tabe' doc
    endfor
  endif
endfunction

function! s:setup_extra_keys()
  " PlugDiff
  nnoremap <silent> <buffer> J :call <sid>scroll_preview(1)<cr>
  nnoremap <silent> <buffer> K :call <sid>scroll_preview(0)<cr>
  nnoremap <silent> <buffer> <c-n> :call search('^  \X*\zs\x')<cr>
  nnoremap <silent> <buffer> <c-p> :call search('^  \X*\zs\x', 'b')<cr>
  nmap <silent> <buffer> <c-j> <c-n>o
  nmap <silent> <buffer> <c-k> <c-p>o

  " gx
  nnoremap <buffer> <silent> gx :call <sid>plug_gx()<cr>

  " helpdoc
  nnoremap <buffer> <silent> H  :call <sid>plug_doc()<cr>
endfunction

autocmd vimrc FileType vim-plug call s:setup_extra_keys()


let g:outdated_plugins_silent_mode = 1
" lightline
set noshowmode  " we don't need it any more because of the status line
let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
            \ },
            \ 'component_function': {
            \   'gitbranch': 'fugitive#head'
            \ },
            \ }

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

" FZF {{{
" ============================================================================
" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', '#5f5f87'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
let $FZF_DEFAULT_OPTS .= ' --inline-info'
let $FZF_DEFAULT_OPTS .=' --layout=reverse '
" let g:fzf_layout = { 'window': 'call FloatingFZF()' }

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

noremap <leader>/ :Rg 
" }}} FZF "

 " switch.vim {{{
let g:switch_mapping = '-'
let g:switch_custom_definitions = [
\   ['MON', 'TUE', 'WED', 'THU', 'FRI'],
\   ['staging', 'production'],
\   ['true', 'false']
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

" Preattier 
let g:prettier#autoformat = 0

" LSP {{{	

let g:LanguageClient_serverCommands = {
            \ 'Dockerfile': ['docker-langserver', '--stdio'],
            \ 'python': ['pyls'],
            \ 'rust': ['rustup', 'run', 'stable', 'rls'],
            \ 'json': ['json-languageserver', '--stdio' ],
            \'javascript': ['/usr/bin/javascript-typescript-stdio'],
            \'javascript.jsx': ['/usr/bin/javascript-typescript-stdio'],
            \'typescript': ['/usr/bin/javascript-typescript-stdio'],
            \'typescriptreact': ['/usr/bin/javascript-typescript-stdio'],
            \'gdscript3': ['tcp://localhost:6008'],
            \ }

let g:LanguageClient_diagnosticsDisplay = {
            \     1: {
            \         'name': 'Error',
            \         'signText': '💥',
            \         'virtualTexthl': 'ErrorMsg',
            \     },
            \     2: {
            \         'name': 'Warning',
            \         'signText': '❗',
            \         'virtualTexthl': 'WarningMsg',
            \     }
            \ }

" The default value brake the quickfix list	
let g:LanguageClient_diagnosticsList = 'Location'

" function! LC_maps()	
"     if has_key(g:LanguageClient_serverCommands, &filetype)	
"         nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>	
"         nnoremap <buffer> <silent> gD :call LanguageClient#textDocument_definition({ 'gotoCmd': 'split' })<CR>	
"         nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<CR>
"         nnoremap <buffer> <Leader>= :call LanguageClient#textDocument_formatting()<CR>
"     endif
" endfunction

" autocmd FileType  *  call LC_maps()	
nmap <F5> <Plug>(lcn-menu)

nmap <silent> K <Plug>(lcn-hover)
nmap <silent> gd <Plug>(lcn-definition)
nmap <silent> <F2> <Plug>(lcn-rename)
nmap <silent> <Leader>= <Plug>(lcn-format-sync)
 " }}}


" let g:lsp_signs_error = {'text': '💥'}
" let g:lsp_signs_warning = {'text': '❗'}
" let g:lsp_signs_hint = {'text': '🔔'}

" highlight link LspErrorText ErrorMsg
" highlight link LspWarningHighlight WarningMsg

" nnoremap <Leader>=  :LspDocumentFormat<CR>
" nnoremap gd  :LspDefinition<CR>
" nnoremap K  :LspHover<CR>

" UltiSnips {{{

let g:UltiSnipsSnippetDirectories=['~/.config/nvim/UltiSnips', 'UltiSnips']


inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or('<CR>', 'n')
let g:UltiSnipsExpandTrigger = '<c-j>'
let g:UltiSnipsJumpForwardTrigger= '<c-j>'
let g:UltiSnipsJumpBackwardTrigger= '<c-k>'
let g:UltiSnipsRemoveSelectModeMappings=0
" }}}

" Completion {{{
let g:ncm2#matcher='substrfuzzy'
autocmd BufEnter * call ncm2#enable_for_buffer()
" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
set shortmess+=c
set completeopt=noinsert,menuone,noselect

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>


" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? '<C-n>' : '<Tab>'
inoremap <expr> <S-Tab> pumvisible() ? '<C-p>' : '<S-Tab>'
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

let g:highlightedyank_highlight_duration = 100

let g:gh_use_canonical = 1
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
colorscheme kuroi

" }}}
