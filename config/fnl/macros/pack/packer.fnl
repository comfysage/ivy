(local {: str? : nil?} (require :macros.lib.types))

(tset _G :macros/pack [])
(tset _G :macros/rock [])

(lambda pack [identifier ?options]
  "A workaround around the lack of mixed tables in Fennel.
  Has special `options` keys for enhanced utility.
  See `:help macros.pack.packer.pack` for information about how to use it."
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (assert-compile (or (nil? ?options) (table? ?options)) "expected table for options" ?options)
  (let [options (or ?options {})
        options (collect [k v (pairs options)]
                  (match k
                    :require* (values :config (string.format "require(\"%s\")" v))
                    :setup* (values :config (string.format "require(\"%s\").setup()" v))
                    _ (values k v)))]
    (doto options (tset 1 identifier))))

(lambda pack! [identifier ?options]
  "A plugin declaration.
  It is a wrapper over `pack` that adds it to the macros/pack global to later
  be used in the `unpack!` macro."
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (assert-compile (or (nil? ?options) (table? ?options)) "expected table for options" ?options)
  (table.insert _G.macros/pack (pack identifier ?options)))

(lambda rock! [identifier]
  "A rock declaration.
  This macro adds it to the `macros/rock` global to later be used in the
  `unpack!` macro."
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (table.insert _G.macros/rock identifier))

(lambda unpack! []
  "Initializes `packer.nvim` with the previously declared plugins."
  (let [packs (icollect [_ v (ipairs _G.macros/pack)] `(use ,v))
        rocks (icollect [_ v (ipairs _G.macros/rock)] `(use_rocks ,v))
        use-sym (sym :use)]
    (tset _G :macros/pack [])
    (tset _G :macros/rock [])
    `((. (require :packer) :startup)
      (fn [,use-sym]
        ,(unpack (icollect [_ v (ipairs packs) :into rocks] v))))))

{: pack
 : pack!
 : rock!
 : unpack!}
