# Defined in /home/leiserfg/.config/fish/functions/fish_prompt.fish @ line 2
function fish_prompt
	if test -w "$PWD"
        set_color blue
    else
        set_color -b red
    end

    printf (prompt_pwd)' '
    if test (id -u $USER) = 0
        printf #
    else if test -n "$SSH_CLIENT"
        printf @
    else
        printf λ
    end
    set_color normal
    printf ' '
end
