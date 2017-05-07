+++
date = "2017-05-06T17:46:40-07:00"
title = "Seeding SQS Queue with S3 notifications"
draft = false

+++


I recently ran into a scenario at work were we needed to seed an AWS SQS queue with s3 notification messages for files added before the SQS event notification was configured on the bucket. Solution was to write a bash script. Script is pretty straight forward but couple of key things to know before using the script
There are some variables you need to set to match to your needs. I think you can figure out the intent of the variables from the name itself

``` 
s3bucket={replace} 
folder={specify} 
queueprefix={replace} 
```

Querying files in S3 for a specific date range you can change the awk expression in the script to meet your needs. Change the expression d[2] == 8 if you want to specify a different month other than August for ex. and d[3] for a different date range. In example below we are querying s3 bucket using AWS cli and piping the output to an AWK expression to print files added between August 26-22

```
files=($(aws s3 ls "s3://$s3bucket/$folder" --recursive --profile $profile | awk -F '<' '{split($1, d, /[- ]/)} d[2] == 8 && d[3] <= 26 && d[3] >= 22' | awk '{print $4}' | sort -r -n))
```

Hope this helps. You can download the entire script [here](https://gist.github.com/rprakashg/97c3c4744b73122bc27b648f2ef1bd93), it might save others few hours 🙂