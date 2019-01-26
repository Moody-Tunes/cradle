# Cradle
Infastructure definitions for MoodyTunes


## Getting Started

- Create a directory on your computer to hold the MoodyTunes repositories

`mdkir MoodyTunes && cd MoodyTunes`

- Clone this repository and the moodytunes repository

`git clone https://github.com/Moody-Tunes/cradle.git`
`git clone https://github.com/Moody-Tunes/moodytunes.git`

- Install [virtualbox](https://www.virtualbox.org/wiki/Downloads)
- Install [vagrant](https://www.vagrantup.com/downloads.html) and add to $PATH
- Create and activate a python3 virtual environment: `python3 -m venv venv`
- Install dependencies: `(venv) pip install -r requirements.txt`
	- If you can't install ansible because of dependencies, you might need to install libffi-dev


## Installing and booting Virtual Machine

- Bring up virtual machine with Vagrant: `vagrant up mtdj`
	- This should download the Ubuntu 18.04 virtualbox (might take a while the first time) and provision the box with the needed site programs, dependencies, and tools needed to run MoodyTunes
