return {
  "vhyrro/luarocks.nvim",
  priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
  config = true,
  opts = {
      rocks = {
          "luautf8",
          -- "lrexlib-pcre", Needed for kokoro, but better to install manually
          --
          -- Debian:
          --   apt-get install libpcre3-dev
          --   luarocks install lrexlib-pcre --lua-version=5.1 PCRE_LIBDIR=/usr/lib/aarch64-linux-gnu
          --   ?? apt-get install lua-rex-pcre

          -- MacOS:
          -- luarocks install lrexlib-pcre --lua-version=5.1
          -- Test: lua print(require("rex_pcre") ~= nil and "Loaded" or "Failed")
          -- "lrexlib-pcre",
      },
  }
}
