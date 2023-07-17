#!/bin/bash 

# Add this to your bashrc on your local machine (i.e., your laptop) to connect to jupyter notebooks on Sverdrup easier.
# The steps are:
#   1. Connect to TACC machine and open up interactive session on a compute node
#   2. Activate conda environment on compute node 
#   3. Install conda environment on jupyter kernel (this step only needs to be done
#   once on each machine independent of the compute node hostname)
#   4. Execute 'open_notebook_on_tacc_machine.sh' on the compute node
#   5. This returns a port number saying:
#       "your port number is is: PPPP"
#   (Disregard the message saying that the port is listening on all IP addresses)
#   6. Source this file on your local machine (e.g. your laptop)
#       by running <source connect_to_tacc_machine_notebook.sh> so that
#      you can use the jupyter_tacc command as follows:
#       <jupyter_tacc PPPP compute_node_hostname>
#   5. Open up a web browser and navigate to
#       https://localhost:PPPP
#      (where PPPP is the port number)

####### Connecting to jupyter notebook on TACC Machines ############ 

# NOTE: 

# For notebook, need to pass port number and IP address using the following convention          
# (where  "<TACC_machine>" is the name of the TACC machine the compute node is running 
# on (i.e. "stampede2", "frontera", "ls6")):

# jupyter_tacc () {
#     ssh -L localhost:$1:$2:$1 <TACC_machine>.tacc.utexas.edu;             
# }

# The following example is used to connect a jupyter notebook
# server running on a stampede2 compute node to the user's local machine
# Make sure to replace <stampede2> with the lowest-level domain name 
# of the applicable TACC machine (<frontera>, <lonestar>, etc.) if applicable

jupyter_tacc () {
    ssh -L localhost:$1:$2:$1 stampede2.tacc.utexas.edu;             

}
