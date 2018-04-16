# == Class: limits::fragment
#
# Places a fragment in $limits_d_dir directory
#
# Paramters
# ---------
#
#  @param list
#   This is expected to be an array with attributes that will configure your security limits.
#   Ex: ['* soft nofile 1024', '* hard nofile 1024']
#
#   This is best represented in hiera.
#
# @param ensure
#   This can be one of ('file', 'present', 'absent').  Defaults to 'file'.
#
#
define limits::fragment (
  Optional[Array[String]]           $list   = undef,
  Enum['file', 'present', 'absent'] $ensure = 'file',
) {

  # this is a defined type so we have to include ::limits to get access to the params
  include ::limits

  # must specify $list
  if $ensure != 'absent' and $list == undef {
    fail('limits::fragment must specify $list.')
  }

  # use the template if a list is provided
  if $list == undef {
    $content = undef
  } else {
    $content = template('limits/limits_fragment.erb')
  }

  file { "${limits::limits_d_dir}/${title}.conf":
    ensure  => $ensure,
    content => $content,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

}
