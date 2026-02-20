man_sections() {
    man "${VALUES[1]}" | col -b | grep "^([^[:space:]]|   [][^[:space:]])" | \
        FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf -1 --prompt "SECTION> "
}
