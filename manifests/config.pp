# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: yum
# ---
#
# Yum & Yum Repository Management
#
# A wrapper around the {Puppet Yumrepo Resource}[http://docs.puppetlabs.com/references/3.stable/type.html#yumrepo] for managing yum repositories via Hiera.
#
# - Loads OS specific configuration classes
# - Uses the *yumrepo* resource to create yum repositories
#
class yum::config inherits yum {

  # Most specific configuration
  if defined("::${name}::${::operatingsystem}") {
    contain "${name}::${::operatingsystem}"
    $baserepos = getvar("::${name}::${::operatingsystem}::baserepos")

  # Least specific configuration
  } else {
    contain "${name}::${::osfamily}"
    $baserepos = getvar("::${name}::${::osfamily}::baserepos")
  }

  # Merge base repos with any Hiera repo lists
  $allrepos = clabs_deep_merge($baserepos, $repos)

  # Create repos
  if !empty($allrepos) {
    create_resources('yumrepo', $allrepos, $repodefaults)
  }

}

