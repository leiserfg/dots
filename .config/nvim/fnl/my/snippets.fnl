(local ls (require :luasnip))
(local s ls.s)
(local sn ls.sn)
(local t ls.t)
(local i ls.i)
(local f ls.f)
(local c ls.c)
(local d ls.d)

(math.randomseed (os.time))
(fn uuid []
  (let [random math.random
        template :xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx
        out (template:gsub "[xy]"
                           (fn [c]
                             (let [v (or (and (= c :x) (random 0 15))
                                         (random 8 11))]
                               (string.format "%x" v))))]
    out))
(fn copy [args a1 a2]
  (. args 1))

(local LOREM_IPSUM "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquid ex ea commodi consequat. Quis aute iure reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint obcaecat cupiditat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")

(fn sf [trig body regTrig]
  (s {: trig :wordTrig true : regTrig} 
     [(f body {})
      (i 0)]))

(fn replace-each [replacer]
  (fn [args]
    (let [len (length (. (. args 1) 1))]
      [(replacer:rep len)])))

(fn emmet [arg1]
    (local content (. arg1 1 1))
    (sn nil [(t ["asdf" content "asdf"])]))

(set ls.snippets
     {:all [(sf :date #[(os.date "%Y-%m-%d")])
            (sf :uuid #[(uuid)])
            (sf "lorem(%d*)"
                (fn [args]
                  (local amount (tonumber (. args 1 :captures 1)))
                  (if (= amount nil) [LOREM_IPSUM]
                      [(LOREM_IPSUM:sub 1 (+ amount 1))]))
                true)
            (s {:trig :bbox :wordTrig true}
               [(t ["╔"])
                (f (replace-each "═") [1])
                (t ["╗" "║"])
                (i 1 [:content])
                (t ["║"  "╚"])
                (f (replace-each "═") [1])
                (t ["╝"])
                (i 0)])
            (s {:trig :sbox :wordTrig true}
               [(t ["*"])
                (f (replace-each "-") [1])
                (t ["*"  "|"])
                (i 1 [:content])
                (t ["|" "*"])
                (f (replace-each "-") [1])
                (t ["*"])
                (i 0)])
            (s {:trig :ee :wordTrig true}
               [(f #["asdf"] [])
                (i 0)])]

      :direnv [(s {:trig :lay :wordTrig true}
                 [(t ["layout "])
                  (i 1 [:python])
                  (i 0)])]})



(local loader (require :luasnip/loaders/from_vscode))
(loader.load {:include ["all"]})

(local loaded {})
(fn _G.load_snips []
  (let [ft vim.bo.filetype]
    (if (not (. loaded ft))
       (do
         (tset loaded ft true)
         (loader.load {:include [ft]})))))

(vim.cmd "
augroup my_snips
autocmd!
augroup END

au my_snips BufEnter * lua _G.load_snips()
")

