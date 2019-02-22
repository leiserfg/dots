export EDITOR=nvim
export VIRTUAL_ENV_DISABLE_PROMPT="no prompt"
set PATH "/usr/local/opt/python/libexec/bin" $HOME/.local/bin $PATH
#Python local installed packages
set PATH (python3 -m site --user-base)/bin $PATH 

if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

set PATH ~/bin/ $PATH

# if status --is-interactive
    # cat ~/.cache/wal/sequences  ^ /dev/null
# end


#golang
set PATH "$HOME/go/bin/" $PATH
#
#Npm
set -x NPM_PACKAGES $HOME/.npm-packages
set PATH "$NPM_PACKAGES/bin/" $PATH

#Rust
set PATH "$HOME/.cargo/bin/" $PATH

#Colors
if test -n $DISPLAY
    # set TERM 'screen-256color'
    # set fish_term24bit 1
end




#PIPENV
eval (pipenv --completion)

eval (direnv hook fish)

set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_hide_untrackedfiles 1

set -g __fish_git_prompt_color_branch magenta
set -g __fish_git_prompt_showupstream "informative"
set -g __fish_git_prompt_char_upstream_ahead "↑"
set -g __fish_git_prompt_char_upstream_behind "↓"
set -g __fish_git_prompt_char_upstream_prefix ""

set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_dirtystate "✚"
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_conflictedstate "✖"
set -g __fish_git_prompt_char_cleanstate "✔"

set -g __fish_git_prompt_color_dirtystate blue
set -g __fish_git_prompt_color_stagedstate yellow
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
set -g __fish_git_prompt_color_cleanstate green
