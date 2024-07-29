
fpath=(/home/xyassraist/.config/lf/zsh $fpath)

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# zsh exclusive
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/zsh-history-substring-search.zsh
source ~/.config/zsh/you-should-use.plugin.zsh
source ~/.config/zsh/fzf-tab/fzf-tab.plugin.zsh

bindkey "^H" backward-delete-char
bindkey "^?" backward-delete-char
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# end of zsh exclusive 

EDITOR=nvim

# path
export PATH=$PATH:~/bin
export PATH=$PATH:~/go/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:~/.bun/bin
export PATH=$PATH:~/.local/bin

# other variable exports
export WWW_HOME="www.duckduckgo.com"

# export FZF_DEFAULT_OPTS='--bind "ctrl-y:execute-silent(printf {} | cut -f 2- | wl-copy --trim-newline)"'
export FZF_DEFAULT_OPTS="
	--bind 'ctrl-e:become(echo {+} | xargs -o $EDITOR)'
	--bind 'ctrl-o:become(xdg-open {})'
	--bind 'ctrl-l:become(readlink -f {} | xclip -selection clipboard && echo item\ copied\ to\ clipboard)'	
	--bind 'ctrl-y:execute(readlink -f {} | xclip -selection clipboard && echo item\ copied\ to\ clipboard)'	
	--bind '?:toggle-preview'
"
# loading nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# init
eval "$(fzf --zsh)"
eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/zsh.toml)"
eval "$(zoxide init --cmd cd bash)"

# aliases
alias v=vim
alias nv=nvim
alias yt-dlp=yt-dlp_linux
alias ls=lsd
alias lsa="lsd -l -a"
alias lst="lsd -ltr"
alias lss="lsd -lSr"
alias zlf="~/zlf.sh"
alias q=exit
alias zrc="vim ~/.zshrc"
alias termmode="sudo systemctl isolate multi-user.target"
alias graphmode="sudo systemctl isolate graphical.target"
 
# alias f=fzf

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no

# functions

ytdlp() {
    yt-dlp $1 -f bestvideo[height=480][vcodec!=vp9]+bestaudio/best --config-locations ~/Personal/Zill_Laiss/coding/yt-config.txt
}

list() {
    case "$1" in
        size)
            lsd -arlS ;;
        time)
            lsd -arlt ;;
        *)
            lsd -al ;;
    esac
}

lfcd () {
    # `command` is needed in case `lfcd` is aliased to `lf`
    cd "$(command lf -print-last-dir "$@")"
}

search () {
  IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# this is just a function which extend fzf bindings so it wouldn't conflict with apps that use original bindings
f () {
	fzf --bind 'enter:become(readlink -f {} | xclip -selection clipboard && echo item\ copied\ to\ clipboard)'	
}

function stop() {
	sleep $2 && kill $(pgrep $1)
}

# For Termux
# export DISPLAY=":1"

# install RealVNC from appstore first
# follow the tutorial here https://wiki.termux.com/wiki/Graphical_Environment
alias vnc="vncserver -localhost"

