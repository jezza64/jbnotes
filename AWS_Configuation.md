<LINK href="jb1.css" rel="stylesheet" type="text/css">

#### [Back to index](index.html)

# AWS Configuration

<LINK href="air_style_sheet.css" rel="stylesheet" type="text/css">

[Back to index](index.html)

- [AWS Configuration](#aws-configuration)
  - [Lightsail](#lightsail)
    - [keys](#keys)
    - [Windows connection to terminal](#windows-connection-to-terminal)
    - [Linux connection to terminal](#linux-connection-to-terminal)
  - [Static web site](#static-web-site)
    - [Route 53](#route-53)
  - [S3 buckets for hosting](#s3-buckets-for-hosting)
  - [Amazon Lightsail](#amazon-lightsail)

## Lightsail

Used for simple virtual machine + disk
Created Ubuntu-1-jb
added static ip

### keys

Created private key
jerAWSKey1
downloaded private key
saved .pem file in root/keys
also saved to windows in development\keys

This private key is not set up with lightsail Ubuntu-jb-1, that's set to use the default key. Can't see how to change it.

Also downloaded default key, and used that in putty.

### Windows connection to terminal

Installed Putty on windows.
On linux use openSSH

Use PuttyGen app to open key, save as .ppk (putty format).

Use putty to open terminal.
Host name is ubuntu@35.179.99.236
set the private key .ppk file in connection/ssh/auth

### Linux connection to terminal

not tried

## Static web site

### Route 53

Create alias records which route from jeremybates.uk and  www.jeremybates.uk to an S3 bucket with HTML file.
.uk domain is $9 per year.

Registered jeremybates.uk for 1 year.
AWS created a hosted zone, e.g. EC2 instance.

## S3 buckets for hosting

Host content on jeremybates.uk, redirect www.jeremybates.uk to jeremybates.uk
Created 2 S3 buckets, jeremybates.uk, www.jeremybates.uk
set permissions to public
Set one to host static web site, and log files to the logs bucket.

buckets are exposed at
http://jeremybates.uk.s3-website.eu-west-2.amazonaws.com/

## Amazon Lightsail

- choose region and zone.
- Ubuntu 18.
- Called ubuntu-1-jb
- Pay $3.50 per month, first month free.
- chose 512 MB RAM, 1 vCPU, 20 GB SSD

https://lightsail.aws.amazon.com/ls/webapp/home/instances
