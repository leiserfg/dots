(macro packages [...]
  (local pks [...])
  `((. (require :packer) :startup)
    (fn [use#]
       ,(unpack (icollect [_ p (ipairs pks)]
                  `(use# ,p))))))

(macro pkg [name ...]
  (local args [...])
  (local ops {})
  (for [i 1 (length args) 2]
    (tset ops (. args i) (. args (+ i 1))))
  (tset ops 1 name)
  `,ops)

(macro cpkg [name ...]
  `(pkg ,name
       :config ,(.. "require[[my.plugins/"
                 (-> name
                     (: :gsub ".*/" "")
                     (: :gsub "[.].*" ""))
                 "]]")
       ,...))


(packages (pkg :Olical/aniseed :ft :fennel)
          :wbthomason/packer.nvim
          (pkg :tpope/vim-unimpaired :event :BufRead)
          :gpanders/nvim-parinfer
          (pkg :numToStr/Comment.nvim :keys :gc :config
             "require('Comment').setup()")
          (cpkg :junegunn/vim-easy-align :keys :ga)
          (pkg :vim-scripts/ReplaceWithRegister :keys :gr)
          :tpope/vim-repeat
          (cpkg :AndrewRadev/switch.vim :requires
             (pkg :tpope/vim-speeddating :keys
                [:<Plug>SpeedDatingFallbackUp :<Plug>SpeedDatingFallbackDown]))
          (pkg :Olical/vim-enmasse :cmd :EnMasse)
          (pkg :tpope/vim-fugitive :cmd [:G] :event :BufRead)
          (pkg :tpope/vim-rhubarb :after :vim-fugitive)
          :tpope/vim-eunuch
          (pkg :Vimjas/vim-python-pep8-indent :ft :python)
          (pkg :norcalli/nvim-colorizer.lua :config "require'colorizer'.setup()")
          :direnv/direnv.vim (cpkg :machakann/vim-sandwich)
          (cpkg :AndrewRadev/splitjoin.vim :keys [:gS :gJ])
          (cpkg :lewis6991/gitsigns.nvim :event :VimEnter :requires
              [:nvim-lua/plenary.nvim])
          (pkg :ray-x/lsp_signature.nvim :config
             "require\"lsp_signature\".setup({floating_window=false})")
          (cpkg :neovim/nvim-lspconfig :after [:lsp_signature.nvim ] :requires [:simrat39/rust-tools.nvim])
          (cpkg :nvim-treesitter/nvim-treesitter :run ":TSUpdate" :requires
              [:nvim-treesitter/playground
               :nvim-treesitter/nvim-treesitter-textobjects])
          (cpkg :L3MON4D3/LuaSnip :requires [:rafamadriz/friendly-snippets])
          (cpkg :hrsh7th/nvim-cmp :requires
              [:hrsh7th/cmp-buffer
               :hrsh7th/cmp-path
               :hrsh7th/cmp-nvim-lsp
               :hrsh7th/cmp-calc
               :hrsh7th/cmp-nvim-lua
               :hrsh7th/cmp-emoji
               :onsails/lspkind-nvim
               :saadparwaiz1/cmp_luasnip
               :L3MON4D3/LuaSnip])
          (pkg :lambdalisue/suda.vim :config :vim.g.suda_smart_edit=1)
          (cpkg :metakirby5/codi.vim :cmd :Codi)
          (pkg :dhruvasagar/vim-table-mode :ft [:markdown :org :orgagenda])
          (cpkg :nvim-lualine/lualine.nvim :requires :gruvbox-flat.nvim)
          (cpkg :kyazdani42/nvim-tree.lua :keys :<leader>t :requires
              :kyazdani42/nvim-web-devicons)
          (pkg :Olical/conjure :ft [:fennel :clojure])
          (cpkg :ibhagwan/fzf-lua :requires
              [:vijaymarupudi/nvim-fzf :kyazdani42/nvim-web-devicons])
          (pkg :eddyekofo94/gruvbox-flat.nvim :config
             "vim.g.gruvbox_flat_style = 'dark'; vim.cmd('colorscheme gruvbox-flat')")
          (pkg :nanotee/zoxide.vim :cmd :Z)
          (pkg :tweekmonster/startuptime.vim :cmd :StartupTime)
          (cpkg :kristijanhusak/orgmode.nvim)
          (pkg :akinsho/org-bullets.nvim :config "require(\"org-bullets\").setup { symbols = { \"◉\", \"○\", \"✸\", \"✿\" } }")
          :rktjmp/hotpot.nvim
          (pkg  :folke/which-key.nvim :config "require('which-key').setup {}"))
    
