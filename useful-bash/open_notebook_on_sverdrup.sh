#! /bin/bash

# Run this on a compute node, then use the alias'd ssh function to 
# connect to the notebook on your local machine (i.e. your laptop)

export port_number=8890

# A script to get a notebook going on sverdrup compute node
unset XDG_RUNTIME_DIR

# get the internet connection
export internet_connect=`ip address show eth0 | grep -Po '(?<=[inet]) (\d+\.\d+\.\d+\.\d+)' | sed 's: ::g'`

echo 'internet connection is:' $internet_connect

# open the notebook
jupyter notebook --no-browser --port=$port_number --ip=$internet_connect
