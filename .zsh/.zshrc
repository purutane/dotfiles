# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/dno/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# antigen
source ${ZDOTDIR}/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundles <<EOBUNDLES
  # Bundles from the default repo (robbyrussell's oh-my-zsh)
  git
  
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions
  jeffreytse/zsh-vi-mode
EOBUNDLES

antigen apply

# Environment Valueable and alias
export EDITOR=vim
if [[ ! -n ${TMUX} ]]; then
  # editor
  export EDITOR=vim
  # fzf
  export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!\.git/*"'
  export FZF_DEFAULT_OPT='--inline-info'
fi

# prompt
function git_branch_name() {
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == "" ]]; then
    echo '%F{39}%f '
  else
    gstatus=$(git status 2> /dev/null)
    symbols=""
    if [[ $(echo $gstatus | grep "Untracked files") != "" ]]; then
      symbols+="?"
    fi
    if [[ $(echo $gstatus | grep "Changes not staged for commit") != "" ]]; then
      symbols+="*"
    fi
    if [[ $(echo $gstatus | grep "Changes to be committed") != "" ]]; then
      symbols+="+"
    fi
    if [[ $symbols == "" ]]; then
      echo '%K{135}%F{39}%f  '$branch' %k%F{135}%f '
    else
      echo '%K{135}%F{39}%f  '$branch' '$symbols' %k%F{135}%f '
    fi
  fi
}
setopt prompt_subst
PROMPT='%F{39}%f%K{39}%F{237}  %~ %k%f$(git_branch_name)'

# alias
alias ls='ls --color=auto'
alias ll='ls -l'
alias view='vim -R'
alias vf='vim $(fzf)'

# history-search
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end

# launch tmux
if [[ ! -n ${TMUX} ]]; then
  tmux new-session
fi

