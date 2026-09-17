# CONFIG.NU

# The first file loaded is env.nu, which was historically used to override environment variables. However, the current "best-practice" recommendation is to set all environment variables (and other configuration) using config.nu and the autoload directories

$env.config.buffer_editor = "/home/samkel/.local/bin/nvim"

# APPEND to path
$env.path ++= ["~/.local/bin"]
$env.path ++= ["/home/samkel/.nvm/versions/node/v20.17.0/bin"]

# Helper functions -----------------------------------------
# Check if some command available in current shell
def 'is-installed' [ app: string ] {
  ((which $app | length) > 0)
}

# Aliases --------------------------------------------------
alias l = if (is-installed lsd) {lsd --classify --group-directories-first} else {ls}
alias ll = if (is-installed lsd) {lsd --long --all} else {ls --all --long}
alias la = if (is-installed lsd) {lsd --classify --group-directories-first --all} else {ls --all}

alias dlog = /home/samkel/Automation/daylog/dlog.py
alias tt = tree -L 2 
alias ttt = tree -L 3 

# executables
alias wezterm = flatpak run org.wezfurlong.wezterm
alias giopen = /home/samkel/Automation/pandoras-box/giopen.sh

def updoot [] {
  sudo apt update
  sudo apt upgrade
}

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

# Greeting -------------------------------------------------
$env.config.show_banner = false
# Login-banner style greeting: terminal, shell, multiplexer, and the time.
source ~/Repos/rocs-feather/scripts/greeting.nu
if $nu.is-interactive { feather-greeting }

