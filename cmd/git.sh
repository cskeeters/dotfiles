git_select_modified() {
    git ls-files -m | fzf --height="90%" --preview 'git diff --color=always {}' --preview-window='top,50%' --prompt "DISCARD> "
}

git_select_staged() {
    git diff --name-only --staged | fzf --height="90%" --preview 'git diff --staged --color=always {}' --preview-window='top,50%' --prompt "STAGED> "
}

git_tags() {
    git tag -l | fzf --height="90%" --preview 'git log --color=always --graph --oneline -3 {}' --preview-window='top,10%' --prompt "TAG> "
}

git_repo_name() {
    basename "$(git rev-parse --show-toplevel)"
}

git_branches() {
    git branch | cut -c 3-99 | FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf --prompt "BRANCH> "
}

git_other_branches() {
    git branch | cut -c 3-99 | grep -v master | grep -v main | FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf --prompt "BRANCH> "
}

git_remote() {
    git remote | FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf -1 --height 10 --prompt "REMOTE> "
}

git_remote_branches() {
    git branch -r | awk '{print $1}' | FZF_DEFAULT_OPTS="$FZF_NO_PREVIEW_OPTS" fzf --prompt "REMOTE BRANCH> "
}
