# Check for package manager updates
sudo apt-get update
# needrestart checks which daemons need to be restarted after library upgrades
#sudo apt-get install -y needrestart
if [ $(dpkg-query -W -f='${Status}' needrestart  2>/dev/null | grep -c "ok installed") -eq 0 ]; then apt-get install -y needrestart; fi;
