# == Define: syslogng::fifo_source
#
# Create a syslog-ng fifo source (named pipe)
#
# === Parameters
#
# [*ensure*]
#  create or remove source, may be present or absent. Default: present
# [*conf_dir*]
#  configurations parent dir. Default: /etc/syslog-ng
#

define syslogng::fifo_source (
  $ensure              = present,
  $conf_dir            = '/etc/syslog-ng',
) {

  validate_re($ensure, [ '^present', '^absent' ])
  validate_absolute_path($conf_dir)

  $ensure_file = $ensure ? {
    present => file,
    default => $ensure
  }

  file { "${conf_dir}/syslog-ng.conf.d/source.d/${title}.conf":
    ensure => $ensure_file,
    content => template('syslogng/syslog-ng.conf.d/source.d/fifo.conf.erb'),
  }

}
