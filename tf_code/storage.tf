data "aws_s3_bucket_object" "s3_bucket" {
    bucket = "vikramsamplebucket"
    key = "vikram/tf/object.txt"
}