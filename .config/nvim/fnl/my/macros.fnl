(fn get-scope [o]
  "get scope for option 'o'"
  (let [(okay? info) (pcall vim.api.nvim_get_option_info o)]
    (when okay?
      (. info :scope))))

(fn set-option [o v s]
  "set option 'o' to value 'v' in scope 's'"
  (match s
    :global `(tset vim.o ,o ,v)
    :win    `(do 
               (tset vim.o ,o ,v)
               (tset vim.wo ,o ,v))

    :buf    `(do
              (tset vim.o ,o ,v)
              (tset vim.bo ,o ,v))
    _       (print (.. "se- invalid scope '" s "' for option '" o "'"))))

(fn se- [o v]
  "set option sym 'o' to value 'v'"
  (let [o (if (= :string (type o)) o `,(tostring o))
        v (if (= nil v) true v)
        s (get-scope o)]
    (if s
      `,(set-option o v s)
      (= "no" (o:sub 1 2))
      (se- (o:sub 3) false)
      (print (.. "se- option '" o "' not found")))))

(fn cmd [arg]
  `(vim.cmd ,arg))

(fn le- [k v]
  `(tset vim.g ,k ,v))
{: se- : cmd : le-}
