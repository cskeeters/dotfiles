local rainbow_on = false;

local function ToggleRainbow()
    if rainbow_on then
        vim.cmd('TSEnable highlight')
        vim.cmd('RainbowParentheses!')
        rainbow_on = false
        vim.notify("TS on, Rainbow off")
    else
        vim.cmd('TSDisable highlight')
        vim.cmd('RainbowParentheses')
        rainbow_on = true
        vim.notify("TS off, Rainbow on")
    end
end

return {
    enabled = true,
    'junegunn/rainbow_parentheses.vim',
    lazy = false,
    keys = {
        {'\\r', ToggleRainbow, noremap = true, silent=true, desc="Toggles Rainbow Parentheses" },
    },
}
