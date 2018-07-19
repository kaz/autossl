#!/usr/bin/env bash

DB="/etc/pdns/database"

deploy_challenge() {
	local DOMAIN="${1}" TOKEN_FILENAME="${2}" TOKEN_VALUE="${3}"
	pdnsutil create-zone $DOMAIN
	pdnsutil add-record $DOMAIN _acme-challenge TXT 60 "\"${TOKEN_VALUE}\""
}
clean_challenge() {
	local DOMAIN="${1}" TOKEN_FILENAME="${2}" TOKEN_VALUE="${3}"
	sqlite3 $DB "DELETE FROM records WHERE content = '\"${TOKEN_VALUE}\"';"
}
startup_hook() {
	pkill -TERM pdns_server
	rm -f $DB
	curl https://raw.githubusercontent.com/PowerDNS/pdns/master/modules/gsqlite3backend/schema.sqlite3.sql | sqlite3 $DB
	pdns_server
}
exit_hook() {
	pkill -TERM pdns_server
	rm -f $DB
}

HANDLER="$1"; shift
if [[ "${HANDLER}" =~ ^(deploy_challenge|clean_challenge|startup_hook|exit_hook)$ ]]; then
	"$HANDLER" "$@"
fi
