# = Private class: kibana3::config
#
# Author: Alejandro Figueroa
class kibana3::config (
  $config_default_route   = $::kibana3::params::config_default_route,
  $config_es_port         = $::kibana3::params::config_es_port,
  $config_es_protocol     = $::kibana3::params::config_es_protocol,
  $config_es_server       = $::kibana3::params::config_es_server,
  $config_kibana_index    = $::kibana3::params::config_kibana_index,
  $config_panel_names     = $::kibana3::params::config_panel_names,
) {

  include kibana3::params

  if $::kibana3::manage_ws {
    file {
      "${::kibana3::k3_install_folder}/src/config.js":
      ensure  => present,
      content => template('kibana3/config.js.erb'),
      owner   => $::kibana3::install::_ws_user,
      notify  => Class['::Apache::Service'],
    }
  } else {
    file {
      "${::kibana3::k3_install_folder}/src/config.js":
      ensure  => present,
      content => template('kibana3/config.js.erb'),
      owner   => $::kibana3::install::_ws_user,
    }
  }
}
