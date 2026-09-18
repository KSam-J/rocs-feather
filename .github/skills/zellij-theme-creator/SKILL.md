# Zellij Theme Creator Skill

Use this skill when creating or updating `config/zellij/themes/*.kdl` themes in this repo.

## Goal

Generate a **contrast-safe zellij theme** that preserves expected pane/background behavior and avoids default neon-green fallbacks.

## Inputs

1. Theme name (for `themes { <name> { ... } }`)
2. Palette values (at least: `sf_light`, `sf_dark`, `sf_mid`, plus accents)
3. Desired behavior for:
   - pane background
   - toolbar/status text and background
   - ribbon text and background

## Critical rules (learned from this repo/session)

1. Prefer **named-style format** (`text_unselected`, `ribbon_selected`, etc.), not the old 11-color palette format.
2. In zellij 0.44.x, pane background is effectively coupled to:
   - `text_unselected.background`
3. If pane background must stay light (`#ececec`), keep:
   - `text_unselected.background "#ececec"`
4. Neon-green appears when zellij falls back to defaults. Prevent this by explicitly defining:
   - `ribbon_*`, `frame_*`, `exit_code_*`, `table_*`, and `list_*`.
5. If toolbar/ribbon text should be white, use:
   - `base "#ececec"` in `text_*` and `ribbon_*`,
   - and ensure corresponding backgrounds are dark enough for contrast.
6. For this Starfield Light setup, the tmux status grey is:
   - `#757575` (`sf_mid`), useful for ribbon/tool chrome backgrounds.

## Output requirements

Produce or update `config/zellij/themes/<theme>.kdl` with:

1. A complete `themes { <theme> { ... } }` block in named-style format.
2. A short header comment listing palette and coupling note.
3. No reliance on implicit/default style values for visible UI components.

## Reference template (named-style)

```kdl
themes {
    THEME_NAME {
        text_unselected {
            base "#ececec"
            background "#ececec" // pane background coupling
            emphasis_0 "#e06236"
            emphasis_1 "#d7a64b"
            emphasis_2 "#304c7a"
            emphasis_3 "#6522a5"
        }
        text_selected {
            base "#ececec"
            background "#757575"
            emphasis_0 "#e06236"
            emphasis_1 "#d7a64b"
            emphasis_2 "#304c7a"
            emphasis_3 "#6522a5"
        }
        ribbon_unselected {
            base "#ececec"
            background "#757575"
            emphasis_0 "#c72138"
            emphasis_1 "#d7a64b"
            emphasis_2 "#304c7a"
            emphasis_3 "#6522a5"
        }
        ribbon_selected {
            base "#ececec"
            background "#304c7a"
            emphasis_0 "#c72138"
            emphasis_1 "#e06236"
            emphasis_2 "#d7a64b"
            emphasis_3 "#ececec"
        }
        table_title {
            base "#304c7a"
            background "#ececec"
            emphasis_0 "#e06236"
            emphasis_1 "#d7a64b"
            emphasis_2 "#304c7a"
            emphasis_3 "#6522a5"
        }
        table_cell_unselected {
            base "#1a1a1a"
            background "#ececec"
            emphasis_0 "#e06236"
            emphasis_1 "#d7a64b"
            emphasis_2 "#304c7a"
            emphasis_3 "#6522a5"
        }
        table_cell_selected {
            base "#ececec"
            background "#757575"
            emphasis_0 "#e06236"
            emphasis_1 "#d7a64b"
            emphasis_2 "#304c7a"
            emphasis_3 "#6522a5"
        }
        list_unselected {
            base "#1a1a1a"
            background "#ececec"
            emphasis_0 "#e06236"
            emphasis_1 "#d7a64b"
            emphasis_2 "#304c7a"
            emphasis_3 "#6522a5"
        }
        list_selected {
            base "#ececec"
            background "#757575"
            emphasis_0 "#e06236"
            emphasis_1 "#d7a64b"
            emphasis_2 "#304c7a"
            emphasis_3 "#6522a5"
        }
        frame_selected {
            base "#304c7a"
            emphasis_0 "#e06236"
            emphasis_1 "#d7a64b"
            emphasis_2 "#6522a5"
            emphasis_3 "#c72138"
        }
        frame_highlight {
            base "#e06236"
            emphasis_0 "#6522a5"
            emphasis_1 "#304c7a"
            emphasis_2 "#e06236"
            emphasis_3 "#e06236"
        }
        exit_code_success {
            base "#304c7a"
            emphasis_0 "#d7a64b"
            emphasis_1 "#1a1a1a"
            emphasis_2 "#6522a5"
            emphasis_3 "#304c7a"
        }
        exit_code_error {
            base "#c72138"
            emphasis_0 "#d7a64b"
            emphasis_1 "#e06236"
            emphasis_2 "#6522a5"
            emphasis_3 "#304c7a"
        }
    }
}
```

## Deployment notes for this repo

1. Theme file location: `config/zellij/themes/`
2. Active config: `config/zellij/config.kdl` (`theme "starfield-light"` style)
3. Symlink deployment: `config/set_sym_links.sh`
4. Running sessions may need restart/new session to fully reflect color changes.
