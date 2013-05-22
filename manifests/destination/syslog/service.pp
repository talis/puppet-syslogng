# == Define: syslogng::destination::syslog::service
#
#
define syslogng::destination::syslog::service (
  $ensure   = present,
  $conf_dir = '/etc/syslog-ng',
  $priority = 00,
  $destination = undef,
  $service = undef,
) {
  validate_re($ensure, ['^present$', '^absent$'])

  $ensure_file = $ensure ? {
    present => file,
    default => $ensure,
  }

  $service_name = $service ? {
    undef   => $title,
    default => $service,
  }

  file { "${conf_dir}/syslog-ng.conf.d/log.d/${priority}_syslog_${title}.conf":
    ensure  => $ensure_file,
    content => template('syslogng/syslog-ng.conf.d/log.d/syslog.conf.erb'),
  }

}

