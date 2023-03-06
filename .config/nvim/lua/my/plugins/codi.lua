vim.g["codi#interpreters"] = {
  rink = { bin = "rink", prompt = "> " },
  python = {
    bin = "python3",
    prompt = "^(>>>|...) ",
  },
}

return { { cmd = "Codi", "metakirby5/codi.vim" } }
