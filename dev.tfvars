environment = {
  name       = "uat"
  region     = "ap-southeast-1"
  account_id = "117134819170"
  tla        = "song"
}

dynamo = {
  table1    = "OutboundRules"
  hash_key1 = "campaign"
  table2    = "DND"
  hash_key2 = "name"
  table3    = "Global-DND"
  hash_key3 = "phoneNumber"
  table4    = "Schedules"
  hash_key4 = "campaign"
  table5    = "Dispositions"
  hash_key5 = "value"
}

connect = {
  alias = "song-connect"
}
