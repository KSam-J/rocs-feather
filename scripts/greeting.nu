# GREETING.NU
#
# A login-banner style greeting for interactive nushell sessions.
# Reports the terminal emulator, the active shell, any multiplexer,
# and a somewhat theatrical rendering of the current time.
#
# Usage (from config.nu):
#   source ~/Repos/rocs-feather/scripts/greeting.nu
#   feather-greeting

# --- detection helpers ----------------------------------------------------

def detect-terminal []: nothing -> string {
    let e = $env

    if ($e | get -o WEZTERM_PANE | is-not-empty) { return "WezTerm" }
    if ($e | get -o ALACRITTY_WINDOW_ID | is-not-empty) { return "Alacritty" }
    if ($e | get -o KITTY_WINDOW_ID | is-not-empty) { return "kitty" }
    if ($e | get -o GHOSTTY_RESOURCES_DIR | is-not-empty) { return "Ghostty" }
    if ($e | get -o KONSOLE_VERSION | is-not-empty) { return "Konsole" }
    if ($e | get -o VSCODE_INJECTION | is-not-empty) { return "VS Code" }
    if ($e | get -o WT_SESSION | is-not-empty) { return "Windows Terminal" }
    if ($e | get -o VTE_VERSION | is-not-empty) { return "VTE (GNOME/XFCE)" }

    let prog = ($e | get -o TERM_PROGRAM | default "")
    if ($prog | is-not-empty) { return $prog }

    let term = ($e | get -o TERM | default "")
    if ($term == "linux") { return "Linux console" }
    if ($term | is-not-empty) { return $"unknown \(($term)\)" }

    "unknown"
}

def detect-multiplexer []: nothing -> string {
    let e = $env

    if ($e | get -o ZELLIJ | is-not-empty) {
        let s = ($e | get -o ZELLIJ_SESSION_NAME | default "session")
        return $"zellij  ·  ($s)"
    }
    if ($e | get -o TMUX | is-not-empty) {
        let s = (do -i { tmux display-message -p '#S' | str trim } | default "session")
        return $"tmux  ·  ($s)"
    }
    if ($e | get -o STY | is-not-empty) {
        return $"screen  ·  ($e.STY)"
    }

    "none  ·  flying solo"
}

def detect-shell []: nothing -> string {
    $"nushell ($env.NU_VERSION? | default (version).version)"
}

# --- time flavor ----------------------------------------------------------

# Path to the time-mood string library, resolved relative to this script.
const TIMEMOODS_FILE = path self "timemoods.json"

# Pick a mood based on the hour, because 03:00 deserves acknowledgement.
# Bands and messages come from timemoods.json; a message is chosen at random.
def time-mood [hour: int]: nothing -> record<icon: string, word: string> {
    let lib = (do -i { open $TIMEMOODS_FILE })
    let fallback = {icon: "🪶", word: "Welcome back."}

    if ($lib | is-empty) { return $fallback }

    let band = ($lib.bands | where {|b| $hour >= $b.start and $hour < $b.end } | first)
    let chosen = (if ($band | is-empty) { $lib | get -o fallback } else { $band })

    if (($chosen | is-empty) or ($chosen.messages | is-empty)) { return $fallback }

    {icon: $chosen.icon, word: ($chosen.messages | shuffle | first)}
}

# A 12-hour clock face emoji, rounded to the nearest half hour.
def clock-face [now: datetime]: nothing -> string {
    let faces = [
        "🕛" "🕧" "🕐" "🕜" "🕑" "🕝" "🕒" "🕞" "🕓" "🕟" "🕔" "🕠"
        "🕕" "🕡" "🕖" "🕢" "🕗" "🕣" "🕘" "🕤" "🕙" "🕥" "🕚" "🕦"
    ]
    let h12 = (($now | format date "%I" | into int) mod 12)
    let half = (if (($now | format date "%M" | into int) >= 30) { 1 } else { 0 })
    $faces | get ((($h12 * 2) + $half) mod 24)
}

# Fraction of the day burned so far, as a little progress bar.
def day-progress [now: datetime]: nothing -> string {
    let mins = (($now | format date "%H" | into int) * 60) + ($now | format date "%M" | into int)
    let width = 24
    let filled = ([($mins * $width // 1440) $width] | math min)
    let bar = ("" | fill -c "█" -w $filled) + ("" | fill -c "░" -w ($width - $filled))
    let pct = ($mins * 100 // 1440)
    $"($bar) ($pct)% of the day elapsed"
}

def uptime-line []: nothing -> string {
    let raw = (do -i { open /proc/uptime | split row " " | first | into float })
    if ($raw | is-empty) { return "unknown" }
    let secs = ($raw | math round)
    let d = ($secs // 86400)
    let h = (($secs mod 86400) // 3600)
    let m = (($secs mod 3600) // 60)
    if $d > 0 { $"($d)d ($h)h ($m)m" } else if $h > 0 { $"($h)h ($m)m" } else { $"($m)m" }
}

# --- the greeting ---------------------------------------------------------

export def feather-greeting []: nothing -> nothing {
    let now = (date now)
    let mood = (time-mood ($now | format date "%H" | into int))
    let user = ($env.USER? | default ($env.USERNAME? | default "traveler"))
    let host = (do -i { sys host | get hostname } | default "localhost")
    let osname = (do -i { sys host | get name } | default "Linux")
    let label = 11

    print $"(ansi green_bold)╭─ 🪶  ($user)@($host)(ansi reset)"
    print $"(ansi green)│(ansi reset)  (ansi dark_gray)((clock-face $now)) ($now | format date '%A, %d %B %Y  ·  %H:%M:%S %Z')(ansi reset)"
    print $"(ansi green)│(ansi reset)  (ansi dark_gray)($mood.icon) ($mood.word)(ansi reset)"
    print $"(ansi green)│(ansi reset)"
    print $"(ansi green)│(ansi reset)  (ansi cyan)('terminal' | fill -w $label)(ansi reset) (detect-terminal)"
    print $"(ansi green)│(ansi reset)  (ansi cyan)('shell' | fill -w $label)(ansi reset) (detect-shell)"
    print $"(ansi green)│(ansi reset)  (ansi cyan)('multiplexer' | fill -w $label)(ansi reset) (detect-multiplexer)"
    print $"(ansi green)│(ansi reset)  (ansi cyan)('system' | fill -w $label)(ansi reset) ($osname)  ·  up (uptime-line)"
    print $"(ansi green)│(ansi reset)"
    print $"(ansi green)│(ansi reset)  (ansi dark_gray)(day-progress $now)(ansi reset)"
    print $"(ansi green_bold)╰────────────────────────────────────────────(ansi reset)"
}
