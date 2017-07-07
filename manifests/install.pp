# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: yum::install
# ---
#
# Yum & Yum Repository Management
#
# - Installs OS specific packages & related Yum plugins
#
class yum::install inherits yum {

  # Base packages
  clabs::install { $packages: }

  # Most specific installation
  if defined("::${name}::${::operatingsystem}") {
    contain "${name}::${::operatingsystem}"

  # Least specific installation
  } elsif defined("${name}::${::osfamily}") {
    contain "${name}::${::osfamily}"
  }

}

