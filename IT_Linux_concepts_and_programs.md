<LINK href="jb1.css" rel="stylesheet" type="text/css">

#### [Back to index](index.html)

# Linux concepts and tools

- [Linux concepts and tools](#linux-concepts-and-tools)
  - [WSL](#wsl)
  - [Linux BASH](#linux-bash)
  - [Bash scripting](#bash-scripting)
  - [Ubuntu](#ubuntu)
    - [VS Code on Ubuntu (Remote)](#vs-code-on-ubuntu-remote)
  - [Windows Powershell](#windows-powershell)
  - [ssh (secure shell)](#ssh-secure-shell)
    - [Connecting to a VM with ssh](#connecting-to-a-vm-with-ssh)
    - [Create ssh keys](#create-ssh-keys)
    - [Configure agent forwarding](#configure-agent-forwarding)
  - [curl (client for URLs)](#curl-client-for-urls)
  - [Linux commands](#linux-commands)
    - [Folder setup](#folder-setup)
    - [Sudo](#sudo)
    - [version info](#version-info)
  - [APT Package management](#apt-package-management)
    - [basic APT package commands](#basic-apt-package-commands)
    - [installing using APT](#installing-using-apt)
    - [installing using npm](#installing-using-npm)

These are notes on facilities on Linux

## WSL

64 bit only.

## Linux BASH

Windows 10 allows Linux without needing a VM: runs the standard BASH shell within windows. Called WSL (windows subsystem for linux). Then install e.g. Ubuntu.
Don't need separate VM.

Means can use commands and services like apache, MySQL, and run BASH scripts.

Need to allow linux subsystem on windows settings, and install linux from windows store.

[instructions](https://www.windowscentral.com/install-windows-subsystem-linux-windows-10)

Remote WSL extension to VSCode enabled, develop straight to Linux.

## Bash scripting

Bash is an enhancement to shell scripting.
Also AWK, SED. more complex.

[instructions](https://help.ubuntu.com/community/Beginners/BashScripting)

```bash
mkdir
rm
rm -r
cp
cp -r
top
ipconfig
echo
chmod

```

Bash scripting:
Save with .sh extension
start with #!/bin/bash
run with ./file.sh
chmod to execute

## Ubuntu

Open source linux op system. Support for e.g. chrome. Desktop version, server version (used by AWS & Azure). Every 2 years, so 18.04 is april 2018.

### VS Code on Ubuntu (Remote)

In Ubuntu, run this to set up VS Code:
>`code .`

This opens VSCode in the current folder

use the VS Code extension for WSL (Remote - WSL extension) to allow file access from windows.  

This is a full dev environment. Runs commands in Linux environment. Can use WSL or a remote linux environment. This really is a separate instance, completely separate.

When in linux side, to open a file in windows: F1, Remote-WSL: Reopen in Windows.

Extensions run generally in the environment you are targeting, but some run locally.
Some UI themes, snippets run locally so visible in both sides.

Good article on setup [here](https://code.visualstudio.com/docs/remote/troubleshooting#_resolving-git-line-ending-issues-in-containers-resulting-in-many-modified-files)

## Windows Powershell

Windows Powershell is command line access to operating system fuctions. Usefult for task management and configuration management. Based on .NET. More capable than cmd window, allows scripts etc. 

Start from command prompt, type `powershell` into cmd prompt. Or better, start -> powershell, run as admin.

Powershell ISE is a graphical dev environment for PS.

Installed the powershell extension for VSCode.

## ssh (secure shell)

Windows comes with ssh. Alternative to Putty. Use this to connect to a Linux computer. Login with an account on that machine, and get commands to that machine (remote on)

ssh [username]@[hostname] -p [port]

While remote controlling Linux over SSH might be vital, you may not even need SSH. Windows 10 now features a Linux subsystem and a Bash-like command prompt.

This means that you can easily input Linux commands and receive realistic responses. While it might not be ideal for all scenarios, if you need Linux access for college or training purposes, and don’t have SSH access (regardless of app) to a Linux device, this might be ideal.

Of course, this isn’t the only option. If you need to practice Bash commands in Windows, you can always set up a virtual machine. Simply install a Linux distribution into this and (hardware permitting) you have a Linux OS ready to use.

Windows machines often connect with RDP (remote desktop protocol)

### Connecting to a VM with ssh

- Need VM IP address
- username
- password

Most op systems have root as the default user name. 

ssh keys are better than passwords. Set up VM to take ssh keys. Open SSh or Putty to connect.

https://www.digitalocean.com/docs/droplets/how-to/connect-with-ssh/openssh/

need public key and private key.

### Create ssh keys

ssh-keygen utility in Open SSH. Run on client to generate2048 bit RSA key pairs. Default Location is `~/.ssh`, default file name id_rsa for private, id_rsa.pub for public. Default location good for client to find the leys automatically. Optional passphrase to encrypt private key on disk. 
Upload keys to server using `ssh-copy-id`, or pipe contents to `~/.ssh/authorized_keys`, or ssh into server and create manually.

`ssh-copy-id username@203.0.113.0`

### Configure agent forwarding

to setup ssh-add, add to ~/.bashrc

```bash
if [ -z "$(pgrep ssh-agent)" ]; then
   rm -rf /tmp/ssh-*
   eval $(ssh-agent -s) > /dev/null
else
   export SSH_AGENT_PID=$(pgrep ssh-agent)
   export SSH_AUTH_SOCK=$(find /tmp/ssh-* -name agent.*)
fi
```



## curl (client for URLs)

Tool to transfer data to or from a server. Uses many protocols (Http, FTP, Gopher, POP etc).
Has proxy support, authentication, HTTP post, FTP upload.
curl

'wget' is good alternative to curl

Curl generally downloads to stdio

downloads to the same filename in current directory
>curl -O filename 



Examples
Get the main page from Netscape's web-server:  
>`curl http://www.netscape.com/`  

Get the README file the user's home directory at funet's ftp-server:
>curl ftp://ftp.funet.fi/README

Get a web page from a server using port 8000:  

>curl http://www.weirdserver.com:8000/

Get a directory listing of an FTP site:

>curl ftp://cool.haxx.se/

Get the definition of curl from a dictionary:

>curl dict://dict.org/m:curl

Fetch two documents at once:

>curl ftp://cool.haxx.se/ http://www.weirdserver.com:8000/

Get a file off an FTPS server:

>curl ftps://files.are.secure.com/secrets.txt

or use the more appropriate FTPS way to get the same file:

>curl --ftp-ssl ftp://files.are.secure.com/secrets.txt

Get a file from an SSH server using SFTP:

>curl -u username sftp://example.com/etc/issue

Get a file from an SSH server using SCP using a private key (not password-protected) to authenticate:

>curl -u username: --key ~/.ssh/id_rsa scp://example.com/~/file.txt

Get a file from an SSH server using SCP using a private key (password-protected) to authenticate:

>curl -u username: --key ~/.ssh/id_rsa --pass private_key_password
>scp://example.com/~/file.txt

Get the main page from an IPv6 web server:

>curl "http://[2001:1890:1112:1::20]/"

Get a file from an SMB server:

>curl -u "domain\username:passwd" smb://server.example.com/share/file.txt

## Linux commands

### Folder setup

Home folder /home/[user]

installation at /usr/bin

### Sudo

means Superuser-do.
allows you to execute as the superuser.
The uid and gid are set to superuser.
basically put sudo in front of a command to execute it as super user.
Temporary elevation of permissions.

Path listing
>`echo $PATH`

Folder listing
>`ll`

### version info

>`cat /etc/os-release`  
>`uname -or`

## APT Package management

APT comes with ubuntu.
installs, upgrades. command line.

### basic APT package commands

install:  
>`sudo apt install pmap`

remove:
>`sudo apt remove pmap`

Update the Package Index: The APT package index is essentially a database of available packages from the repositories defined in the /etc/apt/sources.list file and in the /etc/apt/sources.list.d directory. To update the local package index with the latest changes made in the repositories, type the following:

>`sudo apt update`

upgrade packages  
>`sudo apt upgrade`

default APT repositories are /etc/apt/sources.list, custom in sources.list.d  

APT installs .deb packages (Debian)
APT cache uses the files to report on local situation.

### installing using APT

Update ubuntu packages:
>`sudo apt update`
>`sudo apt upgrade`

e.g. for Nano editor
update the repositories in the cache:
>`sudo apt update`

install nano
>`sudo apt install nano`

### installing using npm

To see whats installed  
for local
>`npm list`  

for global packages  
>`npm list -g`  

