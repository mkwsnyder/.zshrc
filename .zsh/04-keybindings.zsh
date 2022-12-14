#                 ██
#                ░██
#  ██████  ██████░██
# ░░░░██  ██░░░░ ░██████
#    ██  ░░█████ ░██░░░██
#   ██    ░░░░░██░██  ░██
#  ██████ ██████ ░██  ░██
# ░░░░░░ ░░░░░░  ░░   ░░
#
# keybindings

# typeset -A key
#
# key[Home]=${terminfo[khome]}
# key[End]=${terminfo[kend]}
# key[Insert]=${terminfo[kich1]}
# key[Delete]=${terminfo[kdch1]}
# key[Up]=${terminfo[kcuu1]}
# key[Down]=${terminfo[kcud1]}
# key[Left]=${terminfo[kcub1]}
# key[Right]=${terminfo[kcuf1]}
# key[PageUp]=${terminfo[kpp]}
# key[PageDown]=${terminfo[knp]}
#
# [[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
# [[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
# [[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
# [[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
# [[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
# [[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
# [[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
# [[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
# [[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
# [[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history
#

bindkey '^r' history-incremental-search-backward
# bindkey '^R' history-incremental-pattern-search-backward
#
# if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
#       function zle-line-init () {
#               printf '%s' "${terminfo[smkx]}"
#       }
#       function zle-line-finish () {
#               printf '%s' "${terminfo[rmkx]}"
#       }
#       zle -N zle-line-init
#       zle -N zle-line-finish
# fi

# excuse me but why the fuck are these not the default
bindkey  "^[[H"   beginning-of-line # home
bindkey  "^[[F"   end-of-line # end
bindkey  "^[[3~"  delete-char # delete

bindkey "^[[1;5C" forward-word # ctrl + right
bindkey "^[[1;5D" backward-word # ctrl + left

bindkey "^H"      backward-kill-word # ctrl + backspace
bindkey "5~"      kill-word # ctrl + delete
