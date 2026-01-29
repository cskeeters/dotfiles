## RedHat Based
if command -v rpm >/dev/null 2>&1; then
    link cmd/rpm.snippets                   .config/cmd
    link cmd/rpm.sh                         .config/cmd
    link cmd/rpmbuild.snippets              .config/cmd
fi

if command -v dnf >/dev/null 2>&1; then
    link cmd/dnf.snippets                   .config/cmd
fi

## Debian Based
if command -v apt >/dev/null 2>&1; then
    link cmd/apt.snippets                   .config/cmd
    link cmd/apt.sh                         .config/cmd
fi

link cmd/fail2ban.snippets                  .config/cmd
link cmd/iptables.snippets                  .config/cmd
link cmd/tshark.snippets                    .config/cmd
link cmd/wireguard-server.snippets          .config/cmd
