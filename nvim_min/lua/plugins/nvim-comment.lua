return {
    enabled = true,
    'terrortylor/nvim-comment',
    lazy = false,

    init = function()
        require('nvim_comment').setup({
            -- Linters prefer comment and line to have a space in between markers
            marker_padding = true,
            -- should comment out empty or whitespace only lines
            comment_empty = true,
            -- trim empty comment whitespace
            comment_empty_trim_whitespace = true,
            -- Should key mappings be created
            create_mappings = false, -- I'm creating mapping so that I can put descriptions in them
            -- Normal mode mapping left hand side
            line_mapping = "gcc",
            -- Visual/Operator mapping left hand side
            operator_mapping = "gc",
            -- text object mapping, comment chunk,,
            comment_chunk_text_object = "ic",
            -- Hook function to call before commenting takes place
            hook = nil
        })
    end,

    --local opts = { noremap = true }
    --api.nvim_set_keymap("n", M.config.line_mapping, "<Cmd>set operatorfunc=CommentOperator<CR>g@l", opts)
    --api.nvim_set_keymap("n", M.config.operator_mapping, "<Cmd>set operatorfunc=CommentOperator<CR>g@", opts)
    --api.nvim_set_keymap("x", M.config.operator_mapping, ":<C-u>call CommentOperator(visualmode())<CR>", opts)
    --api.nvim_set_keymap(
      --"x",
      --M.config.comment_chunk_text_object,
      --"<Cmd>lua require('nvim_comment').select_comment_chunk()<CR>",
      --opts
    --)
    --api.nvim_set_keymap(
      --"o",
      --M.config.comment_chunk_text_object,
      --"<Cmd>lua require('nvim_comment').select_comment_chunk()<CR>",
      --opts
    --)


    keys = {
        -- FIXME Figure out how visual mode is mapped, then turn off default mapping
        { 'gcc', '<Cmd>CommentToggle<cr>',           noremap = true, desc="Comment line" },
        -- { 'gc',  '<C-u><Cmd>CommentToggle<cr>', mode='v', noremap = true, desc="Comment selected text" },
    },
}
