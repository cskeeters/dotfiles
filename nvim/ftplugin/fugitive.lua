function os.capture(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  if raw then return s end
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

local open_cmd = "xdg-open"
if os.capture('uname') == "Darwin" then
    open_cmd = "open"
end

function Normal(keys)
    local from_part = true; -- always true
    local translate_less_than = true; --<lt>
    local special = true; -- translate <CR> <Esc>
    local translated_keys = vim.api.nvim_replace_termcodes(keys, from_part, translate_less_than, special);
    vim.cmd.normal(translated_keys);
end

function FugitivePush()
    vim.cmd([[G push]])
end
function FugitiveOpen()
    Normal([[o<C-w><C-p><C-w>c]]);
end
function FugitiveDiff()
    FugitiveOpen();
    Normal([[<Leader>fd]]);
end
function FugitiveDiffTab()
    Normal([[O<Leader>fD]]);
end
function FugitiveOpenExternal()
    local gitdir = vim.fn.FugitiveGitDir()
    if gitdir ~= "" then
        local rootdir = vim.fn.fnamemodify(gitdir, ':h')
        -- print("rootdir: "..rootdir)
        local current_line = vim.api.nvim_get_current_line()
        print(current_line)
        file_sub_path = string.sub(current_line,3)
        print(file_sub_path)
        local path = vim.fn.fnamemodify(rootdir, ':p') .. file_sub_path

        -- open could be changed to xdg-open on linux
        vim.cmd.execute('"!'..open_cmd..' '..vim.fn.shellescape(path)..'"')
    end
end

vim.keymap.set('n', '<leader>gp', FugitivePush, { buffer=true, desc='Fugitive/git push' })
vim.keymap.set('n', 'go', FugitiveOpen, { buffer=true, desc='Open file in current window' })
vim.keymap.set('n', 'gd', FugitiveDiffTab, { buffer=true, desc='vimdiff on current file object' })

vim.keymap.set('n', '<leader>fd', "O<Leader>fd", { buffer=true, desc="Fugitive/git diff" });
vim.keymap.set('n', '<localleader>o', FugitiveOpenExternal, { buffer=true, desc="Open with external application" });
