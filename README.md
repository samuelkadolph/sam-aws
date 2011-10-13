# sam-aws

sam-aws is a framework for interacting with Amazon Web Services.

## Description

sam-aws is the base gem for dealing with Amazon Web Services used by sam-ebs, sam-ec2, sam-rds and others. Its main purpose
is to provide common functionality for dealing with AWS including: making requests, authenticating, defining response
structures and parsing responses.

## Installing

### Recommended

```
gem install sam-aws
```

### Edge

```
git clone https://github.com/samuelkadolph/sam-aws
cd sam-aws && rake install
```

## Project

The sam-aws project consists of the following gems (along with progress):

<div id="languages">
  <table width="700px">
    <tr>
      <td width="100"><a href="/samuelkadolph/sam-aws">sam-aws</a></td>
      <td><a href="/samuelkadolph/sam-aws" class="bar" style="width: 40%">40%</a></td>
    </tr>
    <tr>
      <td width="100"><a href="/samuelkadolph/sam-aws/tree/master/aws-aws-cli">sam-aws-cli</a></td>
      <td><a href="/samuelkadolph/sam-aws/tree/master/aws-aws-cli" class="bar" style="width: 100%">100%</a></td>
    </tr>
    <tr>
      <td width="100"><a href="/samuelkadolph/sam-aws/tree/master/aws-aws-cli-base">sam-aws-cli-base</a></td>
      <td><a href="/samuelkadolph/sam-aws/tree/master/aws-aws-cli-base" class="bar" style="width: 100%">100%</a></td>
    </tr>
    <tr>
      <td width="100"><a href="/samuelkadolph/sam-aws/tree/master/aws-ebs">sam-ebs</a></td>
      <td><a href="/samuelkadolph/sam-aws/tree/master/aws-ebs" class="bar" style="width: 10%">10%</a></td>
    </tr>
    <tr>
      <td width="100"><a href="/samuelkadolph/sam-aws/tree/master/aws-ebs-cli">sam-ebs-cli</a></td>
      <td><a href="/samuelkadolph/sam-aws/tree/master/aws-ebs-cli" class="bar" style="width: 10%">10%</a></td>
    </tr>
    <tr>
      <td width="100"><a href="/samuelkadolph/sam-aws/tree/master/aws-ec2">sam-ec2</a></td>
      <td><a href="/samuelkadolph/sam-aws/tree/master/aws-ec2" class="bar" style="width: 0%">0%</a></td>
    </tr>
    <tr>
      <td width="100"><a href="/samuelkadolph/sam-aws/tree/master/aws-ec2-cli">sam-ec2-cli</a></td>
      <td><a href="/samuelkadolph/sam-aws/tree/master/aws-ec2-cli" class="bar" style="width: 0%">0%</a></td>
    </tr>
    <tr>
      <td width="100"><a href="/samuelkadolph/sam-aws/tree/master/aws-elasticache">sam-elasticache</a></td>
      <td><a href="/samuelkadolph/sam-aws/tree/master/aws-elasticache" class="bar" style="width: 90%">90%</a></td>
    </tr>
    <tr>
      <td width="100"><a href="/samuelkadolph/sam-aws/tree/master/aws-elasticache-cli">sam-elasticache-cli</a></td>
      <td><a href="/samuelkadolph/sam-aws/tree/master/aws-elasticache-cli" class="bar" style="width: 100%">100%</a></td>
    </tr>
    <tr>
      <td width="100"><a href="/samuelkadolph/sam-aws/tree/master/aws-elb">sam-elb</a></td>
      <td><a href="/samuelkadolph/sam-aws/tree/master/aws-elb" class="bar" style="width: 0%">0%</a></td>
    </tr>
    <tr>
      <td width="100"><a href="/samuelkadolph/sam-aws/tree/master/aws-elb-cli">sam-elb-cli</a></td>
      <td><a href="/samuelkadolph/sam-aws/tree/master/aws-elb-cli" class="bar" style="width: 0%">0%</a></td>
    </tr>
    <tr>
      <td width="100"><a href="/samuelkadolph/sam-aws/tree/master/aws-r53">sam-r53</a></td>
      <td><a href="/samuelkadolph/sam-aws/tree/master/aws-r53" class="bar" style="width: 20%">20%</a></td>
    </tr>
    <tr>
      <td width="100"><a href="/samuelkadolph/sam-aws/tree/master/aws-r53-cli">sam-r53-cli</a></td>
      <td><a href="/samuelkadolph/sam-aws/tree/master/aws-r53-cli" class="bar" style="width: 20%">20%</a></td>
    </tr>
    <tr>
      <td width="100"><a href="/samuelkadolph/sam-aws/tree/master/aws-rds">sam-rds</a></td>
      <td><a href="/samuelkadolph/sam-aws/tree/master/aws-rds" class="bar" style="width: 100%">100%</a></td>
    </tr>
    <tr>
      <td width="100"><a href="/samuelkadolph/sam-aws/tree/master/aws-rds-cli">sam-rds-cli</a></td>
      <td><a href="/samuelkadolph/sam-aws/tree/master/aws-rds-cli" class="bar" style="width: 5%">5%</a></td>
    </tr>
    <tr>
      <td width="100"><a href="/samuelkadolph/sam-aws/tree/master/aws-s3">sam-s3</a></td>
      <td><a href="/samuelkadolph/sam-aws/tree/master/aws-s3" class="bar" style="width: 0%">0%</a></td>
    </tr>
    <tr>
      <td width="100"><a href="/samuelkadolph/sam-aws/tree/master/aws-s3-cli">sam-s3-cli</a></td>
      <td><a href="/samuelkadolph/sam-aws/tree/master/aws-s3-cli" class="bar" style="width: 0%">0%</a></td>
    </tr>
    <tr>
      <td width="100"><a href="/samuelkadolph/sam-aws/tree/master/aws-ses">sam-ses</a></td>
      <td><a href="/samuelkadolph/sam-aws/tree/master/aws-ses" class="bar" style="width: 100%">100%</a></td>
    </tr>
    <tr>
      <td width="100"><a href="/samuelkadolph/sam-aws/tree/master/aws-ses-cli">sam-ses-cli</a></td>
      <td><a href="/samuelkadolph/sam-aws/tree/master/aws-ses-cli" class="bar" style="width: 100%">100%</a></td>
    </tr>
  </table>
</div>

## Developers

### Contributing

See [/wiki/Contributing](/samuelkadolph/sam-aws/wiki/Contributing).
