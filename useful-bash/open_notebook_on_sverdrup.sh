#! /bin/bash

# A script to get a notebook going on sverdrup compute node
unset XDG_RUNTIME_DIR

# get the internet connection
export internet_connect=`ip address show eth0 | grep -Po '(?<=[inet]) (\d+\.\d+\.\d+\.\d+)' | sed 's: ::g'`

echo 'internet connection is:' $internet_connect

# open the notebook
jupyter notebook --no-browser --port=8890 --ip=$internet_connect
