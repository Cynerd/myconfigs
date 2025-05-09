import dodo

dodo.settings.smtp_accounts = ["email", "gmail", "fel"]
dodo.settings.email_address = {
    "email": "Karel Kočí <cynerd@email.cz>",
    "gmail": "Karel Kočí <citrisin@gmail.com>",
    "fel": "Karel Kočí <kocikare@fel.cvut.cz>",
}
dodo.settings.sent_dir = {
    "email": "~/.mail/email/sent/",
    "gmail": "~/.mail/gmail/Drafts/",
    "fel": "~/.mail/fel/Sent/",
}
dodo.settings.gnupg_keyid = "2B1F70F95F1B48DA2265A7FAA6BC8B8CEB31659B"

dodo.settings.theme = dodo.themes.nord
dodo.settings.wrap_message = False
dodo.settings.editor_command = "alacritty -e nvim '{file}'"
dodo.settings.file_browser_command = "alacritty -e mc '{dir}'"
dodo.settings.file_picker_command = "alacritty -e ranger --choosefiles='{tempfile}'"
dodo.settings.sync_mail_interval = -1
dodo.settings.default_thread_list_mode = "thread"
dodo.settings.search_font_size = 9
dodo.settings.tag_font_size = 9
dodo.settings.message_font_size = 9
dodo.settings.tag_icons = {
    "inbox": "📥",
    "unread": "🆕",
    "attachment": "🖇️",
    "sent": ">",
    "replied": "",
    "flagged": "⭐",
    "marked": "",
    "signed": "",
}

dodo.settings.default_to_html = False
dodo.settings.html_block_remote_requests = False
dodo.settings.html_confirm_open_links = False
dodo.util.html2html = dodo.util.clean_html2html

del dodo.keymap.global_keymap["`"]
del dodo.keymap.search_keymap["a"]
dodo.keymap.search_keymap["J"] = ('down 20', lambda p: [p.next_thread() for i in range(20)])
dodo.keymap.search_keymap["K"] = ('up 20', lambda p: [p.previous_thread() for i in range(20)])
