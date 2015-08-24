# == Define: syslogng::network_destination
#
# Create a syslog-ng network destination
#
# === Parameters
#
# [*ensure*]
#  create or remove source, may be present or absent. Default: present
# [*conf_dir*]
#  configurations parent dir. Default: /etc/syslog-ng
#

define syslogng::network_destination (
  $ensure              = present,
  $conf_dir            = '/etc/syslog-ng',
  $host                = '0.0.0.0',
  $tcp_port            = undef,
) {
  validate_re($ensure, [ '^present', '^absent' ])
  validate_absolute_path($conf_dir)

  $ensure_file = $ensure ? {
    present => file,
    default => $ensure
  }

  file { "${conf_dir}/syslog-ng.conf.d/destination.d/${title}.conf":
    ensure => $ensure_file,
    content => template('syslogng/syslog-ng.conf.d/destination.d/network.conf.erb'),
  }
}
