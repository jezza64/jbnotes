<LINK href="jb1.css" rel="stylesheet" type="text/css">

#### [Back to index](index.html)

# Machine learning in a database

## Aurora

Aurora runs on async write.  
The storage is replicated and shared. The replica in next AZ just needs cache sync.  
Writes to 6 storage instances across the 3 AZ's in the region  
When 4 out of 6 writes done, it's quorate.  

MySQL compatible  
Supports serverless with an HTTP endpoint, or AWS SDK  
Serverless scales easily.  
Can create global database  

## Aurora integrates with ML

- Amazon comprehend
- Amazon Sagemaker
- Aurora MySQL

Use a select and the services run on the data selected.

## direct SQL ML

One endpoint for read/write optimised, one for read only.  
Attach AWS Lambda or Sagemaker or Comprehend
Call directly in SQL, e.g.
> select comment_text, aws_comprehend_detect_sentiment(comment_text, 'english') from comment

## Sagemaker

Sagemaker autopilot: Pass a well prepared dataset and it does the ML
Set up model and publish as an endpoint
Write a function in the database to invoke the end point, passing the features, returning prediction.
Then select, and call the function.

Workshop on amazon aurora looks useful: awsauroralabsmy.com

Easy to add ML to existing applications, just call an endpoint.

aws labs on github is a good resource.
