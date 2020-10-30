#!/bin/bash

declare DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${DIR}" ]]; then DIR="${PWD}"; fi
source "${DIR}/log.sh"
source "${DIR}/mutex.sh"

readonly OPTIONS="${@}"
readonly LOCKFILE_DATASTREAM_FILENAME="lsyncd_datastream.lock"
readonly LOCKFILE_DROPBOX_FILENAME="lsyncd_dropbox.lock"

echo -formated "Start lsyncd handler for source \"${@: -2:1}\""

# Write in a file the number of processes so that only the last one stop Dropbox
lock -1 "${LOCKFILE_DATASTREAM_FILENAME}" 200
gawk -i inplace '{$1=$1+1}1' "${PROJECT_LSYNCD_PROCESS_DATASTREAM_FILE}"
assert_eq "${?}" "0" "Can't write the file \"${PROJECT_LSYNCD_PROCESS_DATASTREAM_FILE}\""
unlock "${LOCKFILE_DATASTREAM_FILENAME}" 200

# Start Dropbox if not started
lock -1 "${LOCKFILE_DROPBOX_FILENAME}" 201
if [[ "$(dropbox status)" == "Dropbox isn't running!" ]]; then
	echo -formated "Start Dropbox..."
	dropbox start
	while [[ "$(dropbox status)" != "Up to date" ]]; do
		sleep 1
	done
	echo -formated "Dropbox is started."
	sleep 1
fi
unlock "${LOCKFILE_DROPBOX_FILENAME}" 201

# Synchronization with rsync command
echo -formated "Synchronization with rsync command..."
rsync ${OPTIONS}
declare -r -i rsync_status=${?}
(
	if (( ${rsync_status} == 0 )); then
		log_info "Synchronized!"
	else
		log_error "ERROR: fail to synchronize! Error code is ${rsync_status}."
	fi
	
	# Stop Dropbox if it is the last processus
	lock -1 "${LOCKFILE_DATASTREAM_FILENAME}" 200
	declare -r -i remaining_processes="$(cat ${PROJECT_LSYNCD_PROCESS_DATASTREAM_FILE})"
	assert_ge ${remaining_processes} 0 "Remaining processes is less than 0"
	if (( ${remaining_processes} == 1 )); then
		# Wait for Dropbox finish synchronization
		log_info "Wait for Dropbox finish synchronization before shutdown it..."
		while [[ "$(dropbox status)" != "Up to date" ]]; do
			sleep 1
		done

		# Stop Dropbox
		lock -1 "${LOCKFILE_DROPBOX_FILENAME}" 201
		log_info "Stop Dropbox..."
		dropbox stop
		while [[ "$(dropbox status)" != "Dropbox isn't running!" ]]; do
			sleep 1
		done
		unlock "${LOCKFILE_DROPBOX_FILENAME}" 201
		log_info "Dropbox is shutown and has status \"$(dropbox status)\"."
	else
		log_info "It remains $((${remaining_processes}-1)) processes, Dropbox will not be stopped."
	fi
	
	# Decrement the number of processes
	gawk -i inplace '{$1=$1-1}1' "${PROJECT_LSYNCD_PROCESS_DATASTREAM_FILE}"
	assert_eq "${?}" "0" "Can't write the file \"${PROJECT_LSYNCD_PROCESS_DATASTREAM_FILE}\""
	unlock "${LOCKFILE_DATASTREAM_FILENAME}" 200

	log_info "End of lsyncd handler for source \"${@: -2:1}\"."
) 1>/dev/null 2>&1 </dev/null

exit ${rsync_status}
