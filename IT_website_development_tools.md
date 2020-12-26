<LINK href="jb1.css" rel="stylesheet" type="text/css">

#### [Back to index](index.html)

# Website tools

- [Website tools](#website-tools)
  - [React](#react)
  - [Node JS](#node-js)
  - [Web frameworks](#web-frameworks)
  - [Package managers](#package-managers)
    - [process](#process)

## React

Gives UI capability to web sites. Can keep state, and react when state changes, e.g. timers. Written in javascript so easily extendible. HTML with javascript. It's a javascript library for simple UI development on webs sites, meaning that the View component can have functions and not have to interact with the controller MVC. Less complex than javascript DOM.

[Overview](https://www.taniarascia.com/getting-started-with-react/)

Can be hosted on AWS.

## Node JS

Open source runtime environment used for development of server side web apps. Written in javascript.

Popular platform and runtime for javascript applications.
Includes npm package manager.

Means not stuck with the stateless model. 2 way comms. State is maintained, client or server can start the communication.

Asynchronous Event driven javascript runtime for building scalable network applications. Many connections handled concurrently. Upon each connection, the callback is fired, and if no work to be done then Node.js sleeps. 

Blocking methods execute synchronously and non-blocking methods execute asynchronously. Node js allows (typically) IO operations to be written asynchronously with a callback, allowing JS not to be blocked from running. Need to handle potential errors from the call.  

Actually it's single threaded: the callback is executed after completing other work. This could be hnadled by creating extra threads, but Node.js doesn't do that.

Has a markdown interpreter.

npm is the installation tool for Node.js. There's a windows version installed with chocolaty.

## Web frameworks

Angular
JS
bootstrap
Node.js - good for server based applications.

## Package managers

Automate the installing, updating, configuring, removing parts of the operating system. 
Packages are in archive files, with descriptions of purpose, version number, checksum, and list of dependencies. When you install, metadata stored in local package management database. Package manager does the extract.

dynamic linking: use shared libraries across multiple bits of software.  

Linux uses binary packages, heavily dependent on package managers.
Mobile phone systems rely on vendors app stores to do it.

Universal package managers, e.g. Lnedo, ProGet.

### process

Used to use make files to resolve dependencies, compile yourself. Now that's not practical.

Now packages collect files to one archive. Precompiled with sensible defaults. Contain metadata with dependencies. Several package formats: .deb (used by ubuntu), .rpm, .tar.xz

Software repositories are centralised, like an app store. Replaces windows way of going to a web page and downloading. Can search a repository.
