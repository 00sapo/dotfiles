#!/bin/bash
notify_folders=("#imap/GSSI/INBOX" "#imap/Zoho/INBOX" "#imap/Outlook/Inbox" "#mh/Mailbox/inbox")

get_unread() {
  tot_unread=0
  for folder in "${notify_folders[@]}"; do
    unread=$(claws-mail --status "$folder" | awk '{print $2}')
    tot_unread=$((tot_unread + unread))
  done
  echo $tot_unread
}

old_unread=0
while true; do
  new_unread=$(get_unread)
  tot_unread=$((new_unread - old_unread))
  if [[ $tot_unread -gt 0 ]]; then
    notify-send -a "Claws Mail" -h "string:desktop-entry:claws-mail" "$tot_unread unread emails."
  fi
  old_unread=$new_unread
  sleep 5
done
