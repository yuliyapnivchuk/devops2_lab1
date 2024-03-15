Hometask1   (S3-CloudFront-Route53-ACM)

Create your DNS domain (https://nic.ua create in pp.ua zone)
Manually create Hosted zone in AWS Route53 and attach him to your domain
Create TLS certificate for your host in AWS Certificate Manager
Create S3 web site. Configure policy and put simple content
Create AWS CloudFront distribution (with your host as alternative name). Attach your S3 web site to CF distribution.
Create Route53 A-record with your host name and attach it to CF Distribution or S3 bucket end-point if CF doesn’t work.
