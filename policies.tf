# #data resource with "aws_iam_policy_document" can be used to get policies available readily.

# data "aws_iam_policy_document" "ec2_readonly" {
#   statement {
#     actions = [
#     "ec2:Describe*"]
#     resources = [
#     "*"]
#   }
# }
# resource "aws_iam_policy" "ec2_readonly" {
#   name   = "ec2_readonly"
#   policy = "${data.aws_iam_policy_document.ec2_readonly.json}"
# }
data "aws_iam_policy" "AWSHealthFullAccess" {
  arn = "arn:aws:iam::aws:policy/AWSHealthFullAccess"
}
resource "aws_iam_policy_attachment" "health-attach" {
  name       = "health-attachment"
  groups     = [aws_iam_group.group.name]
  policy_arn = data.aws_iam_policy.AWSHealthFullAccess.arn
}

resource "aws_iam_policy_attachment" "RDS-attach" {
  name       = "RDS-attachment"
  groups     = [aws_iam_group.group.name]
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_policy" "policy" {
  name        = "AmazonRDSFullAccess"
  description = "My test aws managed policy attach to a group/user"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "rds:*",
                "application-autoscaling:DeleteScalingPolicy",
                "application-autoscaling:DeregisterScalableTarget",
                "application-autoscaling:DescribeScalableTargets",
                "application-autoscaling:DescribeScalingActivities",
                "application-autoscaling:DescribeScalingPolicies",
                "application-autoscaling:PutScalingPolicy",
                "application-autoscaling:RegisterScalableTarget",
                "cloudwatch:DescribeAlarms",
                "cloudwatch:GetMetricStatistics",
                "cloudwatch:PutMetricAlarm",
                "cloudwatch:DeleteAlarms",
                "ec2:DescribeAccountAttributes",
                "ec2:DescribeAvailabilityZones",
                "ec2:DescribeCoipPools",
                "ec2:DescribeInternetGateways",
                "ec2:DescribeLocalGatewayRouteTablePermissions",
                "ec2:DescribeLocalGatewayRouteTables",
                "ec2:DescribeLocalGatewayRouteTableVpcAssociations",
                "ec2:DescribeLocalGateways",
                "ec2:DescribeSecurityGroups",
                "ec2:DescribeSubnets",
                "ec2:DescribeVpcAttribute",
                "ec2:DescribeVpcs",
                "ec2:GetCoipPoolUsage",
                "sns:ListSubscriptions",
                "sns:ListTopics",
                "sns:Publish",
                "logs:DescribeLogStreams",
                "logs:GetLogEvents",
                "outposts:GetOutpostInstanceTypes"
            ],
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Action": "pi:*",
            "Effect": "Allow",
            "Resource": "arn:aws:pi:*:*:metrics/rds/*"
        },
        {
            "Action": "iam:CreateServiceLinkedRole",
            "Effect": "Allow",
            "Resource": "*",
            "Condition": {
                "StringLike": {
                    "iam:AWSServiceName": [
                        "rds.amazonaws.com",
                        "rds.application-autoscaling.amazonaws.com"
                    ]
                }
            }
        }
    ]
}
EOF
}

resource "aws_iam_policy" "IAM_full" {
  name        = "IAM-policy"
  description = "My test policy"

  policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
{
"Effect": "Allow",
"Action": "iam:*",
"Resource": "*"
}
]
}
EOF
}
resource "aws_iam_policy" "DynamoDB_full" {
  name        = "Cloudwatch-policy"
  description = "My test policy"

  policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
{
"Effect": "Allow",
"Action": "dynamodb:*",
"Resource": "*"
}
]
}
EOF
}

resource "aws_iam_policy" "S3_full" {
  name        = "S3-policy"
  description = "My test policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "s3:*",
      "Effect": "Allow",
      "Resource": "*"
}
]
}
EOF
}

resource "aws_iam_policy" "ec2_full" {
  name = "ec2_full"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
            "Action": "ec2:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "elasticloadbalancing:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "cloudwatch:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "autoscaling:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "iam:CreateServiceLinkedRole",
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "iam:AWSServiceName": [
                        "autoscaling.amazonaws.com",
                        "ec2scheduled.amazonaws.com",
                        "elasticloadbalancing.amazonaws.com",
                        "spot.amazonaws.com",
                        "spotfleet.amazonaws.com",
                        "transitgateway.amazonaws.com"
                    ]
                }
            }
        }
    ]

}
EOF
}
