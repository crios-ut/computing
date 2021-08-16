#! /bin/bash

# Run this on a compute node, then use the alias'd ssh function to 
# connect to the notebook on your local machine (i.e. your laptop)

# Please see 'connect_to_sverdrup_notebook.sh' for instructions on how to use this

export port_number=88${SLURMD_NODENAME//[!0-9]/}

# A script to get a notebook going on sverdrup compute node
unset XDG_RUNTIME_DIR

# get the internet connection
export internet_connect=`ip address show eth0 | grep -Po '(?<=[inet]) (\d+\.\d+\.\d+\.\d+)' | sed 's: ::g'`

echo 'port numer is: ' $port_number
echo 'internet connection is:' $internet_connect

# open the notebook
jupyter notebook --no-browser --port=$port_number --ip=$internet_connect
