#                 ██
#                ░██
#  ██████  ██████░██
# ░░░░██  ██░░░░ ░██████
#    ██  ░░█████ ░██░░░██
#   ██    ░░░░░██░██  ░██
#  ██████ ██████ ░██  ░██
# ░░░░░░ ░░░░░░  ░░   ░░
#
# prompt

# allow functions in the prompt
setopt PROMPT_SUBST
autoload -Uz colors && colors

# ===== ICONS =====

# may require this font (note, you shouldn't need to change your terminal font, it should fallback for the icons)  https://github.com/romkatv/powerlevel10k#manual-font-installation
# (if the above doesn't work) may require the awesome-terminal-fonts package (https://github.com/gabrielelana/awesome-terminal-fonts) and/or a nerd font (https://www.nerdfonts.com/)
# full list of icons (don't view this file via the web browser, icons may not show up properly) https://raw.githubusercontent.com/romkatv/powerlevel10k/master/internal/icons.zsh

ICO_OS=""

ICO_VCS=""
# ICO_VCS=''
# ICO_VCS=''

# ICO_BEHIND="↓"
# ICO_BEHIND=""
# ICO_BEHIND=""
ICO_BEHIND=""
# ICO_BEHIND="▼"

# ICO_AHEAD="↑"
# ICO_AHEAD=""
ICO_AHEAD=""
# ICO_AHEAD="▲"

ICO_PUSH_BEHIND="⇠"
# ICO_PUSH_BEHIND="⇠"

ICO_PUSH_AHEAD="⇢"
# ICO_PUSH_AHEAD="⇢"

ICO_STASHED=""
# ICO_STASHED="*"

ICO_CONFLICTED="✘"
# ICO_CONFLICTED="~"

ICO_STAGED=""
# ICO_STAGED="+"

ICO_UNSTAGED=""
# ICO_UNSTAGED="!"

ICO_UNTRACKED=""
# ICO_UNTRACKED="?"

# ICO_DIRTY="*"
# ICO_DIRTY="↯"
ICO_DIRTY="⚡"

ICO_DIVERGED="↕"
# ICO_DIVERGED=""
# ICO_DIVERGED="נּ"

# ===== END ICONS =====

# ===== COLORS =====

# color reference: https://www.ditig.com/256-colors-cheat-sheet

COLOR_TEXT_BG_DARK="15" # white
COLOR_TEXT_BG_LIGHT="0" # black

# NOTE: root colors will only work if .zshrc and the files in .zsh are also in /root/ (you can symlink them)
if [[ "$EUID" -ne "0" ]]
then  # if user is not root
  COLOR_USER="36" # teal 36 | blue 27
  COLOR_HOST="43" # teal 43 | blue 33
  COLOR_PATH="15" # white
  COLOR_GIT="30" # teal 30 | blue 25
else # root
  COLOR_USER="88"
  COLOR_HOST="124"
  COLOR_PATH="15" # white
  COLOR_GIT="52"
fi

# ===== END COLORS =====

# ===== BASIC GIT PROMPT =====

# basic git prompt, doesn't require additional plugins
# can be used by adding `$(GIT_PROMPT)` to your prompt
# pulled form here (has been modified): https://github.com/xero/dotfiles/blob/master/zsh/.zsh/05-prompt.zsh
GIT_PROMPT() {
  test=$(git rev-parse --is-inside-work-tree 2> /dev/null)
  if [ ! "$test" ]
  then
      echo "$reset_color%F{white}"
      return
  fi
  ref=$(git name-rev --name-only HEAD | sed 's!remotes/!!;s!undefined!merging!' 2> /dev/null)
  ref2=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  dirty="" && [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && dirty=$ICO_DIRTY
  stat=$(git status | sed -n 2p)
  case "$stat" in
    *ahead*)
      stat=$ICO_AHEAD
    ;;
    *behind*)
      stat=$ICO_BEHIND
    ;;
    *diverged*)
      stat=$ICO_DIVERGED
    ;;
    *)
      stat=""
    ;;
  esac
  echo "%K{${COLOR_GIT}}%F{white} ${ICO_VCS} ${ref2} ${dirty}${stat} $reset_color%F{${COLOR_GIT}}"
}

# ===== END BASIC GIT PROMPT =====

# ===== FULL GIT PROMPT =====

# USAGE
# clone the gitstatus repo: https://github.com/romkatv/gitstatus
# source the plugin like so: `source ~/gitstatus/gitstatus.plugin.zsh`
# can be used by adding `${GITSTATUS_PROMPT}` to your prompt

# NOTE: if you are not going to use the gitstatus prompt, comment the function out
# for more info, see https://github.com/romkatv/gitstatus

# TODO: make gitstatus prompt faster as described here (asynchronously vs synchronously): https://github.com/romkatv/gitstatus#using-from-zsh (scroll to end of the section)
# function pulled from the example prompt (has been modified): https://github.com/romkatv/gitstatus/blob/master/gitstatus.prompt.zsh
function gitstatus_prompt_update() {
  emulate -L zsh
  typeset -g  GITSTATUS_PROMPT=''
  typeset -gi GITSTATUS_PROMPT_LEN=0

  # what's shown if not in a git repo
  GITSTATUS_PROMPT="$reset_color%${COLOR_PATH}F"

  # Call gitstatus_query synchronously. Note that gitstatus_query can also be called
  # asynchronously; see documentation in gitstatus.plugin.zsh.
  gitstatus_query 'MY'                  || return 1  # error
  [[ $VCS_STATUS_RESULT == 'ok-sync' ]] || return 0  # not a git repo

  local      clean='%15F'   # ~~green~~ white foreground | green: 76
  local   modified='%178F'  # yellow foreground
  local  untracked='%39F'   # blue foreground
  local conflicted='%196F'  # red foreground

  local p="%${COLOR_PATH}F%${COLOR_GIT}K%f ${ICO_VCS} "

  local where  # branch name, tag or commit
  if [[ -n $VCS_STATUS_LOCAL_BRANCH ]]; then
    where=$VCS_STATUS_LOCAL_BRANCH
  elif [[ -n $VCS_STATUS_TAG ]]; then
    p+='%f#'
    where=$VCS_STATUS_TAG
  else
    p+='%f@'
    where=${VCS_STATUS_COMMIT[1,8]}
  fi

  (( $#where > 32 )) && where[13,-13]="…"  # truncate long branch names and tags
  p+="${clean}${where//\%/%%}"             # escape %

  # ⇣42 if behind the remote.
  (( VCS_STATUS_COMMITS_BEHIND )) && p+=" ${clean}${ICO_BEHIND}${VCS_STATUS_COMMITS_BEHIND}"
  # ⇡42 if ahead of the remote; no leading space if also behind the remote: ⇣42⇡42.
#   (( VCS_STATUS_COMMITS_AHEAD && !VCS_STATUS_COMMITS_BEHIND )) && p+=" "
  (( VCS_STATUS_COMMITS_AHEAD  )) && p+=" ${clean}${ICO_AHEAD}${VCS_STATUS_COMMITS_AHEAD}"
  # ⇠42 if behind the push remote.
  (( VCS_STATUS_PUSH_COMMITS_BEHIND )) && p+=" ${clean}${ICO_PUSH_BEHIND}${VCS_STATUS_PUSH_COMMITS_BEHIND}"
  (( VCS_STATUS_PUSH_COMMITS_AHEAD && !VCS_STATUS_PUSH_COMMITS_BEHIND )) && p+=" "
  # ⇢42 if ahead of the push remote; no leading space if also behind: ⇠42⇢42.
  (( VCS_STATUS_PUSH_COMMITS_AHEAD  )) && p+=" ${clean}${ICO_PUSH_AHEAD}${VCS_STATUS_PUSH_COMMITS_AHEAD}"
  # *42 if have stashes.
  (( VCS_STATUS_STASHES        )) && p+=" ${clean}${ICO_STASHED}${VCS_STATUS_STASHES}"
  # 'merge' if the repo is in an unusual state.
  [[ -n $VCS_STATUS_ACTION     ]] && p+="  ${conflicted}${VCS_STATUS_ACTION}"
  # ~42 if have merge conflicts.
  (( VCS_STATUS_NUM_CONFLICTED )) && p+=" ${conflicted}${ICO_CONFLICTED}${VCS_STATUS_NUM_CONFLICTED}"
  # +42 if have staged changes.
  (( VCS_STATUS_NUM_STAGED     )) && p+=" ${modified}${ICO_STAGED}${VCS_STATUS_NUM_STAGED}"
  # !42 if have unstaged changes.
  (( VCS_STATUS_NUM_UNSTAGED   )) && p+=" ${modified}${ICO_UNSTAGED}${VCS_STATUS_NUM_UNSTAGED}"
  # ?42 if have untracked files. It's really a question mark, your font isn't broken.
  (( VCS_STATUS_NUM_UNTRACKED  )) && p+=" ${untracked}${ICO_UNTRACKED}${VCS_STATUS_NUM_UNTRACKED}"

  p+=" $reset_color%F{${COLOR_GIT}}"

  GITSTATUS_PROMPT="${p}%f"

  # The length of GITSTATUS_PROMPT after removing %f and %F.
  GITSTATUS_PROMPT_LEN="${(m)#${${GITSTATUS_PROMPT//\%\%/x}//\%(f|<->F)}}"
}

# Start gitstatusd instance with name "MY". The same name is passed to
# gitstatus_query in gitstatus_prompt_update. The flags with -1 as values
# enable staged, unstaged, conflicted and untracked counters.
gitstatus_stop 'MY' && gitstatus_start -s -1 -u -1 -c -1 -d -1 'MY'

# On every prompt, fetch git status and set GITSTATUS_PROMPT.
autoload -Uz add-zsh-hook
add-zsh-hook precmd gitstatus_prompt_update

# Enable/disable the right prompt options.
setopt no_prompt_bang prompt_percent prompt_subst

# ===== END FULL GIT PROMPT =====

# ===== PROMPT =====

# visual effects reference: https://man.archlinux.org/man/zshmisc.1#Visual_effects

PROMPT='%${COLOR_USER}K %f%n %${COLOR_USER}F%${COLOR_HOST}K %f%m %${COLOR_HOST}F%${COLOR_PATH}K %${COLOR_TEXT_BG_LIGHT}F%~ ${GITSTATUS_PROMPT}$reset_color%f%k'
PROMPT+=$'\n%${COLOR_USER}F██▓▒░%f '

# old prompt
# PROMPT='%K{36} %n %F{36}%K{43} %f%m %F{43}%K{white} %F{black}%~ $(GIT_PROMPT)$reset_color%f%k
# %F{36}██▓▒░%f '
