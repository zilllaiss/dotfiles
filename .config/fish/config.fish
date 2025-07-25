set -g fish_key_bindings fish_vi_key_bindings

set -gx EDITOR vim
set -gx CUSTOM_BIN ~/.local/bin
set -gx CUSTOM_PATH ~/go/bin /usr/local/go/bin ~/.bun/bin $CUSTOM_BIN $CUSTOM_BIN/paru ~/bin/nvim/bin ~/zig ~/.local/share/nvim/mason/bin
set -gx PATH "$PATH:$CUSTOM_PATH"
set -gx GO_TASK_PROGNAME go-task
set -gx PAGER "bat"

zoxide init --cmd cd fish | source

alias vime="vim -y" # working with (natural) languages with non-ascii characters like JP & AR is a nightmare in vim 
alias nano="nano --modernbindings"
alias zlf="~/zlf.sh"
alias q=exit
alias cl=clear
alias frc="$EDITOR ~/.config/fish/config.fish"
alias brc="$EDITOR ~/.bashrc"
alias zrc="$EDITOR ~/.zshrc"
alias zlrc="$EDITOR ~/.zl_profile"
alias termmode="sudo systemctl isolate multi-user.target"
alias graphmode="sudo systemctl isolate graphical.target"
alias tmuxpi="git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm"
alias code=codium
alias grep="grep --color=always"
alias stow="stow --no-folding"
alias lg=lazygit
alias wrk=go-wrk

if command -v go-task &> /dev/null
	alias task=go-task
end

if test -f ~/.zl_profile.fish
 	source ~/.zl_profile.fish
end

# kitty-specific
alias icat="kitty +kitten icat"

if command -v bat &> /dev/null
	# additionally, you might want to edit /etc/pacman.conf if you use Arch (btw) to enable paru color support
	alias cat="bat --paging never"
end

# other variable exports
set -gx WWW_HOME "www.duckduckgo.com"

if command -v trash &> /dev/null
	alias rm=trash
	alias rml=trash-list
	alias rmrf=trash-empty
	alias rmres=trash-restore
	alias rmr=trash-rm
end

# export FZF_DEFAULT_OPTS='--bind "ctrl-y:execute-silent(printf {} | cut -f 2- | wl-copy --trim-newline)"'
set -gx FZF_DEFAULT_OPT "
	--bind 'ctrl-e:become(echo {+} | xargs -o $EDITOR)'
	--bind 'ctrl-o:become(xdg-open {})'
	--bind 'ctrl-l:become(readlink -f {} | wl-copy && echo item\ copied\ to\ clipboard)'	
	--bind 'ctrl-y:execute(readlink -f {} | wl-copy && echo item\ copied\ to\ clipboard)'	
	--bind '?:toggle-preview'
"

function gitcount
	git ls-files | xargs wc -l
end

function cpr 
	rsync --archive -v --chown=$USER:$USER $argv[1] $argv[2] 
end

if command -v eza &> /dev/null 
	set ex eza
else if command -v lsd &> /dev/null
	set ex lsd
end

if ! test -z $ex
	if string match $ex eza &> /dev/null 
		set extra " modified"
	end

	alias ls="$ex --icons always --group-directories-first"
	alias lsa="ls -al"
	alias lst="ls -al -t$extra"
	alias lss="ls -alS"
end

if command -v yazi &> /dev/null
	alias lf=yazi
end

function yy
	set tmp "$(mktemp -t "yazi-cwd.XXXXXX")"

	yazi "$argv" --cwd-file="$tmp"

	set cwd "$(cat -- "$tmp")"

	if $cwd; and test -n "$cwd"; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end

	rm -f -- "$tmp"
end

function gb  
	set goname

	if test -z $argv[1]
		set goname cmd
	else
		set goname $argv[1]
	end

	go build -o ./bin/$goname 
end

# fedora
function rpml 
	rpm -qa | grep -E  $argv[1] | sort
end

# this is just a function which extend fzf bindings so it wouldn't conflict with apps that use the original bindings
function f 
	fzf --bind 'enter:become(readlink -f {} | wl-copy && echo "item copied to the clipboard")'
end

# find inside files
function fif 
	find . -type f -exec grep --color=always -H $argv[1] {} \;
end

function stop 
	sleep $argv[2] && kill $(pgrep $argv[1])
end

function manv
	$argv | vim +MANPAGER -
end

function rn
	if test $(count $argv) -lt 1 
		echo "you must specify the filename"
		return 1
	end

	if ! test -f $argv[1]
		echo "no file like that"
		return 1
	end

	echo "renaming file $argv[1]"

	set -l splitted $(string split '.' $argv[1])
	set -l sp_length $(count $splitted)
	set -l ext $splitted[$sp_length]

	echo "extension is .$ext"

	set -l new_name $(randstring).$ext
	mv $argv[1] $new_name

	echo "file renamed to $new_name"
end
