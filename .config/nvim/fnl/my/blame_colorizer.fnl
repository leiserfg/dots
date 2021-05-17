(fn clamp [x]
  (math.min (math.max x 0) 1))

(fn hsi2rgb [h s i]
    ; h,s,i ∈ [0, 1]
    ; r,g,b ∈ [0, 1]
    ; borrowed from here:
    ; http://hummer.stanford.edu/museinfo
  (let [PITHIRD (/ math.pi 3.0)
        TWOPI (* math.pi 2)
        cos math.cos]
    (var (r g b) nil)
    (if (< h (/ 1 3))
      (do
        (set b (/ (- 1 s) 3))
        (set r (/ (+ 1
                     (/ (* s (cos (* TWOPI h)))
                        (cos (- PITHIRD (* TWOPI h)))))
                  3))
        (set g (- 1 (+ b r)))) (< h (/ 2 3))
      (do
        (set-forcibly! h (- h (/ 1 3)))
        (set r (/ (- 1 s) 3))
        (set g (/ (+ 1
                     (/ (* s (cos (* TWOPI h))) (cos (- PITHIRD (* TWOPI h)))))
                  3))
        (set b (- 1 (+ r g))))
      (do
        (set-forcibly! h (- h (/ 2 3)))
        (set g (/ (- 1 s) 3))
        (set b (/ (+ 1
                     (/ (* s (cos (* TWOPI h))) (cos (- PITHIRD (* TWOPI h)))))
                  3))
        (set r (- 1 (+ g b)))))
    (set r (clamp (* (* i r) 3)))
    (set g (clamp (* (* i g) 3)))
    (set b (clamp (* (* i b) 3)))
    (values r g b)))

(local steps [0.35 0.5 0.65])

(fn hash_as_int [hash-str]
  (tonumber (string.sub hash-str -8) 16))

(fn hash-to-hsi [hash]
  (let [h (% hash 359)
        s (. steps (+ 1 (% hash (length steps))))
        i (. steps (+ 1 (% (bit.rshift hash 2) (length steps))))]
      {:h (/ h 360.0) :s s :i i}))

(fn hsi-to-rgb [hsi]
  (let [(r g b) (hsi2rgb hsi.h hsi.s hsi.i)
        tmp {}]
    (each [idx val (ipairs {1 r 2 g 3 b})]
      (tset tmp idx (string.format "%x" (math.floor (* val 255)))))
    (table.concat tmp "")))

(local prefix :blame_color)
(local namespace (vim.api.nvim_create_namespace prefix))
(local HIGHLIGHT_CACHE {})

(fn make-highlight-name [rgb]
  (table.concat {1 prefix 2 rgb} "_"))

(macro ex [parts]
  `(vim.api.nvim_command (table.concat ,parts " ")))

(fn create-highlight [hsi  mode]
  (let [mode (or mode :background)
        rgb-hex (hsi-to-rgb hsi)]
    (var highlight-name (. HIGHLIGHT_CACHE rgb-hex))
    (when (not highlight-name)
      (set highlight-name (make-highlight-name rgb-hex))
      (if (= mode :foreground)
          (ex [:highlight highlight-name  (.. "guifg=#" rgb-hex)])
          (let [fg-color (or (and (>= hsi.i 0.5) :Black) :White)]
            (ex [:highlight
                 highlight-name
                 (.. :guifg= fg-color)
                 (.. "guibg=#" rgb-hex)])))
      (tset HIGHLIGHT_CACHE rgb-hex highlight-name))
    highlight-name))


(local WORD2HSI_CACHE  {})
(fn word2hsi [line]
  (let [hash (tonumber (string.sub line 1 8) 16)]
    (var hsi (. WORD2HSI_CACHE hash))
    (when (not hsi)
      (do
        (set hsi (hash-to-hsi hash))
        (tset WORD2HSI_CACHE hash hsi)))
    hsi))

(fn highlight_hashes []
  (let [buffer (vim.api.nvim_get_current_buf)
        lines (vim.api.nvim_buf_get_lines buffer 0 (- 1) false)]
    (each [line-number line (ipairs lines)]
      (local hash-str (line:match "[0-9a-f]+"))
      (local hsi (word2hsi hash-str))
      (local hl-name (create-highlight hsi))
      (vim.api.nvim_buf_add_highlight buffer namespace hl-name (- line-number 1)
                                      0 (+ (length hash-str) 1)))))

{: highlight_hashes}
