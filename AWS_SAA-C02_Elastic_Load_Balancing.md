<LINK href="jb1.css" rel="stylesheet" type="text/css">

#### [Back to index](index.html)

# Elastic Load Balancing

- [Elastic Load Balancing](#elastic-load-balancing)
  - [Basic setup](#basic-setup)
    - [IAM role setup](#iam-role-setup)
    - [S3 setup](#s3-setup)
  - [Load Balancers](#load-balancers)
    - [ALB Application load balancer](#alb-application-load-balancer)
    - [Network load balancer](#network-load-balancer)
    - [Classic](#classic)
  - [ELB details](#elb-details)
    - [Target group](#target-group)
    - [Path based routing](#path-based-routing)
    - [ELB monitoring](#elb-monitoring)
  - [Auto scaling](#auto-scaling)
    - [Auto scaling group setup](#auto-scaling-group-setup)
    - [Stress environment setup](#stress-environment-setup)
    - [Launch templates](#launch-templates)
    - [ASG Health checks](#asg-health-checks)
    - [ASG termination policies](#asg-termination-policies)
    - [ASG details](#asg-details)
  - [ELB extra details](#elb-extra-details)
    - [Cross zone load balancing](#cross-zone-load-balancing)
    - [ALB listeners](#alb-listeners)
  - [Multi tier web application with SG, ALB](#multi-tier-web-application-with-sg-alb)

## Basic setup

### IAM role setup

![](jbnotes_images/AWS_SAA-C02%20_Elastic_Load_Balancing_2020-11-27-18-09-46.png)

Create a role, give it a policy.
EC2 instance can assume a role. Gives short term permissions.

### S3 setup

- Store files as objects, with tags.
- Public service on the internet.
- S3 Names must be unique
- It's a global service but you need to specify a region for a bucket, and it's part of the namespace.
- Make public or secure with policies

## Load Balancers

- Single end point, lots of targets.  
- High availability and fault tolerance.  
- Health checks to see if instances available.  

- Path based routing: routes based on info in path after ip address, eg. www.jb.com/orders  
- Host based routing: routes based on info in header, e.g. shop.jb.com vs b.com
- An ALB supports both path-based (e.g. /images or /orders) and host-based routing (e.g. example.com).

Set up DNS record in Route 53 to send traffic on a DNS name to the ALB

![](jbnotes_images/AWS_SAA-C02%20_Elastic_Load_Balancing_2020-11-30-16-40-33.png)

ELB scales by adding ELB nodes in your subnets  

ELB security groups need to be reachable, and need to be able to run health checks on targets.  

![](jbnotes_images/AWS_SAA-C02%20_Elastic_Load_Balancing_2020-11-30-16-42-45.png)

### ALB Application load balancer

Level 7, HTTP listeners, request level  
Query string  
Supports path and host based routing.  
IP addresses, Lambda functions, etc  

### Network load balancer

- Level 4. TCP listeners, connection level
- Ultra high performance, very low latency, high number of connections.
- Can have static ip address or ELP

### Classic

Old generation

## ELB details

### Target group

- Register instances in target groups
- Say how many need to be awake
- Target group is the group of instances that the traffic is distributed to. (this can be an auto scaling set)
- Can send traffic to different target groups depending on the path or host in the HTTP headers.
- Can choose to make client sessions round robin / least queue or sticky to a EC2 instance.  

### Path based routing

![](jbnotes_images/AWS_SAA-C02%20_Elastic_Load_Balancing_2020-11-28-18-43-39.png)

### ELB monitoring

- Cloudwatch every 1 minute by default
- Set options in load balancer to store logs to S3.  
- The logs can record the source IP address of the client through the stack, not just e.g. the last layer originating the request.
- Both of these pass on the source IP address so it's in logs.
- Need to use Proxy protocol (layer 4 in NLB) or X-forwarded-For (Layer 7 in ALB) to do this.

![](jbnotes_images/AWS_SAA-C02%20_Elastic_Load_Balancing_2020-11-30-16-14-29.png)

## Auto scaling

- Specify number of instances, automatically scales out and in.
- triggered by events, and responds to scaling actions attached to events
- No cost, just pay EC2 costs
- Auto scaling uses EC2 health checks, ELB or cloudwatch
- Cloudwatch detects metrics, sends requests to autoscaling
- Use with ELB in same region

![](jbnotes_images/AWS_SAA-C02%20_Elastic_Load_Balancing_2020-11-28-18-55-50.png)

### Auto scaling group setup

- Create autoscaling group
- Create launch template (or configuration): defines the AMI, instance type, role, security groups etc.  
- (Cant change launch configuration, just delete and recreate).  
- Attach one or more Target group to ASG. The target group doesn't do much, this is needed by the load balancer.
- Connect the auto scaling group to the load balancer, needs to be same region
- Can combine multiple types of machine in autoscaling group
- Set AZs to participate when create ASG.
- Can span multiple AZs in the same region

Scaling options:

1. keep at initial size
2. use scaling policies to scale up and down
3. rules to increase and decrease group size
4. create scheduled action

![](jbnotes_images/AWS_SAA-C02%20_Elastic_Load_Balancing_2020-11-30-16-58-30.png)

Scaling policies:

- Simple scaling policy: increase or decrease based on single metric in an alarm
- step scaling policy (AWS prefers). Steps vary based on size of alarm breach. Specify an alarm, e.g. average util > 50% for at least 5 mins. Alarm actions to create one instance
- Target tracking: aim for one metric
- base on SQS queue length, custom metric.

Termination policies:

- Default policy (to help distribution as terminate)
- Others

![](jbnotes_images/AWS_SAA-C02%20_Elastic_Load_Balancing_2020-11-30-16-59-42.png)

Features:

- Can dynamically re-balance across AZs

### Stress environment setup

Install epel from amazon-linux-extras to get stress environment

```bash
sudo amazon-linux-extras install epel -y
sudo yum install stress -y
stress -c 8
```

### Launch templates

Set AMI, instance type, key pair, network interfaces.  
Can create from an existing instance.  
Has versions.  
Can combine purchase options: e.g. spot and on demand

### ASG Health checks

- ASG uses EC2 status checks by default
- Can use ELB health checks and custom health checks
- Health checks unhealthy -> terminated
- But when using ASG and ELB, should use ELB health checks and EC2 health checks

![](jbnotes_images/AWS_SAA-C02%20_Elastic_Load_Balancing_2020-11-30-14-44-07.png)

### ASG termination policies

Default policy chooses which instance to terminate (can choose a different policy)

1. AZ with most instances
2. try to align on-demand vs spot
3. any using old versions of templates
4. any oldest launch configurations
5. closest to next billing hour

### ASG details

- Can suspend certain behaviors e.g. termination, replace unhealthy
- cooldown period is wait period before autoscaling rules checked again
- The CloudWatch Alarm Evaluation Period is the number of the most recent data points to evaluate when determining alarm state.
- Warmup period:

## ELB extra details

### Cross zone load balancing

- ELB distributes traffic between zones, using ELB Nodes (you don't see these).
- With cross zone off, each zone gets e.g. 50% of traffic
- With cross zone on, each zone gets traffic relating to the numbers of instances.

![](jbnotes_images/AWS_SAA-C02%20_Elastic_Load_Balancing_2020-11-30-15-17-42.png)

- Cross zone load balancing is always enabled for ALB.
- Cross zone load balancing is optional enabled for NLB.

Sticky sessions: ALB only. uses cookie on client side.

### ALB listeners

![](jbnotes_images/AWS_SAA-C02%20_Elastic_Load_Balancing_2020-11-30-15-29-13.png)

## Multi tier web application with SG, ALB

- Want ALB to listen on 80 to anything
- Want EC2 instances in private subnet
- Best to set up SGs so ALB accepts any traffic on port 80, but only sends to private SG. Instances in private subnet in an SG to only accept traffic from the public SG.
  
- Create a couple of private subnets in different AZs.  
- Add nat gateway with elastic IP address.
- Create route table to allow traffic between subnets, and also outbound traffic to go to net gateway.
- Create ASG with instances in private subnets.

simple secure SG setup:

- create publicALB
  - create inbound rule for Http from anywhere
  - create outbound rule for Http to privateEC2 SG
- create privateEC2  
  - create inbound rule for Http from publicALB
  
Full solution:

![](jbnotes_images/AWS_SAA-C02%20_Elastic_Load_Balancing_2020-11-30-16-06-37.png)

better Security group configuration for this:

![](jbnotes_images/AWS_SAA-C02%20_Elastic_Load_Balancing_2020-11-30-16-08-04.png)

And so on for e.g. database layer.
