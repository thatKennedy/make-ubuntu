# Assumes minimal install of Ubuntu 20.04
# non-CLI taks: Livepatch, GDrive/Google sync, add Canonical Partner PPA, select driver for GPU
# install Dropbox
# display scale for screen size

# make sure to
# sudo apt install make

# TODO: pin versions where possible

dirs:
	mkdir ~/Downloads
	mkdir ~/Programs
	mkdir ~/Repos

update:
	sudo apt-get update 

upgrade: update
	sudo apt upgrade

git:
	sudo apt install git
	git config --global user.email "j@thatkennedy.net"
	git config --global user.name "thatkennedy"

utils: update
	sudo apt-get install build-essential \
	libssl-dev libffi-dev \
	curl  software-properties-common unzip -y

python38: 
	sudo apt update
	sudo apt install python3.8 python3.8-distutils python3.8-venv
	curl https://bootstrap.pypa.io/get-pip.py -o ~/Downloads/get-pip.py
	python3.8 ~/Downloads/get-pip.py
	# install pipx for running python modules as CLI tools (i.e. black/poetry)
	python3.8 -m pip install -U pipx
	python3.8 -m pipx ensurepath
	# need to restart terminal session for pipx to catch

pipx_tools:
	# install poetry as python package manager
	pipx install 'poetry==1.1.3'
	# install jupyter as notebook IDE
	pipx install jupyterlab --include-deps
	pipx install nbstripout

GECODE = ~/Programs/gecode
gecode:
	git clone https://github.com/Gecode/gecode $(GECODE)
	mkdir $(GECODE)/build
	cd $(GECODE)/build && ../configure
	cd $(GECODE)/build && make -j8
	cd $(GECODE)/build && sudo make install

minizinc:
	wget https://github.com/MiniZinc/MiniZincIDE/releases/download/2.5.1/MiniZincIDE-2.5.1-bundle-linux-x86_64.tgz -P ~/Downloads/
	tar -xvzf ~/Downloads/MiniZincIDE-2.5.1-bundle-linux-x86_64.tgz -C ~/Programs
	# still need to add the following to .bashrc
	# export MZPATH=~/Programs/MiniZincIDE-2.5.1-bundle-linux-x86_64
	# export PATH="$PATH:$MZPATH/bin"
	# export LD_LIBRARY_PATH=$MZPATH/lib:$LD_LIBRARY_PATH
	# export QT_PLUGIN_PATH=$MZPATH/plugins:$QT_PLUGIN_PATH

# https://github.com/balena-io/balena-cli/blob/master/INSTALL-ADVANCED.md
# https://github.com/balena-io/balena-cli/blob/master/INSTALL-LINUX.md
balena: 
	wget https://github.com/balena-io/balena-cli/releases/download/v12.26.1/balena-cli-v12.26.1-linux-x64-standalone.zip -P ~/Downloads/
	unzip ~/Downloads/balena-cli-v12.26.1-linux-x64-standalone.zip -d ~/Programs
	# still need to add the following to .bashrc
	# export BALENAPATH=~/Programs/balena-cli/
	# export PATH="$PATH:$BALENAPATH/"

brave:
	sudo apt install apt-transport-https curl
	curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
	echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
	sudo apt update
	sudo apt install brave-browser

ssh-server: update
	sudo apt install openssh-server
	sudo systemctl status ssh
	sudo ufw allow ssh

grubber:
	sudo apt install grub-customizer

tweaks:
	sudo apt install gnome-tweak-tool -y

chrome: 
	cd ~/Downloads
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo dpkg -i google-chrome-stable_current_amd64.deb
	rm google-chrome-stable_current_amd64.deb
	cd ~

# https://cloud.google.com/sdk/docs/quickstart-debian-ubuntu
gcloud:
	# Add the Cloud SDK distribution URI as a package source, 
	echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
	# Import the Google Cloud Platform public key
	curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
	# Update the package list and install the Cloud SDK
	sudo apt-get update && sudo apt-get install google-cloud-sdk# gcloud init

# for burning iso's to usb drives
usb-creator:
	sudo apt-get install usb-creator-gtk

gparted:
	sudo apt-get install gparted -y

pycharm:
	sudo snap install pycharm-community --classic

joplin:
	wget -O - https://raw.githubusercontent.com/laurent22/joplin/master/Joplin_install_and_update.sh | bash

spotify:
	curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - 
	echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
	sudo apt-get update && sudo apt-get install spotify-client

slack:
	sudo snap install slack --classic

postman:
	sudo snap install postman

libre:
	sudo snap install libreoffice

sublime:
	sudo snap install sublime-text --classic

steam: 
	sudo add-apt-repository multiverse -y
	sudo apt update
	sudo apt install steam -y 

# not the stable version for the registry is specifically set to bionic as focal isn't available
docker_bionic: #sudo apt-get remove docker docker-engine docker.io containerd runc
	sudo apt-get install apt-transport-https ca-certificates gnupg-agent software-properties-common
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
	sudo apt-get install docker-ce docker-ce-cli containerd.io

docker_user:
	#sudo groupadd docker
	sudo usermod -aG docker $(USER)

purge_docker:
	sudo apt-get purge docker-ce docker-ce-cli containerd.io
	sudo rm -rf /var/lib/docker


OS=Linux# uname -s
ARCH=x86_64# uname -m
make docker_compose:
	# install docker compose 
	sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(OS)-$(ARCH)" -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose

vlc:
	sudo snap install vlc

codecs: # make sure to use tab to select OK 
	sudo apt install ubuntu-restricted-extras -y

firewall:
	sudo apt-get install gufw
	sudo ufw enable

timeshift:
	sudo apt-add-repository -y ppa:teejee2008/ppa
	sudo apt update 
	sudo apt install timeshift -y

powerstat:
	sudo snap install powerstat

laptop-mode:
	sudo apt install laptop-mode-tools

synaptic:
	sudo apt install synaptic -y

gimp:
	sudo snap install gimp

pdf_viewer:
	sudo apt-get install okular

psql_client: update
	sudo apt-get install postgresql-client

freecad:
	sudo apt-get install freecad
