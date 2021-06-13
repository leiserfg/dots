(fn se= [o v]
  "set option sym 'o' to value 'v'"
  (let [o (if (= :string (type o)) o `,(tostring o))
        v (if (= nil v) true v)]
    (if (= "no" (o:sub 1 2))
        (se= (o:sub 3) false)
        `(tset vim.opt ,o ,v))))

(fn set-op [o v op]
  (let [o (if (= :string (type o)) o `,(tostring o))]
    `(: (. vim.opt  ,o) ,op ,v)))

(fn se^ [o v]  (set-op o v :prepend))
(fn se- [o v]  (set-op o v :remove))
(fn se+ [o v]  (set-op o v :append))

(fn cmd [arg]
  `(vim.cmd ,arg))

(fn g [o v]
   (let [o (if (= :string (type o)) o `,(tostring o))]
    `(tset vim.g ,o ,v)))
{: se= : cmd : g : se- : se+  : se^}
