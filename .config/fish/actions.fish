echo "actions available to use:
- rr : rename_random 1
- sr : search_and_replace 1 2"

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
                echo 'unrecognized flag'
                return 1
            end

            set idx (math $idx + 1)
        end
    end

    rg $ignore_case[1] "$original"; or begin
        echo "nothing can be found"
        return 1
    end

	read -P 'Continue? [y/N]: ' safety

	string match -qi "$safety" y; or return 1

    set files (rg $ignore_case[1] -l "$original")

	sed -i "s/$original/$new/$ignore_case[2]g" $files

    echo "File affected: "
    for file in $files 
        echo $file
    end
end

abbr sr search_and_replace
abbr rr rename_random
