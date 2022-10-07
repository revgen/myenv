if [ ! -f "${HOME}/.selected_editor" ] && [ -n "$(ls /usr/bin/select-editor 2>/dev/null)" ]; then
  /usr/bin/select-editor
fi