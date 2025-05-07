-- Requires junegunn/fzf

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

return {
    entry = function(_, args)
        local permit = ya.hide()
        local path = os.capture("cat $HOME/.paths | fzf -d '\t' --with-nth 2.. --accept-nth 1", false)
        if path ~= '' then
            ya.mgr_emit("cd", { path })
        end

        permit:drop()

    end,
}
