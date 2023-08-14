locals {
  rndPrefix = substr(random_uuid.rnd.result, 0, 8)
  deploy_bastion = true
  deploy_aaa = true
  deploy_law = true
  link_aaa_law = true
  imperative_dcra = false
  test_mde = false
  adds_1 = "Install-WindowsFeature AD-Domain-Services -IncludeAllSubFeature -IncludeManagementTools"
  dns_2 = "Install-WindowsFeature DNS -IncludeAllSubFeature -IncludeManagementTools"
  mods_3 = "Import-Module -Name ADDSDeployment, DnsServer"
  forest_4 = "Install-ADDSForest -DomainName ${var.domain.fqdn} -DomainNetbiosName ${var.domain.netbios} -DomainMode ${var.domain.mode} -ForestMode ${var.domain.mode} -DatabasePath ${var.domain.database_path} -SysvolPath ${var.domain.sysvol_path} -LogPath ${var.domain.log_path} -NoRebootOnCompletion:$false -Force:$true -SafeModeAdministratorPassword (ConvertTo-SecureString ${var.pw} -AsPlainText -Force)"
  powershell = "${local.adds_1}; ${local.dns_2}; ${local.mods_3}; ${local.forest_4}"
}