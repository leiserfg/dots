local snap = require "snap"
local fzy = snap.get "consumer.fzy"
local fzf = snap.get "consumer.fzf"
local limit = snap.get "consumer.limit"
local producer_file = snap.get "producer.ripgrep.file"
local producer_jumplist = snap.get "producer.vim.jumplist"
local producer_git = snap.get "producer.git.file"
local producer_luv_file = snap.get "producer.luv.file"
local producer_vimgrep = snap.get "producer.ripgrep.vimgrep"
local producer_buffer = snap.get "producer.vim.buffer"
local producer_currentbuffer = snap.get "producer.vim.currentbuffer"
local producer_oldfile = snap.get "producer.vim.oldfile"
local select_file = snap.get "select.file"
local select_jumplist = snap.get "select.jumplist"
local select_vimgrep = snap.get "select.vimgrep"
local select_currentbuffer = snap.get "select.currentbuffer"
local preview_file = snap.get "preview.file"
local preview_vimgrep = snap.get "preview.vimgrep"
local preview_jumplist = snap.get "preview.jumplist"
local function _1_()
  return snap.run {
    initial_filter = vim.fn.input "Grep> ",
    multiselect = select_vimgrep.multiselect,
    producer = limit(50000, producer_vimgrep),
    prompt = "Grep",
    select = select_vimgrep.select,
    steps = { { config = { prompt = "FZY> " }, consumer = fzy } },
    views = { preview_vimgrep },
  }
end
snap.register.map({ "n" }, { "<Leader>ff" }, _1_)
