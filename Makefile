# Assumes minimal install ofUbuntu
# non-CLI taks: Livepatch, GDrive/Google sync, add Canonical Partner PPA, select driver for GPU

standard:
	update utils tweaks python chrome gcloud pycharm spotify postman libre sublime vlc
	# synapitc firewall timeshift

update:
	sudo apt-get update && sudo apt upgrade -y

utils: update
	sudo apt-get install build-essential curl git

tweaks:
	sudo apt install gnome-tweak-tool -y

python: update
	sudo apt-get install python3 python3-venv
	# install pipx for running python modules as CLI tools (i.e. black/poetry)
	python3 -m pip install -U pipx
	python3 -m pipx ensurepath
	# install poetry as python package manager
	pipx install poetry
	# install jupyter as notebook IDE
	pipx install jupyterlab --include-deps

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


pycharm:
	sudo snap install pycharm-community

spotify:
	sudo snap install spotify

slack:
	sudo snap install slack --classic

postman:
	sudo snap install postman

libre:
	sudo snap install libreoffice

sublime:
	sudo snap install sublime-text --classic

steam: 
	sudo add-apt-repository multiverse
	sudo apt update
	sudo apt install steam

docker:


vlc:
	sudo snap install vlc

codecs: # make sure to use tab to select OK 
	sudo apt install ubuntu-restricted-extras -y

synaptic:
	sudo apt install synaptic -y

firewall:
	sudo apt-get install gufw
	sudo ufw enable

timeshift:
	sudo apt-add-repository -y ppa:teejee2008/ppa
	sudo apt update
	sudo apt install timeshift -y

laptop:
	sudo apt install laptop-mode-tools