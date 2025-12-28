dnf_installed_packages() {
    dnf list --installed | sed -n '2,$p' | fzf --prompt "PACKAGE> "
}
