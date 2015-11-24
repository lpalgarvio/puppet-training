# Class: test
# ===========================
#
# Initializes the module, loading the necessary dependencies and classes.
#
#
class test (

  # Hashes
  $defaults = $test::params::defaults,
  $sub      = $sub::params::sub,

) inherits test::params {

  # Include dependencies
  include stdlib

  # Autoload module classes
  anchor { 'test::begin': } ->
    # Load sub class
    class { '::test::sub': } ->
  anchor { 'test::end': }

}

