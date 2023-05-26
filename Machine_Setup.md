<LINK href="jb1.css" rel="stylesheet" type="text/css">

#### [Back to index](index.html)

# Machine Setup on surfacebook 2

- [Machine Setup on surfacebook 2](#machine-setup-on-surfacebook-2)
  - [git](#git)
    - [Repositories](#repositories)
    - [Github config](#github-config)
  - [WSL](#wsl)
    - [Basics](#basics)
    - [WSL tips](#wsl-tips)
    - [Linux editor](#linux-editor)
    - [npm](#npm)
    - [Markdown-it](#markdown-it)
    - [unzip](#unzip)
    - [Pandoc](#pandoc)
  - [AWS](#aws)
  - [Python and Conda on windows](#python-and-conda-on-windows)
  - [python libraries](#python-libraries)
  - [Setup on Ubuntu](#setup-on-ubuntu)
  - [13/11/2020 conda on ubuntu setup on book2:](#13112020-conda-on-ubuntu-setup-on-book2)
  - [Docker](#docker)
  - [Windows terminal](#windows-terminal)
  - [Jupyter extensions](#jupyter-extensions)
  - [Google docs](#google-docs)
  - [Node.js on windows](#nodejs-on-windows)
  - [MySQL installation](#mysql-installation)
  - [MySQL Updated Oct 2022](#mysql-updated-oct-2022)

## git

### Repositories

- Education
- Liveminds
- etc

### Github config

install github for windows
install github desktop gui

install VS code, and tick the box to automatically fetch commits.

when commit in VS code, staged commits need to be fully committed.  
commit changes on 1 pc regularly so the other picks up the latest.

set workspace files to ignored by git so are individual to machines.

```bash
sudo apt-get install git
git --version
git config --global user.name "jezza64"
git config --global user.email "jeremy.bates64@gmail.com"

mkdir git
cd git
git init
git remote add <name> https://github.com/jezza64/Education <branch>
```

## WSL

### Basics

Switch on WSL
Install Ubuntu 18.04 on surfacebook 2 from app store
user name jezza64
pwd same as the machine pin

need to upgrade to WSL 2

Installed Ubuntu 20.04 LTS from windows store
updated with:
sudo apt update
sudo apt upgrade

installation is at:
C:\Users\jerem\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu20.04onWindows_79rhkp1fndgsc

WSL ububtu file system is at 
C:\Users\jerem\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu20.04onWindows_79rhkp1fndgsc\LocalState\rootfs

wsl -l to get list of wsl distributions

python is installed, run with
> python3
> python3 --version

git is installed on the ubuntu, v2.17

home folder is home/jezza64
the c drive is mounted at /mnt/c

To edit with VSCode from ubuntu, navigate to the folder, and 
>`code .`

To open explorer from ubuntu
>`explorer.exe .`

Windows path to ubuntu files: \\wsl$\Ubuntu\home\jezza64

Don't use command line to copy between windows and WSL, use explorer.

Operations happen in the ubuntu VM.

Cloned Education repository to Education on ubuntu.
To do this, just `git: clone`, and put in the url.
Didn't do any fancy git setup, just standard clone.

[Good article for Ubuntu on WSL](https://ubuntu.com/wsl)

### WSL tips

Graphical apps can run via WSL, but need a graphical prgram installed e.g. xserver, xfce. Gives a linux graphical shell. Not worth it.

The key point is that even though the WSL and Windows environments can “talk” to each other, there does need to be some segregation of responsibilities. For instance, when using git in WSL, it is recommended that you operate on the files in the WSL environment. The same goes for Windows - don’t try to run Windows executables directly from the WSL file system.

Finally, I still recommend that you use Conda environments to keep your python environments clean. I have chosen to have a conda environment on Ubuntu and one on Windows so that I can make sure blog posts work appropriately across Windows and Linux environments.

### Linux editor

Nano installed.

### npm

installed this to allow markdown-it. Needed nodejs and npm.

```bash
sudo apt install nodejs
sudo apt install npm
sudo npm install -g npm
```

### Markdown-it

```npm install -g markdown-it```

### unzip

sudo apt install unzip

### Pandoc

installed for document conversion word to MD

## AWS

CLI installed on /home/jezza64/aws
aws --version -> aws-cli/2.1.1 Python/3.7.3 Linux/4.4.0-19041-Microsoft exe/x86_64.ubuntu.20

## Python and Conda on windows

installed Miniconda on windows. Not added to path. In c:\software\miniconda
installed python 3.9.0
I only have anaconda installed, so always need to start python from an anaconda prompt.  

created a windows conda environment jbconda1 in C:\software\miniconda3\envs\jbconda1
user config file is at C:\software\miniconda3\envs.condarc
installed python to this conda

select this interpreter in VS Code (That is stored per workspace), use the jbconda1 interpreter 

I've set up the terminal prompt to run anaconda and activate my windows env:
```
            {
                "guid": "{b453ae62-4e3d-5e58-b989-0a998ec44111}",
                "hidden": false,
                "name": "miniconda on windows",
                "icon": "C:\\Software\\anaconda-icon-1024x1024.png",
                "colorScheme" : "Solarized Light",
                "commandline": "%windir%\\System32\\WindowsPowerShell\\v1.0\\powershell.exe -ExecutionPolicy ByPass -NoExit -Command \"& 'C:\\software\\miniconda3\\shell\\condabin\\conda-hook.ps1' ; conda activate 'C:\\software\\miniconda3' ; cd \\users\\jerem ; conda activate jbconda1 \""                
            }
```


>`conda install pandas`  
>`conda install notebook`

run with `jupyter notebook`

## python libraries

- google-auth-httplib2 
- google-auth-oauthlib
- google-api-python-client
- pandas
- numpy
- scikit-learn
- jupyter-notebook

jupyter needed a couple of extras, installed with conda install ...

## Setup on Ubuntu

[good article on python in WSL](https://pbpython.com/wsl-python.html)

installed v 2.7 on ubuntu automatically
installed pip to ubuntu

Python installed on ubuntu, version 3.8. /usr/bin/python3.6.9 64 bit
check with:
>python3 -v

[miniconda installation article](https://www.digitalocean.com/community/tutorials/how-to-install-anaconda-on-ubuntu-18-04-quickstart)

## 13/11/2020 conda on ubuntu setup on book2: 

installed miniconda with pythion 3.8 to /home/jezza64/miniconda3

>cd /tmp  
>wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

conda installed to /home/jezza64/miniconda

to not activate base env on startup:
>conda config --set auto_activate_base false

modified      /home/jezza64/.bashrc

Created a miniconda evnironment (jb1) with python 3.8 (3.9 doesnt use pandas)

Created a miniconda env based on Machine learning book called "ml"  
used envoronment.yml downloaded from https://github.com/abhishekkrthakur/approachingalmost/blob/master/environment.yml (Had to download in windows and copy it across to get rid opf the html in it!)

Had to edit the enrironment_thakur-modified.yml file to remove packages which couldn't be installed by pip:

- python-graphviz
- apex
- sandesh 
- yawml

## Docker

Installing docker desktop for windows 2.2.3.0, "desktop edge"
Use WSL to connect to this.
Changed bios to enable virtual machines. Hyper-v

## Windows terminal

Download from app store
Install chocolaty to get the firacode font
customize settings.json to add fonts, colours etc.

set up menu dropdown for miniconda on windows, added:
```
"commandline": "powershell.exe -ExecutionPolicy ByPass -NoExit  -Command C:\\development\\miniconda3\\shell\\condabin\\conda-hook.ps1 ; conda activate 'C:\\development\\miniconda3'"
```

This gets you into the base conda environment, then use `conda env list`or `conda activate jbconda1`

In terminal, choose Ububtu to go into there, and conda activate jbconda2wsl

Terminal copy is ctrl+shift +c
right click to paste

using bash shell by default. echo $SHELL

install Cascadia code pl font, right click on the one file to use, add to font family in VsCode

## Jupyter extensions

for dark mode:
pip install jupyter\_contrib\_nbextensions\
jupyter contrib nbextension install

## Google docs

New project liveminds1 in console
Enable google sheets and google docs
Client id: 622297012310-i56fmvi0fan4llfhv9ua3kljducgur8e.apps.googleusercontent.com
Client secret: nqt1vlgXYQ1wzkjicXyyhnh7

Google API console:
<https://console.developers.google.com/?authuser=0&project=quickstart-1559839555673>

credentials.json downloaded to C:\\Users\\Jeremy Bates\\development\\python

install google client library

<https://github.com/googleapis/google-api-python-client>


## Node.js on windows

Downloaded and installed on windows. A bit scary, installed lots of stuff to be able to compile tools.
Chocolaty, visual studio compiler, python 3.9 etc

down-it installed for .md conversion  
>`npm install -g markdown-it`
in C:\Users\jerem\AppData\Roaming\npm\node_modules\markdown-it\bin\markdown-it.js  

gulp installed for VS code automation:  
>`npm install -g gulp`
in C:\Users\jerem\AppData\Roaming\npm\node_modules\gulp\bin\gulp.js  

## MySQL installation

Installed 8.022 to Program files\MySQL
Root is Bj7
user: jeremy / Bj7
installed to windows, as service.
Service name MySQL80
Runs on system account

MySQLShell: command line interface, connect from PS termial with 
>`cd C:\Program Files\MySQL\MySQL Server 8.0\bin`  
>`.\mysql -u root -p`

MySQLWorkbench

Connect to localhost, 3306

## MySQL Updated Oct 2022
It runs as a service automatically.

To connect:
run the program for the command line client
password is Bj7, seems to work ok
show databases

To connect in MySQLWorkbench
Connect to localhost, 3306

seems to work ok.


