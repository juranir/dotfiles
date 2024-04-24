# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
# Enable auto-update for Oh My Zsh
zstyle ':omz:update' mode auto

# This will check for updates every 7 days
zstyle ':omz:update' frequency 7

# Compinstall - Shell completion
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit
compinit

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# SET ZSH THEME
#source ~/.zsh/themes/powerlevel10k/powerlevel10k.zsh-theme
source ~/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme

# Load p10k theme settings
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Load ZSH Plugins
test -f ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh &&  source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
test -f ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh && source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
test -f ~/.zsh/plugins/git.plugin.zsh && source ~/.zsh/plugins/git.plugin.zsh

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Load ZSH Auto-completion

# Load other stuff
[[ ! -f ~/.kubecm ]] || source ~/.kubecm
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# History file
SAVEHIST=10000  # Save 10k lines in history file
HISTFILE=~/.zsh_history

# Aliases
test -f  ~/.zsh/zsh-aliases.sh && source ~/.zsh/zsh-aliases.sh

# Functions
test -f  ~/.zsh/zsh-functions.sh && source ~/.zsh/zsh-functions.sh

# Bind Keys - Mac
# https://medium.com/@elhayefrat/how-to-fix-the-home-and-end-buttons-for-an-external-keyboard-in-mac-4da773a0d3a2

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

# Loading Krew
test -d ~/.krew/bin && export PATH="${PATH}:${HOME}/.krew/bin"

# Disable error message: Insecure completion-dependent directories detected
# https://pascalnaber.wordpress.com/2019/10/05/have-a-great-looking-terminal-and-a-more-effective-shell-with-oh-my-zsh-on-wsl-2-using-windows/
ZSH_DISABLE_COMPFIX=true

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="~/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME="powerlevel10k/powerlevel10k"
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#eval "$(oh-my-posh init zsh)"
#eval "$(oh-my-posh init zsh --config ~/M365Princess.omp.json)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Loading kube-ps1
# source "/opt/homebrew/opt/kube-ps1/share/kube-ps1.sh"
# PS1='$(kube_ps1)'$PS1

test -f /opt/homebrew/opt/kube-ps1/share/kube-ps1.sh && source /opt/homebrew/opt/kube-ps1/share/kube-ps1.sh

# Loading Mcfly
eval "$(mcfly init zsh)"

# Startup commands
# yadm pull > /dev/null

test -d /opt/homebrew/opt/mysql-client/ && export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"


# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
export PATH="/opt/homebrew/opt/sqlite/bin:$PATH"

# Custom PATH
#export PATH="/Users/juranir/OneDrive/kubectl-plugins:$PATH"
export PATH="/Users/juranir/go/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Alias
#alias remove
alias ll='ls -la'
alias k='kubectl'
alias ke='kubectl eks'
alias kx='kubectx'
alias kc='kubectl config current-context'
alias kl='kubectl logs'
alias kw='watch kubectl'
alias ldd='otool -L'
alias python='python3'
alias goc='~/OneDrive/Findmore/OutCloud/3E/gitConfig.sh && git config --list'
alias gp="~/OneDrive/gitConfig.sh && git config --list"
alias gpaz="~/OneDrive/gitConfig.sh az && git config --list"
alias kd='kubectl describe'
alias gocaz='~/OneDrive/Findmore/OutCloud/3E/gitConfig.sh az && git config --list'
alias kl='kubectl logs'
