<LINK href="jb1.css" rel="stylesheet" type="text/css">

#### [Back to index](index.html)

# SAA-C02 AWS Certified Solutions Architect Associate

- [SAA-C02 AWS Certified Solutions Architect Associate](#saa-c02-aws-certified-solutions-architect-associate)
  - [Overview](#overview)
  - [Global Infrastructure](#global-infrastructure)
    - [AZ](#az)
    - [Regions](#regions)
    - [Edge locations](#edge-locations)

## Overview

1. Design resilient Architectures
   - aws global infrastructure
   - Multi tiered architecture VPC
   - Route 53
   - Cloudfront
   - DR
   - Event driven architectures
   - Storage services

2. High performance architectures
   - which services to use in which situations
   - Autoscaling, EC2, beanstalk
   - Storage with high performance
   - Subnets
   - AWS databases
   - Dynamo DB / Aurora / DAX
   - Managing workloads across databases

3. Design secure applications and architectures
   - IAM
   - Cognito
   - Organisations
   - AWS WAF, Shield, Firewall manager
   - logging Cloudtrail
   - Encryption and KMS

4. Design cost optimised architectures
   - Costs of storage services

## Global Infrastructure

### AZ

- AZs are collections of physical data centres close together.  
- Generally have another AZ close (Same city) linked by good connections, isolated with separate power.  
- Lots of services used the link to the closest AZ, e.g. RDS with multi AZ use synchronous replication for updates.  

### Regions

- Often 3, 4, 5 AZ's together, form a region. Min 2.  
- At least 2 AZ's needed to get high availability.
- Select a region closest to your users.  
- Regions help with data laws.
- Use multi region for extra protection e.g. natural disaster, and closer to customers.
- 20 Regions, 61 AZs. Another 12 AZs planned.
- Not all Services in every region.  
- Region e.g. EU (Ireland) = eu-west-1. has 3 AZs eu-west-1a -> 1c
- The AZ identifiers are different for different accounts, so not everyone chooses a.

### Edge locations

- Many more Edge locations than AZs
- Locations for cache to get it close to users.
- Not used for core infrastructure e.g. EC2, RDS, EBS, but are used forby some services e.g. cloudfront and caches.
- Could have region in US, but cloudfront accessed at closest edge location in europe.  
- Data in caches expires  
- Regional edge cache stores hold regional longer term caches.
