#! /bin/bash                                                                   
                                                                                
# Run this on a compute node, then use the alias'd ssh function to             \
                                                                                
# connect to the notebook on your local machine (i.e. your laptop)             \
                                                                                

# Please see 'connect_to_tacc_machine_notebook.sh' for instructions on how to use this                                                                            

export port_number=8874 # Set arbitrary four digit port number                  

# A script to get a notebook going on stampede2 compute node                   \
                                                                                
unset XDG_RUNTIME_DIR

echo 'port numer is: ' $port_number

# open the notebook                                                            
                                                                               
jupyter notebook --no-browser --port=$port_number --ip=*
