# Bio-molecular modeling 2022
Welcome to Biomolecular modeling 2022.

Hello world!

## What is this?
This repo contains `install.sh`, a script for installing course
software on under `Ubuntu`.
> Do I need ubuntu for the course?

Yes, you do, but do not worry, we will show how to get it and also remove it when the course is over (if you are not already runing linux, that is).

## Not a linux user already?
If you are using MacOS or Windows, we will simply install VirtaulBox and run Ubuntu on your existing opertaing system.
1. Download the [Ubuntu 20.04.4 iso image](https://ubuntu.com/download/desktop)
2. Download and install [virtualbox](https://virtualbox.org)
	- Open VirtualBox and select `New` and give the VM a `Name` such as <mark>Ubuntu</mark>. 
	- Allocate at least 1024 MB of memeory to the VM.
	- Create a `virtual hard disk` and make it a **minimum 50GB** in size and **Dynamically allocated**.
		- If you plan on keeping the VM after the course, we recommend going for 100 GB **fixed size**. 
	
	- When starting the VM for the first time you wil be asked to select a `virtual optical disk file`. This is where you point to the recently downloaded Ubuntu iso file.
	- Install ubuntu by selecting the downloaded ubuntu iso file as your `Media source`.
	- Finish the installation as `minimal` install.


NOTE: If you have the new M1 macbook, virtual box will not work. Use
	- https://www.parallels.com/eu/ 

## How to install course software (Ubuntu / VM)
Open a command line and install `git`: 
```bash=1
sudo apt-get install git
```
When git is installed, clone this repo:
```bash=2
git clone https://github.com/isaksengeir/biomolmod
````
Move into biomolmod and run the install script
```bash=1
cd biomolmod
./install.sh
```
This will thake ~30 minutes depending on your internet connection. When the install script is done, **restart** the terminal window, and you should be all set for some molecular modeling. 


## TigerVNC
```
VNC server: desktop.saga.sigma2.no:5901
```

### MacOS
#### Install Homebrew
copy paste this command into your terminal
```bash=1
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### Install TigerVNC with brew
```bash=1
brew install tiger-vnc
```
Homebrew puts the `vncviewer` executable here `/usr/local/Cellar/tiger-vnc/1.12.0/bin/`, but normally it can be launched by typing `vncviewer` in the terminal.


### Windows 
Go to [https://tigervnc.org](https://tigervnc.org) and follow instrucions to get a suitable self contained binary for your system.


## Time schedule 
### Mon April 4th
- 09:15 - 12:00
	- Coffee, meet & greet (BOB/GVI)
	- Software install etc (GVI)
	- Basic Bash & SSH (GVI)
	- VR lab session (DS)
- 13:15 - 14:00:
	- Lecture: Basics force fields (BOB)
- 14:15 - 15:00:
	- Becoming a command line ninja: basic Bash, ssh and scp.

### Tue April 5th
- 09:15 - 10:00:
 	- Lecture: Simulations  (BOB)
- 10:15 - 11:00:
	- Lecture: Free energy perturbation (Bob)
- 11:15 - 13:00:
	- Practical: Ion hydration in water (Bob)
- 13:00 - 15:00:
	- Lecture: DFT (GVI)
	- Gaussian / GaussView / Molden chemREACT
	- Practical: DFT reference reaction

### Wed April 6th
- 09:15 - 10:00
	- DFT practical 
- 10:15 - 12:00
	- Lecture: Empirical Valence Bond (GVI)
	- Qgui
	
- 13:00 - 15:00:
	- DFT practical
	- EVB practical

### Thu April 7th
- 09:15 - 10:00 
	- Practicals
- 10:15 - 11:00
	- Repetition (BOB)
- 11:00 - 15:00
	- Practicals

### Fri April 8th
- 09:15 - 10:00
	- Practials / report
- 10:15 - 11:00
	- Popular science talk by Johan ??qvist
- 11:15 - 12:00
	- ENDEX 
