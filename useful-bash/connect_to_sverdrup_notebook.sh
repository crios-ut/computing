#!/bin/bash 

# Add this to your bashrc to connect to jupyter notebooks on Sverdrup easier.
# The steps are:
#   1. Connect to sverdrup and open up interactive session on a compute node
#   2. Execute 'open_notebook_on_sverdrup.sh' on the compute node
#   3. This returns an IP address, say XX.X.X.X
#   4. Use the alias below on your local machine (e.g. your laptop) to connect as:
#       jupytersv XX.X.X.X 
#   5. Open up a web browser and navigate to
#       https://localhost:PPPP
#      where PPPP is the port_number set below

### Connect to Jupyter notebook on Sverdrup ###
# For compute node notebook, need to pass IP address
# The alias below does this by:
#   1. Create a temporary function which takes in passed arguments
#   2. unset the temp function after running the desired ssh command
#   3. execute
export port_number='8890'
export ssh_jump='-J login1.ices.utexas.edu'
alias jupytersv='temporary_function(){
    ssh -p 8704 -i ~/.ssh/sverdrup_rsa '$ssh_jump' -L localhost:'$port_number':"$@":'$port_number' sverdrup.ices.utexas.edu; 
    unset -f temporary_function;}; 
    temporary_function'
