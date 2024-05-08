#!/bin/bash

# Check that the font family doesn't already exist
fc-list | grep -q Caskaydia && { echo "font Caskaydia already installed"; exit 0; }

LOCAL_FONTS="${HOME}/.local/share/fonts/"

curl -L -O https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/CascadiaCode.zip

unzip CascadiaCode.zip -d CascadiaCode

# Check font directory and mv ttf
if [[ ! -d "${LOCAL_FONTS}" ]]; then
	mkdir ${LOCAL_FONTS}
fi

# OUTDATED, replace?
# if [[  -e "CascadiaCode.ttf" ]]; then
#         echo "CascadiaCode.ttf already present"
# 	exit 1
# fi
 
mv CascadiaCode ${LOCAL_FONTS}

# Clear and regenerate the font cache
fc-cache -f -v

# Verify installation
fc-list | grep -q Caskaydia && echo "CaskaydiaCode installed."

