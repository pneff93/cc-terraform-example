output "active-API-key" {
  value = module.api-key-rotation.active_key
  sensitive = true
}

output "all-API-keys" {
  value = module.api-key-rotation.all_keys
  sensitive = true
}