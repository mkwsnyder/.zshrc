#                 ██
#                ░██
#  ██████  ██████░██      ██████  █████
# ░░░░██  ██░░░░ ░██████ ░░██░░█ ██░░░██
#    ██  ░░█████ ░██░░░██ ░██ ░ ░██  ░░
#   ██    ░░░░░██░██  ░██ ░██   ░██   ██
#  ██████ ██████ ░██  ░██░███   ░░█████
# ░░░░░░ ░░░░░░  ░░   ░░ ░░░     ░░░░░
#

# load configs
source /home/mark/gitstatus/gitstatus.plugin.zsh # https://github.com/romkatv/gitstatus
for config (~/.zsh/*.zsh) source $config

# https://github.com/zsh-users/zsh-autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# https://github.com/ajeetdsouza/zoxide
# also should install `fzf` for it
eval "$(zoxide init zsh)"
