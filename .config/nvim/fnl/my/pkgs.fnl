(local packer (require :packer))

(fn packages [...]
  (local packs [...])

  (fn setup [use]
    (each [_ p (ipairs packs)]
      (use p)))

  (packer.startup setup))

(macro u [name ...]
  (local args [...])
  (local ops {})
  (for [i 1 (length args) 2]
    (tset ops (. args i) (. args (+ i 1))))
  (tset ops 1 name)
  `,ops)

(macro cu [name ...]
  (local args [...])
  (local path (.. :my.plugins/ (: (: name :gsub ".*/" "") :gsub "[.].*" "")))
  (local ops {:config (.. "require('" path "')")})
  (for [i 1 (length args) 2]
    (tset ops (. args i) (. args (+ i 1))))
  (tset ops 1 name)
  `,ops)

(packages (u :Olical/aniseed :ft :fennel) :wbthomason/packer.nvim
          (u :tpope/vim-unimpaired :event :BufRead) :gpanders/nvim-parinfer
          (u :numToStr/Comment.nvim :keys :gc :config
             "require('Comment').setup()")
          (cu :junegunn/vim-easy-align :keys :ga)
          (u :vim-scripts/ReplaceWithRegister :keys :gr) :tpope/vim-repeat
          (u :AndrewRadev/switch.vim :config true :requires
             (u :tpope/vim-speeddating :keys
                [:<Plug>SpeedDatingFallbackUp :<Plug>SpeedDatingFallbackDown]))
          (u :Olical/vim-enmasse :cmd :EnMasse)
          (u :tpope/vim-fugitive :cmd [:G] :event :BufRead)
          (u :tpope/vim-rhubarb :after :vim-fugitive) :tpope/vim-eunuch
          (u :Vimjas/vim-python-pep8-indent :ft :python)
          (u :norcalli/nvim-colorizer.lua :config "require'colorizer'.setup()")
          :direnv/direnv.vim (cu :machakann/vim-sandwich)
          (cu :AndrewRadev/splitjoin.vim :keys [:gS :gJ])
          (cu :lewis6991/gitsigns.nvim :event :VimEnter :requires
              [:nvim-lua/plenary.nvim])
          (u :ray-x/lsp_signature.nvim :config
             "require\"lsp_signature\".setup({floating_window=false})")
          (cu :neovim/nvim-lspconfig :after [:lsp_signature.nvim])
          (u :simrat39/rust-tools.nvim :ft [:rust] :config
             "require('rust-tools').setup()")
          (cu :nvim-treesitter/nvim-treesitter :run ":TSUpdate" :requires
              [:nvim-treesitter/playground
               :nvim-treesitter/nvim-treesitter-textobjects])
          (cu :L3MON4D3/LuaSnip :requires [:rafamadriz/friendly-snippets])
          (cu :hrsh7th/nvim-cmp :requires
              [:hrsh7th/cmp-buffer
               :hrsh7th/cmp-path
               :hrsh7th/cmp-nvim-lsp
               :hrsh7th/cmp-calc
               :hrsh7th/cmp-nvim-lua
               :hrsh7th/cmp-emoji
               :onsails/lspkind-nvim
               :saadparwaiz1/cmp_luasnip
               :L3MON4D3/LuaSnip])
          (u :lambdalisue/suda.vim :config :vim.g.suda_smart_edit=1)
          (cu :metakirby5/codi.vim :cmd :Codi)
          (u :dhruvasagar/vim-table-mode :ft [:markdown :org :orgagenda])
          (cu :nvim-lualine/lualine.nvim :requires :gruvbox-flat.nvim)
          (cu :kyazdani42/nvim-tree.lua :keys :<leader>t :requires
              :kyazdani42/nvim-web-devicons)
          (u :Olical/conjure :ft [:fennel :clojure])
          (cu :ibhagwan/fzf-lua :requires
              [:vijaymarupudi/nvim-fzf :kyazdani42/nvim-web-devicons])
          (u :eddyekofo94/gruvbox-flat.nvim :config
             "vim.g.gruvbox_flat_style = 'dark'; vim.cmd('colorscheme gruvbox-flat')")
          (u :nanotee/zoxide.vim :cmd :Z)
          (u :tweekmonster/startuptime.vim :cmd :StartupTime)
          (cu :kristijanhusak/orgmode.nvim)
          (u :akinsho/org-bullets.nvim
             :config "require(\"org-bullets\").setup { symbols = { \"◉\", \"○\", \"✸\", \"✿\" } }")
          :rktjmp/hotpot.nvim)
