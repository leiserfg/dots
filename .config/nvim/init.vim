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
" Extra operators
" Plug 'tpope/vim-commentary' 
Plug 'b3nj5m1n/kommentary',{'branch': 'main'}  "gc 
Plug 'tpope/vim-unimpaired'

" Plug 'tpope/vim-surround'  "ys, ds, cs
Plug 'machakann/vim-sandwich'

Plug 'junegunn/vim-easy-align'  "ga
Plug 'vim-scripts/ReplaceWithRegister'  " gr
Plug 'vim-scripts/vis'  " :'<,'>B

Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-repeat'

Plug 'AndrewRadev/splitjoin.vim'
  let g:splitjoin_split_mapping = ''
  let g:splitjoin_join_mapping = ''
  nnoremap gss :SplitjoinSplit<cr>
  nnoremap gsj :SplitjoinJoin<cr>

Plug 'AndrewRadev/switch.vim'    " -
Plug 'Olical/vim-enmasse'
Plug 'junegunn/vim-peekaboo'  " show registers

Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

Plug 'mhinz/vim-signify'
" Plug 'ruanyl/vim-gh-line'
" Plug 'lambdalisue/gina.vim'

Plug 'alok/notational-fzf-vim'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
Plug 'nvim-treesitter/playground'
Plug 'romgrk/nvim-treesitter-context'

Plug 'nvim-lua/completion-nvim'

Plug 'honza/vim-snippets' | Plug 'SirVer/ultisnips'
Plug 'jceb/emmet.snippets'

Plug 'lambdalisue/suda.vim'
Plug 'tpope/vim-eunuch'

Plug 'direnv/direnv.vim'
Plug 'hashivim/vim-terraform'
Plug 'sheerun/vim-polyglot'
" Plug 'pest-parser/pest.vim'
Plug 'metakirby5/codi.vim'

Plug 'dhruvasagar/vim-table-mode', {
      \ 'for': ['markdown'],
      \ }
Plug 'junegunn/vim-emoji'
  command! -range EmojiReplace <line1>,<line2>s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g


Plug 'itchyny/lightline.vim'
Plug 'sainnhe/gruvbox-material'

Plug 'junegunn/fzf.vim' | Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

"Lisp
Plug 'Olical/AnsiEsc'
Plug 'Olical/aniseed'
Plug 'Olical/conjure', {'for': ['fennel', 'clojure']}
Plug 'eraserhd/parinfer-rust', {'do': 'cargo build --release', 'for': ['fennel', 'janet', 'clojure']}

" Look and feel
Plug 'p00f/nvim-ts-rainbow'
Plug 'norcalli/nvim-colorizer.lua'
call plug#end()
" }}}
" treesitter {{{ "
" DISABLED UNTIL IT WORKS FINE
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",     -- one of "all", "language", or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "markdown" },  -- list of language that will be disabled
  },
  rainbow = {
     enable=true
   },
  --[[ indent = {
    enable = true
  },]]
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false -- Whether the query persists across vim sessions
  }
}
EOF
" }}} treesitter "

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
" set foldenable
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

"I don't like to hardcode it but it's faster than calling git several times like in vim-snipp

let g:snips_author = 'leiserfg'
let g:snips_email = 'leiserfg@gmail.com'
let g:snips_github = "https://github.com/leiserfg"

" Extend %% as current file's folder 
cabbr <expr> %% expand('%:p:h')
set clipboard+=unnamedplus
" Disable unused loaders
let g:loaded_python_provider = 0 " Don't use python2
let g:loaded_ruby_provider = 0
let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0

let g:python3_host_prog='/usr/bin/python3'
set diffopt+=internal,algorithm:histogram,indent-heuristic,vertical

let g:fugitive_dynamic_colors = 0
autocmd vimrc FileType fugitiveblame lua require"blame_color".highlight_hashes()

syntax enable
set encoding=utf8
scriptencoding utf-8
" highlight lua on vim files
let g:vimsyn_embed = 'l'
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

" Remap leader
let mapleader=' '
let maplocalleader=' '

"Move current lines
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Make Y behave like other capitals
nnoremap Y y$

" qq to record, Q to replay
nnoremap Q @q

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
" xnoremap <silent> ie gg0oG$
" onoremap <silent> ie :<C-U>execute "normal! m`"<Bar>keepjumps normal! ggVG<CR>

" ----------------------------------------------------------------------------
" ?il | inner line
" ----------------------------------------------------------------------------
xnoremap <silent> il <Esc>^vg_
onoremap <silent> il :<C-U>normal! ^vg_<CR>

" }}} Custom Text Objects "

" Plugins {{{


let g:codi#interpreters = {
   \ 'rink': {
       \ 'prompt': '^> ',
       \ 'bin': 'rink',
       \ },
   \ }

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

" Notational vim
let g:nv_search_paths = ['~/txts']
nnoremap <silent> <leader>n :NV<CR>



nnoremap <leader>t :NvimTreeToggle<CR>
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

" lightline
set noshowmode  " we don't need it any more because of the status line
 let g:lightline = {
       \ 'active': {
       \   'left': [ [ 'mode', 'paste' ],
       \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
       \ },
       \ 'component_function': {
       \   'gitbranch_2': 'gina#component#repo#branch',
       \   'gitbranch': 'FugitiveHead'
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
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

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

" LSP and completion.nvim {{{	

lua <<EOF
  local lspconfig = require('lspconfig')
  for _, lsp in pairs{'pyls', 'gdscript', 'vimls', 'rust_analyzer', 'tsserver'} do
    lspconfig[lsp].setup{}
  end
EOF
let g:completion_matching_ignore_case = 1
let g:completion_enable_snippet='UltiSnips'
let g:completion_matching_strategy_list=['exact', 'fuzzy']
let g:completion_enable_auto_hover = 0
autocmd BufEnter * lua require'completion'.on_attach()

function! s:lsp_setup()
    if empty(luaeval('vim.inspect(vim.lsp.buf_get_clients())'))
        return
    end
    nnoremap <buffer> <silent> <c-]>   <cmd>lua vim.lsp.buf.declaration()<CR>
    nnoremap <buffer> <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <buffer> <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <buffer> <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
    nnoremap <buffer> <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
    nnoremap <buffer> <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
    nnoremap <buffer> <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
    nnoremap <buffer> <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
    nnoremap <buffer> <silent> <Leader>= <cmd>lua vim.lsp.buf.formatting()<CR>
    nnoremap <buffer> <silent> <Leader>a <cmd>lua vim.lsp.buf.code_action()<CR>
endfunction
autocmd BufEnter * call s:lsp_setup()

sign define LspDiagnosticsSignError text=🩸 linehl= numhl=
sign define LspDiagnosticsSignWarning text=🔸  linehl= numhl=
sign define LspDiagnosticsSignInformation text=🔹 linehl= numhl=
sign define LspDiagnosticsSignHint text=👉 linehl= numhl=
" }}} "

" UltiSnips {{{

let g:UltiSnipsSnippetDirectories=['~/.config/nvim/UltiSnips', 'UltiSnips']


" inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or('<CR>', 'n')
let g:UltiSnipsExpandTrigger = '<c-j>'
let g:UltiSnipsJumpForwardTrigger= '<c-j>'
let g:UltiSnipsJumpBackwardTrigger= '<c-k>'
let g:UltiSnipsRemoveSelectModeMappings=0
" }}}

" Completion {{{
set shortmess+=c
set completeopt=noinsert,menuone,noselect

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>
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

au vimrc TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150}
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

" ----------------------------------------------------------------------------
" <Leader>?/! | Google it / Feeling lucky
" ----------------------------------------------------------------------------
function! s:goog(pat, lucky)
  let q = '"'.substitute(a:pat, '["\n]', ' ', 'g').'"'
  let q = substitute(q, '[[:punct:] ]',
       \ '\=printf("%%%02X", char2nr(submatch(0)))', 'g')
  call system(printf('open "https://www.google.com/search?%sq=%s"',
                   \ a:lucky ? 'btnI&' : '', q))
endfunction
nnoremap <leader>? :call <SID>goog(expand("<cWORD>"), 0)<cr>
nnoremap <leader>! :call <SID>goog(expand("<cWORD>"), 1)<cr>
xnoremap <leader>? "gy:call <SID>goog(@g, 0)<cr>gv
xnoremap <leader>! "gy:call <SID>goog(@g, 1)<cr>gv

" }}} Operators "

" Theme {{{
set termguicolors
set background=dark
let g:gruvbox_material_sign_column_background = 'none' 
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_enable_italic = 1
colorscheme gruvbox-material
let g:lightline.colorscheme = 'gruvbox_material'
" }}}
