return {
    enabled = true,
    'cskeeters/soulver3.vim',
    lazy = true,
    ft="soulver",
    dependencies = {
        'prabirshrestha/async.vim'
    },
    init = function()
        -- vim.g.soulver_cli_path = "/opt/homebrew/bin/soulver"
    end,
    config = function()
        vim.keymap.set('n', '<localleader>l', [[<Cmd>SoulverModeLive<Cr>]], { desc="Soulver Mode Live" });
        vim.keymap.set('n', '<localleader>s', [[<Cmd>SoulverModeSave<Cr>]], { desc="Soulver Mode Save" });
        vim.keymap.set('n', '<localleader>o', [[<Cmd>SoulverModeOff<Cr>]],  { desc="Soulver Mode Off" });
    end
}


-- test.soulver
--
-- people = 5
-- drinks = 3
--
-- wedding_cost = people * drinks
--
-- balance = 0
-- balance += 21.99
-- balance += 21.99
-- balance -= 21.99
