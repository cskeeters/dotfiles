# Offline Installation

Adding neovim to an offline computer requires that all plugins (which are installed in `.local/share/nvim`) be copied with the configuration that uses them.  If the plugins compiles any libraries, these libraries must be compiled on the same architecture and on the same version of the OS to ensure they will work.

Some plugins automatically download the source for their shared libraries and install them and others assume that the user has provided the library on the system ahead of launching the plugin.

Some lua code depends on luarocks which are typically c++ programs compiled for easy access to lua code.

WARN: Some of the luarocks require libraries to already be installed on the system.

## Language Servers Protocol (LSP) Servers

Most language servers are written in a compiled language.  `mason.nvim` handles downloading and compiling language servers to `.local/share/nvim/mason`.  Not all servers will compile with older compilers.  Some may require `go` or `rust`/`cargo` compilers to be installed, or may require [nodejs](https://nodejs.org/en) to run.

If the LSP servers have already been compiled, they will be copied with the `.local/share/nvim`

## Treesitter

[tree-sitter](https://tree-sitter.github.io/tree-sitter/) handles syntax highlighting.  Most parsers are written in a compiled language and get compiled to a shared object (`.so`) that will be placed in `.local/share/nvim/lazy/nvim-treesitter/parser`

The [vim parser](https://github.com/tree-sitter-grammars/tree-sitter-vim) hangs when compiling with clang

```sh
/home/chad/.local/share/nvim/tree-sitter-vim
clang -o parser.so -I./src src/parser.c src/scanner.c -Os -std=c11 -shared -fPIC # Hangs
```

Compile it with gcc instead

```sh
gcc -o parser.so -I./src src/parser.c src/scanner.c -Os -std=c11 -shared -fPIC
```

See the `treesitter.lua` config:

```lua
require'nvim-treesitter.install'.compilers = { "clang" }
```

Apply this to `.local/share/nvim/lazy/nvim-treesitter/lua/nvim-treesitter` to see commands.

```diff
diff --git a/lua/nvim-treesitter/install.lua b/lua/nvim-treesitter/install.lua
index cd12dbb8..55f52db5 100644
--- a/lua/nvim-treesitter/install.lua
+++ b/lua/nvim-treesitter/install.lua
@@ -292,6 +292,12 @@ local function iter_cmd_sync(cmd_list)
       print(cmd.info)
     end

+    if cmd.opts.cwd then
+        print("Running: "..cmd.cmd .. " " .. table.concat(cmd.opts.args, " ") .. " in " .. cmd.opts.cwd)
+    else
+        print("Running: "..cmd.cmd .. " " .. table.concat(cmd.opts.args, " "))
+    end
+
     if type(cmd.cmd) == "function" then
       cmd.cmd()
     else
```

## luasnip

`luasnip` requires the luarock [`jsregexp`](https://github.com/kmarius/jsregexp) which is written in *c*.

luasnip will download and build three versions of jsregexp (0.0.5, 0.0.6, and 0.1.0) into (`.local/share/nvim/lazy/LuaSnip/deps`).

For this to work on RHEL7, clang needs to be used by specifying the following in the lazy.nvim config.

```lua
build = "CC=clang make install_jsregexp",
```

WARN: It is **NOT** advised to try and install this with `luarocks` separately.

## LuaRocks

For the plugins tha need Lua rocks but don't automatically download and isntall them, I add them nanually using luarocks.

# Build Offline Installation

On a machine with the target OS and architecture:

1. Install LuaRocks.

    OL7 doesn't include luarocks, so I compile from source.

    ```sh
    wget https://luarocks.org/releases/luarocks-3.12.2.tar.gz
    tar -zxf luarocks-3.12.2.tar.gz
    cd luarocks-3.12.2/
    ./configure
    make
    sudo make install
    ```

    Compiling rocks on OL7 requires custom `CFLAGS` since the compiler is so old.

    ```sh
    luarocks install luafilesystem --lua-version=5.1 --tree $HOME/.luarocks CFLAGS="-fPIC -I/usr/include/luajit-2.0"
    luarocks install luautf8       --lua-version=5.1 --tree $HOME/.luarocks CFLAGS="-std=c99 -fPIC -I/usr/include/luajit-2.0"
    luarocks install lrexlib-pcre  --lua-version=5.1 --tree $HOME/.luarocks CFLAGS="-std=c99 -fPIC -I/usr/include/luajit-2.0"
    ```

2. Copy *dotfiles* for nvim configuration

3. Run neovim to automatically install plugins, LSP servers, and tree-sitter parsers.

    ```sh
    nvim --headless \
         +'Lazy sync' \
         +'TSInstallSync bash c cpp css diff go html java javascript lua make markdown markdown_inline php pug rst rust sql toml typst vhs vim yaml' \
         +'qa!'

    nvim --headless \
        +'sleep 5' \
        +'qa!'
    ```

    Run `:Lazy` and then press `S` to update all plugins.

    Do the same for `nvim_min` (which has no LSP servers and no tree-sitter parsers)

    ```sh
    export NVIM_APPNAME=nvim_min
    nvim --headless \
         +'Lazy sync' \
         +'qa!'
    ```

4. Create a tar file for other required files

    ```sh
    cd $HOME
    tar -zcf luarocks.tgz .luarocks
    tar -zcf neovim_local.tgz .local/share/nvim .local/share/nvim_min
    ```
