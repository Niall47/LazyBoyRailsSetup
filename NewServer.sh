#!/bin/bash
_user="$(id -u -n)"
location="/home/$_user/Documents/Ruby/Rails/NewServer"
if [ -d $location ]
then
	 echo "Found existing server at $location"
	duplicate
else
	installAndRun
fi

function installAndRun{
	sudo gem install rails
        mkdir $location
        rails new $location
        cd $location
        bin/rails server
	echo "All done I think"
}
function duplicate{
        read -p "Would you like me to overwrite? [Y]es or [N]o"; yn
                case $yn in
                        [Yy]* ) installAndRun;
                        [Nn]* ) newDirectory;
		esac
}
function newDirectory{
        read -p "Would you like to install in a custom directory?"; yni
        case $yni in
                [Yy]* )echo "Paste directory below"; read $location;; installAndRun
                [Nn]* )exit;

}
