`cmdsnip` allows users to fuzzy search for and complete, and run shell commands that are captured in [SnipMate](https://github.com/garbas/vim-snipmate)-style snippets.

Unlike SnipMate, where the command is expanded immediately and the cursor jumps through tab-stops and placeholder, each placeholder is specified by the user with some TUI and then the completed command is set at the prompt as if the user typed it in.

# Requirements

- [junegunn/fzf](https://github.com/junegunn/fzf)
- [charmbracelet/gum](https://github.com/charmbracelet/gum)

## Optional/Useful

When defining custom functions, you may find `jq` and `yq` useful for extracting specific data from JSON and YAML files.

- [jqlang/jq](https://github.com/jqlang/jq)
- [mikefarah/yq](https://github.com/mikefarah/yq)


# Example

```
snippet growisofs_burn bcst: Burn DVD (growisofs)
    growisofs -Z /dev/cdrom -JR ${1:burn}
```

FZF would show:

    bcst: Burn DVD (growisofs)
    > grow

Then the user would be able to specify the folder to burn.

    > my_burn

Then the full command would be set as the current command, but not executed.  (Uses Bash 4's `$READLINE_LINE` variable.)

    # growisofs -Z /dev/cdrom -JR my_burn


# Snippets


## Placeholders

Placeholders `${1}` can prompt for text or run a function that returns text.

### Text Entry

| Placeholder Syntax                    | Description                                                                   |
|---------------------------------------|-------------------------------------------------------------------------------|
| `${1}`                                | Prompt the user                                                               |
| `${1:<DEFAULT>}`                      | Specify default value                                                         |
| `${1:<PROMPT>:}`                      | Customize prompt (`FILE>`)                                                    |
| `${1:<PROMPT>:<PLACEHOLDER>}`         | Include a *placeholder* that disappears once the user starts typing           |
| `${1:<PROMPT>:<DEFAULT>}`             | Prompt and default value                                                      |
| `${1:<PROMPT>:<PLACEHOLDER>;<VALUE>}` | Prompt and default value that shows placeholder when default value is deleted |

### Functions

`cmdsnip` will load functions defined in files with a `.sh` extension located in `~/.config/cmd/` and those can be called with placeholders in snippets.

`growisofs.sh`:
```sh
growisofs_devices() {
    # Could dynamically detect devices here

    # whatever is output is set in the placeholder
    # you can use fzf to allow the user to select an option
    cat <<- EOF | fzf
	/dev/cdrom
	/dev/sr1
	EOF
}
```

`growisofs.snippets`:
```
snippet growisofs_burn bcst: Burn DVD (growisofs)
	growisofs -Z ${2:growisofs_devices()} -JR ${1:burn}
```
> [!NOTE]
> `()` is used to denote a function in the placeholder.

> [!NOTE]
> Functions can take arguments like the *prompt* you want fzf to display to the user.

#### Values

Functions have access to a `VALUES` array that has the current values of already set placeholders.  You can pass the placeholder number as an argument to a function so that the function can use a user-specified value as an argument.

For example, if a user selects a file in `${1}`, the extension can be removed with `cmd_remove_ext(1)`, which is defined in `functions.sh`.  The placeholder number is passed in as the first argument, so it's set in `$1`.  The user-specified value is accessed with `${VALUES[$1]}` and `%.*` is bash magic to remove the extension.

```sh
cmd_remove_ext() {
    echo "${VALUES[$1]%.*}"
}
```


# Installation

Just add `.cmdsnip.sh` to your home directory.

```sh
cd
curl -o .cmdsnip.sh https://github.com/cskeeters/cmdsnip/cmdsnip.sh
```

Create a folder for snippets and functions.

```sh
mkdir -p ~/.config/cmd
```

Create a folder for snippets and functions.  Add helper functions in functions.sh.

```sh
mkdir -p ~/.config/cmd
curl -o ~/.config/cmd/function.sh https://github.com/cskeeters/cmdsnip/functions.sh
```

# Configuration

Source `.cmdsnip.sh` by adding the following to your `.bashrc`:

```sh
if [[ -t 1 ]]; then
    # cmdsnip requires fzf
    if exists fzf; then
        if [[ -f ~/.cmdsnip.sh ]]; then
            export CMDSNIP_LOG_LEVEL=6 # for developers
            source ~/.cmdsnip.sh

            # -x is important for setting the command (READLINE_LINE and READLINE_POINT)
            echo adding bindings
            bind -x '"\C-x\C-j": select_run_snippet'
            bind -x '"\C-x\C-k": rerun_snipet'
            echo done
        fi
    else
        echo "cmdsnip will not load because fzf is not installed"
    fi
fi
```

Now pressing Ctrl+x, Ctrl+k will run `select_run_snippet`, which is defined in `.cmdsnip.sh`
