#                 ██
#                ░██
#  ██████  ██████░██
# ░░░░██  ██░░░░ ░██████
#    ██  ░░█████ ░██░░░██
#   ██    ░░░░░██░██  ░██
#  ██████ ██████ ░██  ░██
# ░░░░░░ ░░░░░░  ░░   ░░
#
# aliases

# overrides
alias mkdir="mkdir -p"
alias cp="cp -r"
alias sctl="sudo systemctl"
alias uctl="systemctl --user"
alias su="sudo su"

# overrides colors
alias grep="grep --color=auto"
alias pacman="pacman --color=auto"
alias yay="yay --color=auto"
alias ls="ls --color=auto"

# yt-dlp
alias ytmp3="yt-dlp --extract-audio --audio-format mp3 --audio-quality 0"
alias yt480="yt-dlp -f 'bestvideo*+bestaudio/b' --remux-video mp4 -S 'height:480'"
alias yt720="yt-dlp -f 'bestvideo*+bestaudio/b' --remux-video mp4 -S 'height:720'"
alias yt1080="yt-dlp -f 'bestvideo*+bestaudio/best' --remux-video mp4 -S 'height:1080'"
alias yt1440="yt-dlp -f 'bestvideo*+bestaudio/best' --remux-video mp4 -S 'height:1440'"
alias ytmax="yt-dlp -f 'bestvideo*+bestaudio/best' --remux-video mp4"

# custom
alias DID_I_FUCKING_STUTTER='echo "Aplogies, milord; right away." ; sudo $(fc -ln -1)'
alias vpn-usu-staff="sudo openconnect sslvpn.usu.edu/staff"
alias usu-vpn-staff="sudo openconnect sslvpn.usu.edu/staff"
alias remove-orphans="pacman -Qtdq | sudo pacman -Rns -"
alias md-to-pdf="pandoc -o output.pdf"
# alias copy="xclip -selection c" # used by piping into `copy` e.g. `cat README.md | copy` ONLY WORKS ON XORG
alias copy="wl-copy" # requires wl-clipboard package, piping into it copies ONLY WORKS ON WAYLAND
alias update-mirrors="sudo reflector --country US --protocol http,https --age 12 --sort rate -n 5 --save /etc/pacman.d/mirrorlist --verbose"
alias phone="scrcpy"
alias phonea="sndcpy"
alias rsync="rsync --verbose"
alias unfucklock="sudo loginctl unlock-sessions" # kde screenlocker can eat a bag of dicks
