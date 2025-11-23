if command -v rpm >/dev/null 2>&1 then
    link cmd/rpm.snippets                       .config/cmd
    link cmd/rpmbuild.snippets                  .config/cmd
fi

if command -v dnf >/dev/null 2>&1 then
    link cmd/dnf.snippets                       .config/cmd
fi
