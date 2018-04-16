# Class: limits
# ===========================
#
class limits(
  Optional[Hash] $fragments = {},
) {

  # setup variables for specific OS releases
  case $::osfamily {

    'RedHat': {

      case $::operatingsystemmajrelease {

        '5': {
          $limits_d_dir = '/etc/security/limits.d'
        }

        '6': {
          $limits_d_dir = '/etc/security/limits.d'
        }

        '7': {
          $limits_d_dir = '/etc/security/limits.d'
        }

        default: {
          fail("This module '${module_name}' does not currently support RedHat '$::operatingsystemmajrelease'")
        }

      }

    }

    default: {

      fail("This module '${module_name}' does not currently support osfamily '$::osfamily'")

    }

  }

  create_resources(limits::fragment, $fragments)

}
