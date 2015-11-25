# Class: test::sub
# ===========================
#
# A sub class.
#
class test::sub (

  # Store hashes to simplify variable usage
  $defaults_hsh = $test::defaults,
  $sub_hsh      = $test::sub,

) inherits test {

  $merged_hsh = merge($defaults_hsh, $sub_hsh)

  file { 'test-yaml':
    ensure => 'present',
    path   => '/tmp/test.yaml',
    content => "$merged_hsh",
  }

}

