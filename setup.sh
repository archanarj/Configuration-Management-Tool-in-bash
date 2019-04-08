#!/bin/bash
set -x e

SCRIPT_PATH=/root/rcmt/bootstrap.sh
SCRIPT_PATH_1=/root/rcmt/handler.sh
ROLE_TO_INSTALL="php5"
ROLE_TO_UNINSTALL="lsof"
SETUP_LOG=/root/rcmt/setup.log

exec >> $SETUP_LOG
exec 2>&1

OUTPUT_BOOTSTRAP=$("$SCRIPT_PATH")
#echo $OUTPUT_BOOTSTRAP

# Remove package config files and uninstalled files

echo "Starting to uninstall listed pkgs... ` date '+%m%d%Y %H:%M %Z'`"

for removepkg in $ROLE_TO_UNINSTALL; do if [ $(dpkg-query -W -f='${Status}' $removepkg  2>/dev/null | grep -c "ok installed") -gt 0 ]; then apt-get remove -y  $removepkg && apt-get purge -y  $removepkg && apt-get clean; fi; done

echo "Finished uninstalling pkgs at `date '+%m%d%Y %H:%M %Z'`"

echo "Starting to install listed pkgs... ` date '+%m%d%Y %H:%M %Z'`"

for installpkg in $ROLE_TO_INSTALL; do  if [ $(dpkg-query -W -f='${Status}' $installpkg  2>/dev/null | grep -c "ok installed") -eq 0 ]; then apt-get install -y $installpkg; fi; done

echo "Finished installing pkgs at `date '+%m%d%Y %H:%M %Z'`"

echo "restarting lib if required.."

OUTPUT_HANDLER=$("$SCRIPT_PATH_1")
echo $OUTPUT_HANDLER

echo -p "Replace default index.html with index.php if the file exists"

if [ -f "/var/www/html/index.html" ]; then sudo rm /var/www/html/index.html && touch /var/www/html/index.php; fi

if [ -s metadata ]; then
  declare -A metadata
  while IFS== read -r key value; do
    metadata[$key]=$value
  done < "metadata"
  sudo chmod "${metadata[permissions]}" "${metadata[file]}"
  sudo chown "${metadata[owner]}" "${metadata[file]}"
  sudo chgrp "${metadata[group]}" "${metadata[file]}"
  sudo echo "${metadata[content]}" > "${metadata[file]}"
fi
