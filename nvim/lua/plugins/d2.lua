-- Currently this causes an issue with syntax highlighting with java files.
--   https://github.com/terrastruct/d2-vim/issues/26
return {
    enabled = false,
    'terrastruct/d2-vim',
    lazy = false,
    ft = 'd2',
}
