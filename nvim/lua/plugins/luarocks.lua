return {
    enabled = true,
    "vhyrro/luarocks.nvim",
    priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
    config = true,
    opts = {
        rocks = {
            "luautf8",
            -- "lrexlib-pcre" needed for kokoro.  See notes/neovim.md
        },
    }
}
