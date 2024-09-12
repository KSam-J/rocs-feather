# fzf v0.55.0 download url
# https://github.com/junegunn/fzf/releases/download/v0.55.0/fzf-0.55.0-linux_amd64.tar.gz

# fzf v0.55.0 download url
# https://github.com/junegunn/fzf/releases/latest


version=$(curl -s -o /dev/null -w "%{redirect_url}" https://github.com/junegunn/fzf/releases/latest | grep -oE "[^/]+$")
echo $version

