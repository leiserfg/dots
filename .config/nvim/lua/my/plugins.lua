local cmd = vim.api.md
local fn = vim.fn
if not pcall(require, 'packer') then
    local directory = string.format(
        '%s/site/pack/packer/start/',
        vim.fn.stdpath('data')
        )

  vim.fn.mkdir(directory, 'p')

  local out = vim.fn.system(string.format(
    'git clone %s %s',
    'https://github.com/wbthomason/packer.nvim',
    directory .. '/packer.nvim'
  ))

  print(out)
  print("Downloading packer.nvim...")
end

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use { 'b3nj5m1n/kommentary', branch = 'main'}  -- "gc
    use 'tpope/vim-unimpaired'

    use 'junegunn/vim-easy-align'  --ga
    use 'vim-scripts/ReplaceWithRegister'  -- gr
    use 'vim-scripts/vis'        -- :'<,'>B

    use 'tpope/vim-speeddating'
    use 'tpope/vim-repeat'
    use {
        'AndrewRadev/splitjoin.vim',
        cmd={'SplitjoinSplit', 'SplitjoinJoin'},
        config = function()
            vim.g.splitjoin_join_mapping = ''
            cmd "nnoremap gss :SplitjoinSplit<cr>"
            cmd "nnoremap gsj :SplitjoinJoin<cr>"
        end
    }

    use 'AndrewRadev/switch.vim'    -- " -
    use 'Olical/vim-enmasse'
    use 'junegunn/vim-peekaboo'  --" show registers

    -- use 'kyazdani42/nvim-web-devicons' --" for file icons
    -- use 'kyazdani42/nvim-tree.lua'

    use {'tpope/vim-dispatch', cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'

    -- use 'mhinz/vim-signify'
    --[[ " use 'ruanyl/vim-gh-line'
    " use 'lambdalisue/gina.vim' ]]
    use {
        'lewis6991/gitsigns.nvim',
        branch='yadm',
        requires = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require('gitsigns').setup{yadm={enable=true}}
        end
    }

    use 'alok/notational-fzf-vim'

    use {
        'neovim/nvim-lspconfig', 
        config=function()
             local lspconfig = require('lspconfig')
             for _, lsp in pairs{'pyls', 'gdscript', 'vimls', 'rust_analyzer', 'tsserver'} do
               lspconfig[lsp].setup{}
             end
        end


    }
    use {
        'nvim-treesitter/nvim-treesitter', 
         run=':TSUpdate',
         config=function()
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
         end
    }
    use 'nvim-treesitter/playground'
    use 'romgrk/nvim-treesitter-context'

    use { 'nvim-lua/completion-nvim', 
    config = function()
        vim.g.completion_matching_ignore_case = 1
        vim.g.completion_enable_snippet='UltiSnips'
        vim.g.completion_matching_strategy_list={'exact', 'fuzzy'}
        vim.g.completion_enable_auto_hover = 0
        vim.cmd [[ autocmd BufEnter * lua require'completion'.on_attach() ]]
    end

    }
    use {
        'honza/vim-snippets', requires='SirVer/ultisnips', 
        config=function()
            vim.g.UltiSnipsSnippetDirectories={'~/.config/nvim/UltiSnips', 'UltiSnips'}
            vim.g.UltiSnipsExpandTrigger = '<c-j>'
            vim.g.UltiSnipsJumpForwardTrigger= '<c-j>'
            vim.g.UltiSnipsJumpBackwardTrigger= '<c-k>'
            vim.g.UltiSnipsRemoveSelectModeMappings=0
        end
    }
    use 'jceb/emmet.snippets'

    use { 'lambdalisue/suda.vim', config="vim.g.suda_smart_edit=1"}
    use 'tpope/vim-eunuch'

    use 'direnv/direnv.vim'
    use {
        'hashivim/vim-terraform', 
        config=function()
            vim.g.terraform_align=1
            vim.g.terraform_fold_sections=1
            vim.g.terraform_commentstring='//%s'
        end
    }
    use 'sheerun/vim-polyglot'
    use 'tikhomirov/vim-glsl'
    -- use 'pest-parser/pest.vim'
    use 'metakirby5/codi.vim'

    use {'dhruvasagar/vim-table-mode', ft='markdown'}


    use 'itchyny/lightline.vim'
    use {'sainnhe/gruvbox-material', config=function() vim.cmd 'colorscheme gruvbox-material'  end}

    use 'junegunn/fzf.vim'
    -- Lisp
    use 'Olical/AnsiEsc'
    use 'Olical/aniseed'
    use {'Olical/conjure', ft= {'fennel', 'clojure'}}
    use {'eraserhd/parinfer-rust', run='cargo build --release', ft={'fennel', 'janet', 'clojure'}}

    -- Look and feel
    use 'p00f/nvim-ts-rainbow'
    use 'norcalli/nvim-colorizer.lua'

    --[[ use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim' ]]
end)
