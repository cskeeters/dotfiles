#!/bin/bash

# net.restic.plist calls restic_backup, which is located in ~/bin
link restic-arya/net.restic.plist      Library/LaunchAgents
link restic-arya/restic.yaml           .config
