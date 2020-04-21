#!/bin/bash 

# Add this to your bashrc on your local machine (i.e., your laptop) to connect to jupyter notebooks on Sverdrup easier.
# The steps are:
#   1. Connect to sverdrup and open up interactive session on a compute node
#   2. Execute 'open_notebook_on_sverdrup.sh' on the compute node
#   3. This returns a port number and IP address, saying
#       "your port number is is: PPPP"
#       "your internet connection is: XX.X.X.X"
#   4. Source this file on your local machine (e.g. your laptop) so that
#      you can use the jupytersv command as follows:
#       jupytersv PPPP XX.X.X.X 
#   5. Open up a web browser and navigate to
#       https://localhost:PPPP
#      where PPPP is the port number 

### Connect to Jupyter notebook on Sverdrup ###
# For compute node notebook, need to pass port number and IP address
export ssh_jump='-J login1.oden.utexas.edu'
jupytersv () {
    ssh -p 8704 $ssh_jump -L localhost:$1:$2:$1 sverdrup.oden.utexas.edu; 
}
