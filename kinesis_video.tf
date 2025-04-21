resource "aws_kinesis_video_stream" "default" {
  name                    = "streams-connect-${var.connect.alias}-contact"
  data_retention_in_hours = 1
  device_name             = "kinesis-video-device-name"
  media_type              = "video/h264"
}