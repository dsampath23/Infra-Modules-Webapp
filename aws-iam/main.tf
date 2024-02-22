/*************************************************************
Creates IAM role for ec2 instance profile
*************************************************************/
resource "aws_iam_role" "web_server_role" {
  name = "web-server-role"

  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  }
  EOF
}

resource "aws_iam_role_policy_attachment" "web_server_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3readAccess"  
  role       = aws_iam_role.web_server_role.name
}
