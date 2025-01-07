local posix = require("posix") -- luarocks install luaposix

local M = {}

-- Runs cmd (with variable arguments) and returns the pid, stdin, stdout, and
-- stderr file descriptors for the child process
function M.exec(cmd, ...)
    -- pipe() creates a pipe, a unidirectional data channel that can be used
    -- for interprocess communication. The parent process will:
    --  * write to   in_w to write data to be read in by the child process via stdin
    --  * read from out_r to read the child processe's stdout
    --  * read from err_r to read the child processe's stderr
    local  in_r,  in_w = posix.pipe()
    local out_r, out_w = posix.pipe()
    local err_r, err_w = posix.pipe()

    assert( in_r ~= nil, "pipe() failed for stdin")
    assert(out_r ~= nil, "pipe() failed for stdout")
    assert(err_r ~= nil, "pipe() failed for stderr")

    local pid, err = posix.fork()
    assert(pid ~= nil, "fork() failed")
    if pid == 0 then
        -- Child Process Code
        posix.close(in_w)  -- child process should not write it's own stdin
        posix.close(out_r) -- child process should not read it's own stdout
        posix.close(err_r) -- child process should not read it's own stderr

        -- posix.dup2( in_r, posix.fileno(io.stdin )) -- make the read  end of the pipe the stdin  for this process
        -- posix.dup2(out_w, posix.fileno(io.stdout)) -- make the write end of the pipe the stdout for this process
        -- posix.dup2(err_w, posix.fileno(io.stderr)) -- make the write end of the pipe the stderr for this process

        posix.dup2( in_r, posix.unistd.STDIN_FILENO ) -- make the read  end of the pipe the stdin  for this process
        posix.dup2(out_w, posix.unistd.STDOUT_FILENO) -- make the write end of the pipe the stdout for this process
        posix.dup2(err_w, posix.unistd.STDERR_FILENO) -- make the write end of the pipe the stderr for this process

        posix.close( in_r) -- we don't need the extra file descriptor now that it's accessible via STDIN_FILENO
        posix.close(out_w) -- we don't need the extra file descriptor now that it's accessible via STDOUT_FILENO
        posix.close(err_w) -- we don't need the extra file descriptor now that it's accessible via STDERR_FILENO

        -- The child process will use the same stdin, stdout, and stderr file descriptors that we've setup
        local ret, err = posix.execp(cmd, table.unpack({...}))

        -- This code only runs if execp fails
        assert(ret ~= nil, "execp() failed")
        posix._exit(1)
        return -- this will never run
    end

    -- Parent Process Code
    -- These are for the child only
    posix.close(in_r )
    posix.close(out_w)
    posix.close(err_w)

    return pid, in_w, out_r, err_r
end

-- run will:
--  start cmd with arguments
--  write input to subprocesse's stdin
--  wait for completion, and then
--  return exit status (as int), stdout (as string), and stderr (as string) from cmd.
function M.run(input, cmd, ...)
    local pid, in_fd, out_fd, err_fd = M.exec(cmd, table.unpack({...}))
    assert(pid ~= nil, "Error running "..cmd..".  Unable to fork")

    -- Write to popen3's stdin
    posix.write(in_fd, input)
    -- Must close it as some (most?) proccess block until the stdin pipe is closed
    posix.close(in_fd)

    local bufsize = 4096

    -- Read stdout
    local stdout = ""
    while true do
        local buf = posix.read(out_fd, bufsize)
        if buf == nil or #buf == 0 then
            break
        end
        stdout = stdout .. buf
    end

    -- Read stderr
    local stderr = ""
    while true do
        local buf = posix.read(err_fd, bufsize)
        if buf == nil or #buf == 0 then
            break
        end
        stderr = stderr .. buf
    end

    -- Clean-up child (no zombies) and get return status
    local wait_pid, wait_cause, wait_status = posix.wait(pid)

    return wait_status, stdout, stderr
end

return M
