data "aws_iam_policy_document" "policy" {
  statement {
    effect = "Deny"

    principals {
      type = "AWS"

      identifiers = [
        "*",
      ]
    }

    actions = [
      "s3:PutObjectAcl",
    ]

    resources = aws_s3_bucket.bucket.*.arn.bar
  }
}

data "aws_iam_policy_document" "s3_proxy_policy" {
  statement {
    actions = [
      "s3:GetObject",
    ]

    resources = [
      for
      bucket_name
      in
      local.buckets_to_proxy :
      "arn:aws:s3:::${bucket_name}/*"
      if
      substr(bucket_name, 0, 1) == "l"
    ]
  }
}