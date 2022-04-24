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
  (s {: trig :regTrig reg-trig :wordTrig true} {1 (f body {}) 2 (i 0)}))

(fn replace-each [replacer]
  (fn wrapper [args]
    (let [len (length (. (. args 1) 1))]
      {1 (replacer:rep len)}))

  wrapper)

(fn date []
  {1 (os.date "%Y-%m-%d")})

(fn uuid- []
  {1 (uuid)})

(fn lorem [args]
  (let [amount (tonumber (. (. (. args 1) :captures) 1))]
    (if (= amount nil) {1 LOREM_IPSUM} {1 (LOREM_IPSUM:sub 1 (+ amount 1))})))

(fn sha256 [secret]
  (.. :chachacha secret))

(fn token-and-hash [n]
  (let [hexstr :0123456789abcdfe]
    (var token "")
    (for [_ 1 (* n 2) 1]
      (local r (math.random 1 16))
      (set token (.. token (hexstr:sub r r))))
    {1 token 2 (.. (sha256 token) ":") 3 ""}))

(ls.add_snippets nil {:direnv {1 (s {:wordTrig true :trig :lay}
                                    {1 (t {1 "layout "})
                                     2 (i 1 {1 :python})
                                     3 (i 0)})}
                      :all {1 (s :user
                                 (fmt "{name}: {token_and_hash}name: {name_again}
  <<: *{group}"
                                      {:token_and_hash (f (fn []
                                                            (token-and-hash 16)))
                                       :group (i 0 :group)
                                       :name (i 1 :username)
                                       :name_again (rep 1)}))
                            2 (sf :date date)
                            3 (sf :uuid uuid-)
                            4 (sf "lorem(%d*)" lorem true)
                            5 (s {:wordTrig true :trig :tt}
                                 {1 (t {1 "╔"})
                                  2 (f (fn []
                                         :0)
                                       {})
                                  3 (t {1 :1 2 :2})
                                  4 (i 0)})
                            6 (s {:trig :bbox}
                                 {1 (t {1 "╔"})
                                  2 (f (replace-each "═") {1 1})
                                  3 (t {1 "╗" 2 "║"})
                                  4 (i 1 {1 :content})
                                  5 (t {1 "║" 2 "╚"})
                                  6 (f (replace-each "═") {1 1})
                                  7 (t {1 "╝"})
                                  8 (i 0)})
                            7 (s {:wordTrig true :trig :sbox}
                                 {1 (t {1 "*"})
                                  2 (f (replace-each "-") {1 1})
                                  3 (t {1 "*" 2 "|"})
                                  4 (i 1 {1 :content})
                                  5 (t {1 "|" 2 "*"})
                                  6 (f (replace-each "-") {1 1})
                                  7 (t {1 "*"})
                                  8 (i 0)})
                            8 (s {:wordTrig true :trig :csv}
                                 {1 (i 1 {1 :content})
                                  2 (t {1 "" 2 :separator 3 ""})
                                  3 (i 2 {1 "|"})
                                  4 (t {1 "" 2 ">>" 3 ""})
                                  5 (l (or (l._1:gsub "," l._2) :adsf)
                                       {1 1 2 2})})}})

((. (require :luasnip/loaders/from_vscode) :lazy_load))

