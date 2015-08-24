# == Define: syslogng::custom_logpath
#
# === Parameters
#
# [*ensure*]
#  create or remove logpath, may be present or absent. Default: present
# [*conf_dir*]
#  configurations parent dir. Default: /etc/syslog-ng
#
# === Examples
#
# Though this class is usually called through the create_resources api
# on the main syslogng class, you may still invoke it directly like so:
#
#   syslogng::logpath { 'syslog-ng':
#     ensure => present,
#   }
#
define syslogng::custom_logpath (
  $ensure   = present,
  $conf_dir = '/etc/syslog-ng',
  $filter   = undef,
  $source,
  $destination,
) {
  validate_re($ensure, [ '^present', '^absent' ])
  validate_absolute_path($conf_dir)

  $ensure_file = $ensure ? {
    present => file,
    default => $ensure
  }

  file {
    "${conf_dir}/syslog-ng.conf.d/log.d/90_${title}.conf":
      ensure => $ensure_file,
      content => template('syslogng/syslog-ng.conf.d/log.d/custom.conf.erb'),
  }
}
