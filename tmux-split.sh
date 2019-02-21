#!/bin/sh

if [ $1 = "v" ]; then
  DIR="-v"
  DIM=$(($(tmux display-message -p "#{pane_height}") / $2))
elif [ $1 = "h" ]; then
  DIR="-h"
  DIM=$(($(tmux display-message -p "#{pane_width}") / $2))
else
  exit 1
fi

ID=$(tmux display-message -p "#{pane_id}")

for i in `seq 1 $(($2 - 1))`; do
  tmux split-pane $DIR -t $ID -l $O $DIM
done
