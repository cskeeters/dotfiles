deb_installed_packages() {
    dpkg -l | sed '1,/===/d' | cut -d ' ' -f 3 | fzf
}
