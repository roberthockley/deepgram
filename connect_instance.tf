resource "aws_connect_instance" "song" {
  identity_management_type         = "CONNECT_MANAGED"
  inbound_calls_enabled            = true
  instance_alias                   = var.connect.alias
  outbound_calls_enabled           = true
  contact_lens_enabled             = false
  contact_flow_logs_enabled        = true
  auto_resolve_best_voices_enabled = true

}

resource "aws_connect_instance_storage_config" "transcripts" {
  instance_id   = aws_connect_instance.song.id
  resource_type = "CHAT_TRANSCRIPTS"

  storage_config {
    s3_config {
      bucket_name   = aws_s3_bucket.transcripts.id
      bucket_prefix = "transcripts"
    }
    storage_type = "S3"
  }
}

resource "aws_connect_instance_storage_config" "recordings" {
  depends_on = [ aws_s3_bucket.transcripts ] 
  instance_id   = aws_connect_instance.song.id
  resource_type = "CALL_RECORDINGS"

  storage_config {
    s3_config {
      bucket_name   = aws_s3_bucket.transcripts.id
      bucket_prefix = "recordings"
    }
    storage_type = "S3"
  }
}

resource "aws_connect_instance_storage_config" "reports" {
  instance_id   = aws_connect_instance.song.id
  resource_type = "SCHEDULED_REPORTS"

  storage_config {
    s3_config {
      bucket_name   = aws_s3_bucket.transcripts.id
      bucket_prefix = "reports"
    }
    storage_type = "S3"
  }
}


resource "aws_connect_instance_storage_config" "attachments" {
  instance_id   = aws_connect_instance.song.id
  resource_type = "ATTACHMENTS"

  storage_config {
    s3_config {
      bucket_name   = aws_s3_bucket.transcripts.id
      bucket_prefix = "attachments"
    }
    storage_type = "S3"
  }
}

resource "aws_connect_instance_storage_config" "screen" {
  instance_id   = aws_connect_instance.song.id
  resource_type = "SCREEN_RECORDINGS"

  storage_config {
    s3_config {
      bucket_name   = aws_s3_bucket.transcripts.id
      bucket_prefix = "screen_recordings"
    }
    storage_type = "S3"
  }
}

resource "aws_connect_instance_storage_config" "evaluations" {
  instance_id   = aws_connect_instance.song.id
  resource_type = "CONTACT_EVALUATIONS"

  storage_config {
    s3_config {
      bucket_name   = aws_s3_bucket.transcripts.id
      bucket_prefix = "contact_evaluations"
    }
    storage_type = "S3"
  }
}

resource "aws_connect_instance_storage_config" "kvs" {
  instance_id   = aws_connect_instance.song.id
  resource_type = "MEDIA_STREAMS"

  storage_config {
    kinesis_video_stream_config {
      prefix                 = "${var.connect.alias}-"
      retention_period_hours = 3

      encryption_config {
        encryption_type = "KMS"
        key_id          = data.aws_kms_key.kvs.arn
      }
    }
    storage_type = "KINESIS_VIDEO_STREAM"
  }
}

#resource "aws_connect_contact_flow" "wait" {
#  instance_id  = aws_connect_instance.song.id
#  name         = "Sample Deepgram flow"
#  description  = "Sample Deepgram flow"
#  type         = "CONTACT_FLOW"
#  filename     = "sample_flow.json"
#} 