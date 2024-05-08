-- Makes telescope accept fzf syntax by using cpp version of fzf (which is written in go btw)
-- require('telescope').load_extension('fzf') in telescope.lua
return {
    enabled = true,
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    lazy = false,
}
