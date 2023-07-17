#! /bin/bash
                                                                                
# Run this on a compute node, then use the alias'd ssh function to             \
# connect to the notebook on your local machine (i.e. your laptop)             \

# Please see 'connect_to_tacc_machine_notebook.sh' for instructions
export port_number=8874

# A script to get a notebook going on a TACC interactive compute node
unset XDG_RUNTIME_DIR

# set the internet connection
export internet_connect=`ip address show em1 | grep -Po '(?<=[inet]) (\d+\.\d+\.\d+\.\d+)' | sed 's: ::g'`

echo 'port number is: ' $port_number 
echo 'internet connection is:' $internet_connect

# open the notebook
jupyter notebook --no-browser --port=$port_number --ip=$internet_connect
