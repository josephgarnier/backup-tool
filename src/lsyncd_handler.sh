#!/bin/bash

declare DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
source "$DIR/log.sh"

readonly OPTIONS="${@}"

log_info "Start lsyncd handler for source \""${@: -2:1}"\""

# Start Dropbox if not started
if [[ "$(dropbox status)" != "Up to date" ]]; then
	log_info "Start Dropbox..."
	dropbox start
	while [[ "$(dropbox status)" != "Up to date" ]]; do
		sleep 1
	done
	log_info "Dropbox is started."
	sleep 1
fi

# Synchronization with rsync command
log_info "Synchronization with rsync command..."
rsync ${OPTIONS}
status="${?}"
(
	if [[ "${status}" -eq 0 ]]; then
		# Wait for Dropbox finish synchronization
		log_info "Wait for Dropbox finish synchronization before shutdown it..."
		while [[ "$(dropbox status)" != "Up to date" ]]; do
			sleep 1
		done

		# Stop Dropbox
		log_info "Stop Dropbox..."
		dropbox stop
		while [[ "$(dropbox status)" != "Dropbox isn't running!" ]]; do
			sleep 1
		done
		log_info "Dropbox is shutown and has status $(dropbox status)."
		
		log_info "Synchronized!"
	else
		log_info "Fail to synchronize! Error code is "${status}"."
	fi
) 1>/dev/null 2>&1 </dev/null

exit "${status}"
