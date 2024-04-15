#!/usr/bin/env bash
filter=("tag:unread" "and" "not" "tag:killed")

if allsync enabled 2>/dev/null; then
	sync="󰑤"
else
	sync=""
fi

part=()
for mail in email gmail elektroline fel; do
	counts="$(notmuch count -- "${filter[@]}" and "tag:$mail")"
	[ "$counts" = "0" ] || \
		part+=("$mail:$counts")
done

echo "$sync" "${part[@]}"
echo
echo "#email"
