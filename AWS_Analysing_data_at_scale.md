<LINK href="jb1.css" rel="stylesheet" type="text/css">

#### [Back to index](index.html)

# AWS Analysing data at scale

- [AWS Analysing data at scale](#aws-analysing-data-at-scale)
  - [Extraction / enrichment](#extraction--enrichment)
  - [Typical problems](#typical-problems)
  - [Solutions](#solutions)
  - [Conclusion](#conclusion)

## Extraction / enrichment

![](jbnotes_images/AWS_Analysing_data_at_scale_2020-12-04-14-08-53.png)

Lots of amazon services to extract data from sources
Output as JSON file
Store in Dynamo DB (can cope with large single items 400Kb)
Kenesis data firehose -> data lake

## Typical problems

![](jbnotes_images/AWS_Analysing_data_at_scale_2020-12-04-14-11-48.png)

![](jbnotes_images/AWS_Analysing_data_at_scale_2020-12-04-14-14-21.png)

![](jbnotes_images/AWS_Analysing_data_at_scale_2020-12-04-14-16-26.png)

## Solutions

Host in Lambda, write to EFS.

Simple solution:

![](jbnotes_images/AWS_Analysing_data_at_scale_2020-12-04-14-17-35.png)

better: Host in EFS

![](jbnotes_images/AWS_Analysing_data_at_scale_2020-12-04-14-18-01.png)

For Lambda examples look at aws.amazon.com/blogs/compute/pay-as-you...

![](jbnotes_images/AWS_Analysing_data_at_scale_2020-12-04-14-27-28.png)

![](jbnotes_images/AWS_Analysing_data_at_scale_2020-12-04-14-27-46.png)

![](jbnotes_images/AWS_Analysing_data_at_scale_2020-12-04-14-29-06.png)

![](jbnotes_images/AWS_Analysing_data_at_scale_2020-12-04-14-30-38.png)

![](jbnotes_images/AWS_Analysing_data_at_scale_2020-12-04-14-31-48.png)

Look at "Postman" software to run and see results
Look at "Papermill" software: run notebooks in batch execution

![](jbnotes_images/AWS_Analysing_data_at_scale_2020-12-04-14-33-51.png)

![](jbnotes_images/AWS_Analysing_data_at_scale_2020-12-04-14-34-40.png)

![](jbnotes_images/AWS_Analysing_data_at_scale_2020-12-04-14-35-24.png)

## Conclusion

![](jbnotes_images/AWS_Analysing_data_at_scale_2020-12-04-14-36-58.png)
