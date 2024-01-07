# Updating from github

Start on the local branch

    git switch local

Pull and rebase local onto latest master

    git pull --rebase origin/master

Push origin/master to server/master so changes will get sent to Tyndall

    git push server origin/master:master

Push local branch to server, since it's always rebased, we'll always need to force

    git push --force server local


# Updating from server

This procedure should be used at Tyndall after repos has been updated with the lastest local branch from the TSSC.

Start on the local branch

    git switch local

Pull all objects for server/local

    git fetch server local

Just reset hard to use what's from server

    git reset --hard server/local
