# Jupyter

## Guide to start using Jupyter Notebooks on Sverdrup and TACC Machines

### Prerequisites
1. **Python installation on Sverdrup (using miniconda)**

   - Grab one of the scripts for installing miniconda, depending on if you want [Python 3.8](https://repo.anaconda.com/miniconda/Miniconda3-py39_4.9.2-Linux-x86_64.sh) or [Python 3.9](https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh).

   - Secure copy (scp) the script to Sverdrup using the following command (on your local machine, i.e. your laptop). If you are not using the VPN, you need to jump through the login node. You can read more [here](https://www.oden.utexas.edu/sysdocs/ssh/index.html). Use the following command -
   ```
   scp -J username@login1.oden.utexas.edu script_path/script_name username@sverdrup.oden.utexas.edu:/home/username/desired_path/desired_script_name
   ```
     Here `script_path` and `script_name` refer to the path and name of the script on your local machine (i.e. your laptop). Similarly, `desired_script_path` and `desired_script_name` refer to the desired path and name of the script on Sverdrup.

   - Run the scripts as described [here](https://docs.conda.io/projects/conda/en/latest/user-guide/install/linux.html). Most likely, only the following command will be needed (assuming the script is in your CWD)- `bash desired_script_name`.

2. **Create conda environment**

  - One of the many ways is to use a **yaml** file that contains a comprehensive list of packages that you need. For example, one can use the file [py38.yaml](../conda/py38.yaml) in this same repository.

  - Use this command to create the conda environment -
  ```
  conda env create -f py38.yaml
  ```

3. **Set a password for jupyter notebook**

  - When you run a jupyter server for the first time you will have to set up a password, and deal with some other specifics. While the instructions are summarized here, you can find more information [here](https://jupyter-notebook.readthedocs.io/en/stable/public_server.html).

  - Notebook configuration file

    The following file should be present `.jupyter/jupyter_notebook_config.py` in your installation directory (most likely your home directory). If not use this command to generate one -
    ```
    jupyter notebook --generate-config
    ```

  - Set your password

    There are two ways to do this.

    - Automatic
      ```
      jupyter notebook password
      Enter password:  ****
      Verify password: ****
      ```

      This will modify the json file in `.jupyter`.

    - Manual

      Alternatively, you can convert your password into a hash key and add it manually to `.jupyter/jupyter_notebook_config.py`.

      ```
      $ ipython
      In [1]: from notebook.auth import passwd
      In [2]: passwd()
      Enter password: ****
      Verify password: ****
      Out[2]: 'your_hashed_password'
      ```

      Add hashed password to your notebook configuration file.

      Find the `c.NotebookApp.password` field in `.jupyter/jupyter_notebook_config.py`, which might be commented out. Modify the line as follows -
      ```
      c.NotebookApp.password = u'your_hashed_password'
      ```

    Automatic password setup will store the hash in `jupyter_notebook_config.json` while this method stores the hash in `jupyter_notebook_config.py`. The `.json` configuration options take precedence over the `.py` one, thus the manual password may not take effect if the `.json` file has a password set.

  - Use SSL for encrypted communication

    Generate a self signed certificate and key.

    ```
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout mykey.key -out mycert.pem
    ```

    You can start the notebook to communicate via a secure protocol mode by setting the certfile option to your self-signed certificate, i.e. mycert.pem, with the command:
    ```
    jupyter notebook --certfile=mycert.pem --keyfile mykey.key
    ```

    This step might not be necessary if you add `mycert.pem` and `mykey.key` manually to `jupyter_notebook_config.py`.

  - Running a public notebook server

    In the `~/.jupyter` directory, edit the notebook config file, `jupyter_notebook_config.py`. By default, the notebook config file has all fields commented out. The minimum set of configuration options that you should uncomment and edit in `jupyter_notebook_config.py` is the following:

    ```
    # Set options for certfile, ip, password, and toggle off
    # browser auto-opening
    c.NotebookApp.certfile = u'/absolute/path/to/your/certificate/mycert.pem'
    c.NotebookApp.keyfile = u'/absolute/path/to/your/certificate/mykey.key'
    # Set ip to '*' to bind on all interfaces (ips) for the public server
    c.NotebookApp.ip = '*'
    c.NotebookApp.password = u'sha1:bcd259ccf...<your hashed password here>'
    c.NotebookApp.open_browser = False

    # It is a good idea to set a known, fixed port for server access
    c.NotebookApp.port = 9999
    ```

    You can then start the notebook as follows  -

    1. Connect to desired machine and open up interactive session on compute node. Typical commands to do this are:

      - sverdrup:

        ```
        srun -t 1440 -N 1 --ntasks 4 --cpus-per-task=7 --pty bash -i
        ```

      - TACC: 

        ```
        TACC: idev -p normal -N 2 -n 8 -m 150
        ```

    2. Activate your conda environment on the compute node. Use this command to activate the environment `py38` (see Prerequisites) and add it to your jupyter kernel.
        
        ```
        conda activate py38
        python -m ipykernel install --user --name=py38
        ```

    3. Initialize jupyter notebook server on remote machine
    
      - sverdrup: Run [open_notebook_on_sverdrup.sh](open_notebook_on_sverdrup.sh)

        - You will get IP XX.X.X.XX, and port number PPPP

      - TACC: Run [open_notebook_on_tacc_machine.sh](open_notebook_on_tacc_machine.sh)

        - This returns a port number saying "your port number is is: PPPP"
          (Disregard the message saying that the port is listening on all IP addresses)

    4. For TACC Machines Only: If the jupyter notebook server has been initialized on a TACC machine, navigate to the function in the [connect_to_tacc_machine_notebook.sh](connect_to_tacc_machine_notebook.sh) file and modify it according to the appropriate TACC machine using the following convention: 
      
        ```
        jupyter_tacc () {
              ssh -L localhost:$1:$2:$1 <TACC_machine>.tacc.utexas.edu;             
        }
        ```

        (where  "TACC_machine" is the name of the TACC machine the compute node is running on (i.e. "stampede2", "frontera", etc))

        NOTE: The [connect_to_tacc_machine_notebook.sh](connect_to_tacc_machine_notebook.sh) file's 'jupyter_tacc()' function is initialized to stampede2 compute nodes and does not
        need to be modified if the user initializes a jupyter notebook serveron a stampede2 compute node.
          
    5. Source [connect_to_sverdrup_notebook.sh](connect_to_sverdrup_notebook.sh) or [connect_to_tacc_machine_notebook.sh](connect_to_tacc_machine_notebook.sh) in the `.bashrc` on your local machine (i.e. your laptop) so that you can use the `jupytersv` command.

      - sverdrup:

        ```
        source connect_to_sverdrup_notebook.sh
        ```

      - TACC: 

        ``` 
        source connect_to_tacc_machine_notebook.sh
        ```

    6. On your local machine (i.e. your laptop), call the [connect_to_sverdrup_notebook.sh](connect_to_sverdrup_notebook.sh) or [connect_to_tacc_machine_notebook.sh](connect_to_tacc_machine_notebook.sh) functions from the command line to establish a connection between 
    local server and remote jupyter notebook server.

      - sverdrup: 

        ```
        jupytersv PPPP XX.X.X.XX
        ```

      - TACC: 

        ```
        jupyter_tacc PPPP compute_node_hostname
        ```

        Ex: If the port number is 8874 and the compute node hostname is 'c407-408.stampede2.tacc.utexas.edu', then the associated command would be 'jupyter_tacc 8874 c407-408.stampede2.tacc.utexas.edu'


    7. Open up a web browser and navigate to https://localhost:PPPP or
    copy and paste one of the URL's output on the remote machine terminal from the [open_notebook_on_sverdrup.sh](open_notebook_on_sverdrup.sh) or [open_notebook_on_tacc_machine.sh](open_notebook_on_tacc_machine.sh) command into a web browser on your local machine.
    
    8. If using Google Chrome, you may be told that connection to localhost is insecure. To continue, click anywhere on the Chrome window and type "thisisunsafe", and you will arrive at a jupyter notebook login screen. Enter your Sverdrup password to proceed.
