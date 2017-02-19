---
title: Seeding S3 notification messages in SQS queue for files added between a date range
author: Ram Gopinathan
layout: post
date: 2016-09-03T16:35:00+00:00
url: /2016/09/03/seeding-s3-notification-messages-in-sqs-queue-for-files-added-between-a-date-range/
dsq_needs_sync:
  - 1
categories:
  - bash
  - s3
  - sqs

---
<p dir="ltr">
  I recently ran into a scenario at work were we needed to seed an AWS SQS queue with s3 notification messages for files added before the SQS event notification was configured on the bucket. Solution was to write a bash script. Script is pretty straight forward but couple of key things to know before using the script;
</p>

<p dir="ltr">
  There are some variables you need to set to match to your needs. I think you can figure out the intent of the variables from the name itself
</p>

<pre class="brush:text bash">profile={replace} 
s3bucket={replace} 
folder={specify} 
queueprefix={replace} 
</pre>

<p dir="ltr">
  Querying files in S3 for a specific date range you can change the awk expression in the script to meet your needs. Change the expression d[2] == 8 if you want to specify a different month other than August for ex. and d[3] for a different date range. In example below we are querying s3 bucket using AWS cli and piping the output to an AWK expression to print files added between August 26-22
</p>

<pre class="brush:text bash">files=($(aws s3 ls "s3://$s3bucket/$folder" --recursive --profile $profile | awk -F '&lt;' '{split($1, d, /[- ]/)} d[2] == 8 && d[3] &lt;= 26 && d[3] &gt;= 22' | awk '{print $4}' | sort -r -n))</pre>

Hope this helps. You can download the entire script <a href="https://gist.github.com/rprakashg/97c3c4744b73122bc27b648f2ef1bd93" target="_blank">here</a>, it might save others few hours 🙂