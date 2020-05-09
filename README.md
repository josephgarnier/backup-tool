# backup-tool

A tool to backup my personal files. It's a **personnal project**, not documentation will be written.

## Installation

To use this project, install it with the `install.sh` script or follow the steps below.

1. Copy all directories and files in `/opt/backup_tool`.

2. To install as service, copy the file `/src/backup_tool.service` into `/home/joseph/.config/systemd/user`.

3. Enable the service with the command `systemctl --user enable backup_tool.service` and check that it is activated by writing the command `systemctl --user is-enabled backup_tool.service`, then `systemctl --user status backup_tool.service`.
