(require-macros :my.macros)

(var packer (require :packer))

(macro use- [name ...]
  (let [opts [...]
        path (.. :my.plugins/
              (-> name
                (: :gsub ".*/" "")
                (: :gsub "[.].*" "")))
        args [name]]


    (tset args :config (..
                         "local k, v = pcall(require, '" 
                         path
                         "') ; if not k and v:find('module') == nil then print('"
                         path
                         "',  v) end"))
    (for [i 1 (length opts) 2]
      (tset args
            (. opts i)
            (. opts (+ i 1))))
    `(use ,args)))

(packer.startup
  (fn [use]
    (use- :wbthomason/packer.nvim)
    (use- :tpope/vim-unimpaired) ; gc
    (use- :tpope/vim-rsi) ; readline
    (use- :b3nj5m1n/kommentary :keys :gc)
    (use- :junegunn/vim-easy-align :keys :ga)
    (use- :vim-scripts/ReplaceWithRegister :keys :gr)
    (use- :vim-scripts/vis)        ; :'<,'>B
    (use- :tpope/vim-repeat)
    (use- :AndrewRadev/switch.vim
          :requires [:tpope/vim-speeddating] 
          :keys [:<c-a> :<c-x>])
    (use- :Olical/vim-enmasse :cmd :EnMasse)
    (use- :junegunn/vim-peekaboo)
    (use- :tpope/vim-fugitive)
    (use- :tpope/vim-rhubarb)
    (use- :tpope/vim-eunuch)
    (use- :sheerun/vim-polyglot)
    (use- :norcalli/nvim-colorizer.lua)
    (use- :direnv/direnv.vim)
    (use- :machakann/vim-sandwich)
    (use- :AndrewRadev/splitjoin.vim
          :cmd [:SplitjoinSplit :SplitjoinJoin])
    (use- :tpope/vim-dispatch
          :cmd [:Dispatch :Make :Focus :Start])
    (use- :lewis6991/gitsigns.nvim 
          :requires  [:nvim-lua/plenary.nvim])
    (use- :neovim/nvim-lspconfig)
    (use- :nvim-treesitter/nvim-treesitter
          :requires [:nvim-treesitter/playground :p00f/nvim-ts-rainbow])

    (use- :L3MON4D3/LuaSnip
          :requires [:rafamadriz/friendly-snippets])

    (use- :hrsh7th/nvim-compe
          :require [:tami5/compe-conjure])

    (use- :lambdalisue/suda.vim :config "vim.g.suda_smart_edit=1")

    (use- :metakirby5/codi.vim)

    (use- :dhruvasagar/vim-table-mode :ft :markdown)

    (use- :hoob3rt/lualine.nvim
          :requires {1 :kyazdani42/nvim-web-devicons :opt true})
    (use- :junegunn/fzf.vim)

    (use- :lambdalisue/fern.vim
          :requires [:antoinemadec/FixCursorHold.nvim :lambdalisue/fern-hijack.vim]
          :config
          #(cmd "nnoremap <silent> <leader>t :Fern . -drawer -toggle<CR>"))

    (use- :Olical/conjure
          :ft [:fennel :clojure])
    (use- :eraserhd/parinfer-rust
          :run "cargo build --release"
          :ft [:fennel :janet :clojure])
    (use- :Olical/aniseed)
    (use- :sainnhe/gruvbox-material :config #(cmd "colorscheme gruvbox-material"))))