vim.g["codi#interpreters"] = {
  rink = { bin = "rink", prompt = "> " },
  python = {
    bin = "python3",
    prompt = "^(>>>|...) ",
  },
  uiua = {
    bin = { "uiua", "repl" },
    prompt = "^» ",
  },
}

-- vim.g["codi#rightsplit"] = 1
-- vim.g["codi#raw"] = 1
-- vim.g["codi#log"] = "/tmp/codi.log"

return { { cmd = "Codi", "metakirby5/codi.vim" } }
