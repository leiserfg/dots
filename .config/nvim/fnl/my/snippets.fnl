(local ls (require :luasnip))
(local l (. (require :luasnip.extras) :l))
(local rep (. (require :luasnip.extras) :rep))
(local fmt (. (require :luasnip.extras.fmt) :fmt))
(local s ls.s)
(local sn ls.sn)
(local t ls.t)
(local i ls.i)
(local f ls.f)

(math.randomseed (os.time))

(fn uuid []
  (let [random math.random
        template :xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx]
    (var out nil)

    (fn subs [c]
      (let [v (or (and (= c :x) (random 0 15)) (random 8 11))]
        (string.format "%x" v)))

    (set out (template:gsub "[xy]" subs))
    out))

(local LOREM_IPSUM
       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquid ex ea commodi consequat. Quis aute iure reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint obcaecat cupiditat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")

(fn sf [trig body reg-trig]
  (s {: trig :regTrig reg-trig :wordTrig true} [ (f body {})  (i 0)]))

(fn replace-each [replacer]
  (fn wrapper [args]
    (let [len (length (. args 1 1))]
      [(replacer:rep len)]))
  wrapper)

(fn date []
  {1 (os.date "%Y-%m-%d")})

(fn uuid- []
  {1 (uuid)})

(fn lorem [args]
  (let [amount (tonumber (. args 1 :captures 1))]
    (if (= amount nil)
      [LOREM_IPSUM]
      [(LOREM_IPSUM:sub 1 (+ amount 1))])))

(ls.add_snippets nil {:direnv [
                               (s {:wordTrig true :trig :lay}
                                  [(t ["layout "])
                                   (i 1 [:python])
                                   (i 0)])]
                      :all [
                            (sf :date date)
                            (sf :uuid uuid-)
                            (sf "lorem(%d*)" lorem true)
                            (s {:trig :bbox}
                               [(t ["╔"])
                                (f (replace-each "═") {1 1})
                                (t ["╗" "║"])
                                (i 1 {1 :content})
                                (t ["║" "╚"])
                                (f (replace-each "═") {1 1})
                                (t {1 "╝"})
                                (i 0)])
                            (s {:wordTrig true :trig :sbox}
                               [(t ["*"])
                                (f (replace-each "-") {1 1})
                                (t ["*" "|"])
                                (i 1 [:content])
                                (t ["|" "*"])
                                (f (replace-each "-") {1 1})
                                (t ["*"])
                                (i 0)])]})


((. (require :luasnip/loaders/from_vscode) :lazy_load))
