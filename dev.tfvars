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

deepgram = {
  deepgram_api = "wss://api.deepgram.com/v1/listen"
  deepgram_api_key = "67ca1db57274e784fa1414d0edbe01de6cebfd0f"
  kvs_dg_integrator_log_level = "Debug"
}