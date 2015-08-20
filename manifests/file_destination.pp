# == Define: syslogng::file_destination
#
# Create a default file based syslog-ng destination.
#
# This define is used to create parts of the default non parameterized setup.
#
# === Parameters
#
# [*ensure*]
#  Create or remove a destination, may be present or absent.
#  Default: present
# [*conf_dir*]
#  configuration parent dir.
#  Default: /etc/syslog-ng
# [*type*]
#  Type of destination to create must be file.
#
define syslogng::file_destination (
  $ensure   = present,
  $conf_dir = '/etc/syslog-ng',
  $type     = file,
  # options below this are for compat with other modules
  $permissions     = undef,
  $file_path       = undef,
) {
  validate_re($ensure, [ '^present', '^absent' ])
  validate_absolute_path($conf_dir)

  $ensure_file = $ensure ? {
    present => file,
    default => $ensure
  }

  file { "${conf_dir}/syslog-ng.conf.d/destination.d/${title}.conf":
    ensure => $ensure_file,
    content => template('syslogng/syslog-ng.conf.d/destination.d/file_destination.conf.erb'),
  }
}
