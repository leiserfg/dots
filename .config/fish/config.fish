export EDITOR=nvim
export MANPAGER='nvim +Man!'

set -U FZF_LEGACY_KEYBINDINGS 0
export VIRTUAL_ENV_DISABLE_PROMPT="no prompt"
# set PATH "/usr/local/opt/python/libexec/bin" $HOME/.local/bin $PATH
set PATH $HOME/.local/bin $PATH
set PATH $HOME/.nimble/bin $PATH

# set PATH ~/bin/ (yarn global bin 2>/dev/null) $PATH
set PATH $HOME/bin/ $HOME/.yarn/bin $PATH


#Rust
set PATH "$HOME/.cargo/bin/" $PATH

export NODE_VERSIONS=$HOME/.config/nvm/
export NODE_VERSION_PREFIX=''

direnv hook fish|source

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

export DOCKER_BUILDKIT=1
zoxide init fish | source

