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
    use {
        'machakann/vim-sandwich',
        config=function() 
            vim.cmd [[runtime macros/sandwich/keymap/surround.vim]]
                --[[  Make sandwich work like vim-surround
                 Textobjects to select a text surrounded by braket or same characters user input. ]]
                vim.cmd[[xmap is <Plug>(textobj-sandwich-query-i)]]
                vim.cmd[[xmap as <Plug>(textobj-sandwich-query-a)]]
                vim.cmd[[omap is <Plug>(textobj-sandwich-query-i)]]
                vim.cmd[[omap as <Plug>(textobj-sandwich-query-a)]]

                --  Textobjects to select a text surrounded by same characters user input.

                vim.cmd[[xmap im <Plug>(textobj-sandwich-literal-query-i)]]
                vim.cmd[[xmap am <Plug>(textobj-sandwich-literal-query-a)]]
                vim.cmd[[omap im <Plug>(textobj-sandwich-literal-query-i)]]
                vim.cmd[[omap am <Plug>(textobj-sandwich-literal-query-a)]]

                -- Textobjects to select the nearest surrounded text automatically.
                vim.cmd[[xmap iss <Plug>(textobj-sandwich-auto-i)]]
                vim.cmd[[xmap ass <Plug>(textobj-sandwich-auto-a)]]
                vim.cmd[[omap iss <Plug>(textobj-sandwich-auto-i)]]
                vim.cmd[[omap ass <Plug>(textobj-sandwich-auto-a)]]
        end
    }
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

    use {'tpope/vim-dispatch', cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'

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
        {'nvim-treesitter/playground'},
        -- {'romgrk/nvim-treesitter-context'},
         run=':TSUpdate',
         config=function()
             require'nvim-treesitter.configs'.setup {
              -- ensure_installed = "all",     -- one of "all", "language", or a list of languages
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

    --[[ use { 'nvim-lua/completion-nvim', 
    config = function()
        vim.g.completion_matching_ignore_case = 1
        vim.g.completion_enable_snippet='UltiSnips'
        vim.g.completion_matching_strategy_list={'exact', 'fuzzy'}
        vim.g.completion_enable_auto_hover = 0
        vim.cmd [[ autocmd BufEnter * lua require'completion'.on_attach() ]]
    --[[ end

    } ]]

    use {
        "hrsh7th/nvim-compe",
        config=function()
            require'compe'.setup({
                    enabled = true,
                    source = {
                        path = true,
                        buffer = true,
                        nvim_lsp = true,
                        calc=true,
                        spell=true,
                        ultisnips=true,
                        nvim_lua = true,
                        emoji = true,
                    }
                })
            vim.cmd[[inoremap <silent><expr> <CR>      compe#confirm('<CR>')]]
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

    use {'direnv/direnv.vim', config=function()
        vim.cmd [[
        autocmd FileType direnv setlocal commentstring=#\ %s
        ]]
     end
    }

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

    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        config = function()
            require('lualine').setup{
                options = {
                    theme = 'gruvbox_material',
                    section_separators = '',
                    component_separators = '',
                    icons_enabled = false,
                },
                extensions = { 'fzf' }
            }
        end
    }
    use {'sainnhe/gruvbox-material', config=function() vim.cmd[[colorscheme gruvbox-material]] end }

    use {
        'junegunn/fzf.vim', 
        config=function()
            vim.g.fzf_layout = { window={ width=0.9, height=0.6 } }
            vim.cmd[[noremap <leader>/ :Rg ]]
        end
    }

    use {
        'lambdalisue/fern.vim',
        requires={
        'antoinemadec/FixCursorHold.nvim',
        'lambdalisue/fern-hijack.vim'
        },
        config=function() 
        vim.cmd[[nnoremap <silent> <leader>t :Fern . -drawer -toggle<CR>]]
        end
     }



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
