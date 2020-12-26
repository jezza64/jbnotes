<LINK href="jb1.css" rel="stylesheet" type="text/css">

#### [Back to index](index.html)

# Migration of SQL Server to Azure

# Azure

Security is big sell
ability to transform
innovation
no database patching
analytics

## Azure migration program

High level Options:

1. Migrate: Iaas.

SQL runs in VMs in Azure. No hardware needed, but you do need to manage the op systems deployed in VM.

2. Modernise: Paas.

uses native services. "Managed Instance". Native SQL in Azure, allows ML. Web services in VMs migrate to web apps in native services. Then don't need to run the VM for the web service. Comes with regional failover.

3. Microservices: Saas.

windowsFully modern functions on the server. Containers, azure services, app services, **functions**. Can use cosmos DB - planteary scale.

Hybrid use program means reduced costs

## Networking

Fixed IP addresses migrate to cloud with "extended networking". Original IP adrress moves to cloud unchanged, safer for old code.
Windows admin centre - Create Azure extended network.

## Server Roles

e.g. Old windows File server move to cloud. Move to Azure file services. Storage migration service helps with all this.

Windows virtual desktop: thin client, full office 365 etc. Like Remote desktop services. Multi session. Easy deployment for e.g. new office, new people.

## SQL Server

Performance, availability, scalability, security.
Familiar tools, e.g. management studio.
Some features only in Azure.
Performanmce monitoring: e.g. CPU monitor, but also query usage. ML gives reccommendations on indexes.
Security check: e.g. logins being used, best practices.

## Migration tools

With 3 teir software (web app,  web server for middle teir, SQL server for data)
use tools for discovery, eg. app service migration assistant.
end up with web app -> azure app service -> azure single sql database
checks features are supported, examine sql workload. Reccommends migration approach.

## Best Practices

cloud adoption framework gives dashboard for practices and progress
