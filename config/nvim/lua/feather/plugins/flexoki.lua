return {
    'kepano/flexoki-neovim',
    name = 'flexoki',
    enabled = true,
    lazy = false,
    priority = 1000,
    -- Colorscheme selection is handled by floppy-trigger via the manifest
    -- (~/.config/theme-current). No colorscheme is applied here; the
    -- starfield-light plugin's config() reads the manifest and applies it.
}
