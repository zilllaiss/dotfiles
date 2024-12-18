# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# custom configs start here
source ~/.zl_profile

if command -v fzf &> /dev/null; then
	eval "$(fzf --bash)"
fi

if command -v oh-my-posh &> /dev/null; then
	eval "$(oh-my-posh init bash --config ~/.config/oh-my-posh/zsh.toml)"
fi

if command -v zoxide &> /dev/null; then
	eval "$(zoxide init --cmd cd bash)"
fi
