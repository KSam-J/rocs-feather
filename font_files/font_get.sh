#!/bin/bash

LOCAL_FONTS="${HOME}/.local/share/fonts/"

curl -L -O https://github.com/microsoft/cascadia-code/releases/download/v2009.22/CascadiaCode-2009.22.zip

unzip CascadiaCode-2009.22.zip -d CascadiaCode-2009_22

# Check font directory and mv ttf
if [[ ! -d "${LOCAL_FONTS}" ]]; then
	mkdir ${LOCAL_FONTS}
fi

if [[  -e "CascadiaCode.ttf" ]]; then
        echo "CascadiaCode.ttf already present"
	exit 1
fi

cp CascadiaCode-2009_22/ttf/CascadiaCode.ttf ${LOCAL_FONTS}

# Clear and regenerate the font cache
fc-cache -f -v

# Verify installation
fc-list | grep -q Cascadia && echo "CascadiaCode installed."
