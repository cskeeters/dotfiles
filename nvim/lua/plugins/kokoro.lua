return {
    enabled = true,
    'cskeeters/kokoro.nvim',
    lazy = false,
    config = function()
        -- Verify it loads
        local ok, rex = pcall(require, "rex_pcre")
        if not ok then
            print("Failed to load lrexlib-pcre: " .. rex)
            print("Install with:")
            print("  luarocks install lrexlib-pcre --lua-version=5.1")
        end

        require 'kokoro'.setup({
            -- Setting debug to true will route tinymist's stderr to :messages
            debug = false,
            path = os.getenv("HOME")..'/working/kokoro-tts',
            player = "afplay",

            conda_env = "kokoro",

            load_voices = true,

            voice = "af_aoede",
        })

        vim.keymap.set({'v'}, '<Leader>gk', ":Kokoro<Cr>", { noremap=true, silent=true, desc="Read selected text with Kokoro" })
        vim.keymap.set({'n'}, '<Leader>gk', ":Kokoro<Cr>", { noremap=true, silent=true, desc="Read current line with Kokoro" })
        vim.keymap.set({'n'}, '<Leader>gK', ":KokoroStop<Cr>", { noremap=true, silent=true, desc="Stop playing audio from Kokoro" })
        vim.keymap.set({'n'}, '<Leader><Leader>gkv', ":KokoroChooseVoice<Cr>", { noremap=true, silent=true, desc="Choose voice for Kokoro" })
        vim.keymap.set({'n'}, '<Leader><Leader>gks', ":KokoroChooseSpeed<Cr>", { noremap=true, silent=true, desc="Choose speed for Kokoro" })
    end
}
