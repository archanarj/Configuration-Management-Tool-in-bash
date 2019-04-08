# Configuration-Management-Tool-in-bash
To install and uninstall packages by installing dependent packages and restart libraries if necessary

Documentation:
--------------
--------------

1.bootstrap

before beginning the setup Check for package manager updates and install `needrestart`

2. setup.sh

to install a package, pass the package name to `ROLE_TO_INSTALL`, to uninstall an installed package, add the  name to ROLE_TO_UNINSTALL 
and to Run additional (dependent) scripts before starting the setup use "SCRIPT_PATH" inside the "setup.sh".
Php application content is included in “files” folder with index.php file

3. metadata.txt

 add key(owner, group, mode)=value pairs into the metadata file  

4. handler.sh

To check which daemons need to be restarted after library upgrades 

Steps to execute:

1. Allow port 80 using UFW 

2. copy bootstrap.sh setup.sh handler.sh metadata.txt to `rcmt` dir

3. cd rcmt/

4. chmod +x setup.sh bootstrap.sh handler.sh

5. Invoke  setup.sh file to apply the changes.

#./setup.sh  | tee  /root/rcmt/setup.log



