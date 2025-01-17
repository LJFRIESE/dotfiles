# Setup fzf
# ---------
if [[ ! "$PATH" == */home/ljfriese/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/ljfriese/.fzf/bin"
fi

eval "$(fzf --bash)"
