resource "aws_kinesis_video_stream" "default" {
  name                    = "streams-${var.connect.alias}-connect-contact"
  data_retention_in_hours = 1
  device_name             = "kinesis-video-device-name"
  media_type              = "video/h264"
}