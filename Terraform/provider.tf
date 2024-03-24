provider "proxmox" {
  pm_api_url      = "https://your-proxmox-server:8006/api2/json"
  pm_user         = "root@pam"
  pm_password     = "your-password"
  pm_tls_insecure = true
}
