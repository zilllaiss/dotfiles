echo "actions available to use:
- rr : alias of rename_random 1 => rename file to random string
- sr : alias of search_and_replace 1 2 => search and replace things inside files
- rgf : ripgrep + fzf
- get : pacman & paru utilities

Additionally, completion for Taskfile is enabled.
"

set found_task false

command -v go-task &> /dev/null; and begin
	go-task --completion fish | source
	set found_task true
end

if not $found_task; and command -v task &> /dev/null
	task --completion fish | source
end

function rename_random
	test (count $argv) -lt 1; and begin
		echo "you must specify the filename"
		return 1
	end

	test -f $argv[1]; or begin 
		echo "no file with that name"
		return 1
	end

	echo "renaming file $argv[1]"

	set -l splitted (string split '.' $argv[1])
	set -l sp_length (count $splitted)
	set -l ext $splitted[$sp_length]

	echo "extension is .$ext"

	set -l new_name "$(randstring).$ext"
	mv $argv[1] $new_name

	echo "file renamed to $new_name"
end

function search_and_replace
	set -l original $argv[1] 
	set -l new $argv[2]

    test (count $argv) -lt 2; and begin
        echo 'need two arguments'
        return 1
    end

    set -l len (count $argv)
    if test $len -gt 2 
        set -l idx 3
        while test $idx -le $len
            switch "$argv[$idx]"
            case -i 
                set ignore_case '-i' 'I'
            case '*'
                set -a opts "$argv[$idx]"
            end

            set idx (math $idx + 1)
        end
    end

    rg $ignore_case[1] $opts "$original"; or begin
        echo "nothing can be found"
        return 1
    end

	read -P '
Reminder: use regex that works for both ripgrep and sed.
Continue? [y/N]: ' safety


	string match -qi "$safety" y; or return 1

    set files (rg $ignore_case[1] $opts -l "$original")

	sed -i "s/$original/$new/$ignore_case[2]g" $files

    echo "
    File affected: "
    for file in $files 
        echo $file
    end
end

function get
	if test (count $argv) -gt 0 
		switch $argv[1]
		case '-i'
			pacman -Slq | fzf --style=full --preview="pacman -Si {}"
			return
		case '-q'
			pacman -Qq | fzf --style=full --preview="pacman -Qi {}"
			return
		case '-u'
			sudo pacman -Syu
			return
		case '-a'
			set -l softwares ( \
				paru -Salq | fzf -m --ansi --style=full \
					--preview="paru -Gp {} | bat --color=always --style=plain -l bash" \
					--preview-window '~4,+{2}+4/3,<80(up)' \
			)
			test (count $softwares) -lt 1 && and return 1

			paru -Sa --needed $softwares
			return
		case '*'
			echo "unrecognized flag $argv[1]"
			return 1
		end
	end

	set -l softwares (pacman -Slq | fzf -m --ansi --style=full --preview="pacman -Si {}")
	test (count $softwares) -lt 1 && return 1

	sudo pacman -S --needed $softwares
end


# UNFINISHED: Empty variable is not allowed in fish and 
# I'm still figuring out how to circumvent that
function get2
    set pkg pacman
    set main_arg '-S'
    set is_install false
    set _info _info
    set pacman_info '-Si'
    set paru_info '-Gp'

	if test (count $argv) -gt 0 
        for arg in $argv 
            switch $arg
            case '-i'
                set maybe_suf _info

            # this always uses pacman
            case '-q'
                pacman -Qq | fzf --style=full --preview="pacman -Qi {}"
                return

            case '-u'
                set main_arg '-Syu'
                set maybe_sudo sudo
                set extra_args ''

            case '-a'
                set pkg paru
                set extra_args 'a'
                set maybe_sudo ''

            case '*'
                echo "unrecognized flag $arg"
                return 1

            end
        end
    else
        set is_install true
	end

    if $is_install
        set -a common_args ' --needed'
    end

    echo $pkg$_info

    echo "$pkg $preview_arg {} | bat --color=always --style=plain -l bash"

    set softwares ( \
        $pkg -Slq$extra_args | fzf -m --ansi --style=full \
            --preview="$pkg $preview_arg {} | bat --color=always --style=plain -l bash" \
            --preview-window '~4,+{2}+4/3,<80(up)' \
    )
    test (count $softwares) -lt 1 && return 1

    echo "running $maybe_sudo $pkg $main_arg$extra_args $common_args $softwares"

    commandline --replace "$maybe_sudo $pkg $main_arg$extra_args $common_args $softwares"

	# set -l softwares (pacman -Slq | fzf -m --ansi --style=full --preview="pacman -Si {}")
	# test (count $softwares) -lt 1 && return 1

	# sudo pacman -S --needed $softwares
end

function rgf
	set -l RELOAD 'reload:rg --column --color=always --smart-case {q} || :'
 	set -l OPENER 'if test $FZF_SELECT_COUNT -eq 0 
            nvim {1} +{2}     # No selection. Open the current line in Vim.
          else
            nvim +cw -q {+f}  # Build quickfix list for the selected items.
          end'

	fzf --disabled --ansi --multi \
	    --bind "start:$RELOAD" --bind "change:$RELOAD" \
	    --bind "enter:become:$OPENER" \
	    --bind "ctrl-o:execute:$OPENER" \
	    --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
	    --delimiter : \
	    --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
	    --preview-window '~4,+{2}+4/3,<80(up)' \
	    --query "$argv"
end

abbr sr search_and_replace
abbr rr rename_random
