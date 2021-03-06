# == Class: icinga2::params
#
# This class contains config options and settings for use elsewhere in the module.
#
# === Parameters
#
# See the inline comments.
#

class icinga2::params {

  ##############################
  # Icinga 2 common parameters
  ##############################

  #This section has parameters that are used by both the client and server subclasses

  ##################
  # Icinga 2 common package parameters
  case $operatingsystem {
    #Red Hat/CentOS systems:
    'RedHat', 'CentOS': {
      #Pick the right package provider:
      $package_provider = 'yum'
    }

    #Debian/Ubuntu systems:
    /^(Debian|Ubuntu)$/: {
      #Pick the right package provider:
      $package_provider = 'apt'
    }

    #Fail if we're on any other OS:
    default: { fail("${operatingsystem} is not supported!") }
  }

  ##############################
  # Icinga 2 server parameters
  ##############################

  #Whether to manage the package repositories
  $manage_repos = 'true'
  $server_db_type = 'pgsql'

  #Database paramters
  $db_name = 'icinga2_data'
  $db_user = 'icinga2'
  $db_password = 'password'
  $db_host = 'localhost'

  ##############################
  # Icinga 2 server package parameters

  #Pick the right package parameters based on the OS:
  case $operatingsystem {
    #Red Hat/CentOS systems:
    'RedHat', 'CentOS': {
      #Icinga 2 server package
      $icinga2_server_package = 'icinga2'
      $icinga2_server_plugin_packages = ["nagios-plugins-nrpe", "nagios-plugins-all", "nagios-plugins-openmanage", "nagios-plugins-check-updates"]
    }

    #Debian/Ubuntu systems:
    /^(Debian|Ubuntu)$/: {
      case $operatingsystemrelease {
        #Ubuntu 12.04 doesn't have nagios-plugins-common or nagios-plugins-contrib packages available...
        '12.04': {
          $icinga2_server_package = 'icinga2'
          $icinga2_server_plugin_packages = ["nagios-plugins", "nagios-plugins-basic", "nagios-plugins-standard", "nagios-snmp-plugins", "nagios-plugins-extra"]
        }
        #...but 14.04 does:
        '14.04': {
          $icinga2_server_package = 'icinga2'
          $icinga2_server_plugin_packages = ["nagios-plugins", "nagios-plugins-basic", "nagios-plugins-common", "nagios-plugins-standard", "nagios-snmp-plugins", "nagios-plugins-extra", "nagios-plugins-contrib"]
        }
    }
    }

    #Fail if we're on any other OS:
    default: { fail("${operatingsystem} is not supported!") }
  }

  ##############################
  # Icinga 2 server config parameters

  case $operatingsystem {
    #Red Hat/CentOS systems:
    'RedHat', 'CentOS': {
      #Settings for /etc/icinga2/:
      $etc_icinga2_owner = 'icinga'
      $etc_icinga2_group = 'icinga'
      $etc_icinga2_mode  = '750'
      #Settings for /etc/icinga2/icinga2.conf:
      $etc_icinga2_icinga2_conf_owner = 'icinga'
      $etc_icinga2_icinga2_conf_group = 'icinga'
      $etc_icinga2_icinga2_conf_mode  = '640'
      #Settings for /etc/icinga2/conf.d/
      $etc_icinga2_confd_owner = 'icinga'
      $etc_icinga2_confd_group = 'icinga'
      $etc_icinga2_confd_mode  = '750'
      #Settings for /etc/icinga2/features-available/:
      $etc_icinga2_features_available_owner = 'icinga'
      $etc_icinga2_features_available_group = 'icinga'
      $etc_icinga2_features_available_mode  = '750'
      #Settings for /etc/icinga2/features-enabled/:
      $etc_icinga2_features_enabled_owner = 'icinga'
      $etc_icinga2_features_enabled_group = 'icinga'
      $etc_icinga2_features_enabled_mode  = '750'
      #Settings for /etc/icinga2/pki/:
      $etc_icinga2_pki_owner = 'icinga'
      $etc_icinga2_pki_group = 'icinga'
      $etc_icinga2_pki_mode  = '750'
      #Settings for /etc/icinga2/scripts/:
      $etc_icinga2_scripts_owner = 'icinga'
      $etc_icinga2_scripts_group = 'icinga'
      $etc_icinga2_scripts_mode  = '750'
      #Settings for /etc/icinga2/zones.d/:
      $etc_icinga2_zonesd_owner = 'icinga'
      $etc_icinga2_zonesd_group = 'icinga'
      $etc_icinga2_zonesd_mode  = '750'
      #Settings for /etc/icinga2/objects/:
      $etc_icinga2_obejcts_owner = 'icinga'
      $etc_icinga2_obejcts_group = 'icinga'
      $etc_icinga2_obejcts_mode  = '750'
      #Settings for subdirectories of /etc/icinga2/objects/:
      $etc_icinga2_obejcts_sub_dir_owner = 'icinga'
      $etc_icinga2_obejcts_sub_dir_group = 'icinga'
      $etc_icinga2_obejcts_sub_dir_mode  = '750'
    }

    #Debian/Ubuntu systems:
    /^(Debian|Ubuntu)$/: {

      case $operatingsystemrelease {
        #Ubuntu 12.04 Precise Pangolin:
        '12.04': {
          #Settings for /etc/icinga2/:
          $etc_icinga2_owner = 'root'
          $etc_icinga2_group = 'root'
          $etc_icinga2_mode  = '755'
          #Settings for /etc/icinga2/icinga2.conf:
          $etc_icinga2_icinga2_conf_owner = 'root'
          $etc_icinga2_icinga2_conf_group = 'root'
          $etc_icinga2_icinga2_conf_mode  = '644'
          #Settings for /etc/icinga2/conf.d/
          $etc_icinga2_confd_owner = 'root'
          $etc_icinga2_confd_group = 'root'
          $etc_icinga2_confd_mode  = '755'
          #Settings for /etc/icinga2/features-available/:
          $etc_icinga2_features_available_owner = 'root'
          $etc_icinga2_features_available_group = 'root'
          $etc_icinga2_features_available_mode  = '755'
          #Settings for /etc/icinga2/features-enabled/:
          $etc_icinga2_features_enabled_owner = 'root'
          $etc_icinga2_features_enabled_group = 'root'
          $etc_icinga2_features_enabled_mode  = '755'
          #Settings for /etc/icinga2/pki/:
          $etc_icinga2_pki_owner = 'root'
          $etc_icinga2_pki_group = 'root'
          $etc_icinga2_pki_mode  = '755'
          #Settings for /etc/icinga2/scripts/:
          $etc_icinga2_scripts_owner = 'root'
          $etc_icinga2_scripts_group = 'root'
          $etc_icinga2_scripts_mode  = '755'
          #Settings for /etc/icinga2/zones.d/:
          $etc_icinga2_zonesd_owner = 'root'
          $etc_icinga2_zonesd_group = 'root'
          $etc_icinga2_zonesd_mode  = '755'
          #Settings for /etc/icinga2/objects/:
          $etc_icinga2_obejcts_owner = 'root'
          $etc_icinga2_obejcts_group = 'root'
          $etc_icinga2_obejcts_mode  = '755'
          #Settings for subdirectories of /etc/icinga2/objects/:
          $etc_icinga2_obejcts_sub_dir_owner = 'root'
          $etc_icinga2_obejcts_sub_dir_group = 'root'
          $etc_icinga2_obejcts_sub_dir_mode  = '755'
        }
        #Ubuntu 14.04 Trusty Tahr:
        '14.04': {
          #Settings for /etc/icinga2/:
          $etc_icinga2_owner = 'root'
          $etc_icinga2_group = 'root'
          $etc_icinga2_mode  = '755'
          #Settings for /etc/icinga2/icinga2.conf:
          $etc_icinga2_icinga2_conf_owner = 'root'
          $etc_icinga2_icinga2_conf_group = 'root'
          $etc_icinga2_icinga2_conf_mode  = '644'
          #Settings for /etc/icinga2/conf.d/
          $etc_icinga2_confd_owner = 'root'
          $etc_icinga2_confd_group = 'root'
          $etc_icinga2_confd_mode  = '755'
          #Settings for /etc/icinga2/features-available:
          $etc_icinga2_features_available_owner = 'root'
          $etc_icinga2_features_available_group = 'root'
          $etc_icinga2_features_available_mode  = '755'
          #Settings for /etc/icinga2/features-enabled:
          $etc_icinga2_features_enabled_owner = 'root'
          $etc_icinga2_features_enabled_group = 'root'
          $etc_icinga2_features_enabled_mode  = '755'
          #Settings for /etc/icinga2/pki/:
          $etc_icinga2_pki_owner = 'root'
          $etc_icinga2_pki_group = 'root'
          $etc_icinga2_pki_mode  = '755'
          #Settings for /etc/icinga2/scripts/:
          $etc_icinga2_scripts_owner = 'root'
          $etc_icinga2_scripts_group = 'root'
          $etc_icinga2_scripts_mode  = '755'
          #Settings for /etc/icinga2/zones.d/:
          $etc_icinga2_zonesd_owner = 'root'
          $etc_icinga2_zonesd_group = 'root'
          $etc_icinga2_zonesd_mode  = '755'
          #Settings for /etc/icinga2/objects/:
          $etc_icinga2_obejcts_owner = 'root'
          $etc_icinga2_obejcts_group = 'root'
          $etc_icinga2_obejcts_mode  = '755'
          #Settings for subdirectories of /etc/icinga2/objects/:
          $etc_icinga2_obejcts_sub_dir_owner = 'root'
          $etc_icinga2_obejcts_sub_dir_group = 'root'
          $etc_icinga2_obejcts_sub_dir_mode  = '755'
        }

      }
    }

    #Fail if we're on any other OS:
    default: { fail("${operatingsystem} is not supported!") }
  }

  ##################
  # Icinga 2 server service settings

  case $operatingsystem {
    #Icinga 2 server daemon names for Red Had/CentOS systems:
    'RedHat', 'CentOS': {
      $icinga2_server_service_name = 'icinga2'
    }

    #Icinga 2 server daemon names for Debian/Ubuntu systems:
    /^(Debian|Ubuntu)$/: {
      $icinga2_server_service_name = 'icinga2'
    }

    #Fail if we're on any other OS:
    default: { fail("${operatingsystem} is not supported!") }
  }

  ##############################
  # Icinga 2 client parameters
  ##############################

  ##################
  # Icinga 2 client settings
  $nrpe_listen_port        = '5666'
  $nrpe_log_facility       = 'daemon'
  $nrpe_debug_level        = '0'
  #in seconds:
  $nrpe_command_timeout    = '60'
  #in seconds:
  $nrpe_connection_timeout = '300'
  #Note: because we use .join in the nrpe.cfg.erb template, this value *must* be an array
  $nrpe_allowed_hosts      = ['127.0.0.1',]

  case $operatingsystem {
    #File and template variable names for Red Had/CentOS systems:
    'RedHat', 'CentOS': {
      $nrpe_config_basedir = "/etc/nagios"
      $nrpe_plugin_liddir  = "/usr/lib64/nagios/plugins"
      $nrpe_pid_file_path  = "/var/run/nrpe/nrpe.pid"
      $nrpe_user           = "nrpe"
      $nrpe_group          = "nrpe"
    }
    #File and template variable names for Debian/Ubuntu systems:
    /^(Debian|Ubuntu)$/: {
      $nrpe_config_basedir  = "/etc/nagios"
      $nrpe_plugin_liddir   = "/usr/lib/nagios/plugins"
      $nrpe_pid_file_path   = "/var/run/nagios/nrpe.pid"
      $nrpe_user            = "nagios"
      $nrpe_group           = "nagios"
    }
    #Fail if we're on any other OS:
    default: { fail("${operatingsystem} is not supported!") }
  }

  ##################
  # Icinga 2 client package parameters
  case $operatingsystem {
    #Red Hat/CentOS systems:
    'RedHat', 'CentOS': {
      #Pick the right list of client packages:
      $icinga2_client_packages = ["nrpe", "nagios-plugins-nrpe", "nagios-plugins-all", "nagios-plugins-openmanage", "nagios-plugins-check-updates"]
    }

    #Debian/Ubuntu systems:
    /^(Debian|Ubuntu)$/: {
      case $operatingsystemrelease {
        #Ubuntu 12.04 doesn't have nagios-plugins-common or nagios-plugins-contrib packages available...
        '12.04': {
          $icinga2_client_packages = ["nagios-nrpe-server", "nagios-plugins", "nagios-plugins-basic", "nagios-plugins-standard", "nagios-snmp-plugins", "nagios-plugins-extra"]
        }
        #...but 14.04 does:
        '14.04': {
          $icinga2_client_packages = ["nagios-nrpe-server", "nagios-plugins", "nagios-plugins-basic", "nagios-plugins-common", "nagios-plugins-standard", "nagios-snmp-plugins", "nagios-plugins-extra", "nagios-plugins-contrib"]
        }
      }
    }

    #Fail if we're on any other OS:
    default: { fail("${operatingsystem} is not supported!") }
  }

  ##################
  # Icinga 2 client service parameters
  case $operatingsystem {
    #Daemon names for Red Had/CentOS systems:
    'RedHat', 'CentOS': {
      $nrpe_daemon_name = 'nrpe'
    }

    #Daemon names for Debian/Ubuntu systems:
    /^(Debian|Ubuntu)$/: {
      $nrpe_daemon_name     = 'nagios-nrpe-server'
    }

    #Fail if we're on any other OS:
    default: { fail("${operatingsystem} is not supported!") }
  }

}