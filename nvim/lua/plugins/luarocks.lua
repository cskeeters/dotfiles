return {
  "vhyrro/luarocks.nvim",
  priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
  config = true,
  opts = {
      rocks = {
          "luautf8",

          -- Better to run: luarocks install lrexlib-pcre --lua-version=5.1
          -- Test: lua print(require("rex_pcre") ~= nil and "Loaded" or "Failed")
          -- "lrexlib-pcre",
      },
      extra_options = {
        -- "--with-pcre2=/opt/homebrew", -- Points to Homebrew's PCRE2 prefix
        -- Alternatively, use these if the above doesn't work:
        -- "--with-pcre2-include=/opt/homebrew/include",
        -- "--with-pcre2-lib=/opt/homebrew/lib",
      },
  }
}
