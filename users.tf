#Creating users
resource "aws_iam_user" "newusers" {
  count = length(var.username)
  name  = element(var.username, count.index)
}

resource "aws_iam_user_policy_attachment" "ec2-user-full" {
  count = length(var.username)
  user  = element(aws_iam_user.newusers.*.name, count.index)
  #policy_arn = "${aws_iam_policy.ec2_readonly.arn}"
  policy_arn = aws_iam_policy.ec2_full.arn
}

resource "aws_iam_user_policy_attachment" "S3_user_full" {
  count = length(var.username)
  user  = element(aws_iam_user.newusers.*.name, count.index)
  #policy_arn = "${aws_iam_policy.ec2_readonly.arn}"
  policy_arn = aws_iam_policy.S3_full.arn
}
resource "aws_iam_user_policy_attachment" "IAM_user_full" {
  count      = length(var.username)
  user       = element(aws_iam_user.newusers.*.name, count.index)
  policy_arn = aws_iam_policy.IAM_full.arn
}
