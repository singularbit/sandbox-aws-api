{
    "Version": "2008-10-17",
    "Id": "PolicyForCloudFrontPrivateContent",
    "Statement": [
        {
            "Sid": "1",
            "Effect": "Allow",
            "Principal": {
                "AWS": "${cloudfront_oai}"
            },
            "Action": "s3:GetObject",
            "Resource": [
                "${s3_bucket_arn}",
                "${s3_bucket_arn}/*"
            ]
        }
    ]
}