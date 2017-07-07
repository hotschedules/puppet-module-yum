# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: yum
# ---
#
# Yum & Yum Repository Management
#
# === Parameters
# ---
#
# [*s3iaminstaller*]
# - Default - OS Specific
# - Type - string
# - S3 IAM plugin installer
#
# [*repodefaults*]
# - Default
# - Type - hash
#   {
#     enabled         => '1',
#     failovermethod  => 'priority',
#     gpgcheck        => '1',
#     metadata_expire => '300',
#     priority        => '3',
#     timeout         => '10',
#   }
# - Repository default settings
#
# [*versionlocks*]
# - Default - undef
# - Type - hash
# - List of packages to version lock
#
class yum (

  $packages         = [ 'yum-utils' ],
  $amzn_releasever  = 'latest',
  $amzn_guid        = undef,

  $s3iam_enabled    = false,
  $s3iam_version    = '1.0.2-1',
  $s3iam_installfile= "/tmp/yum-plugin-s3-iam-${s3iam_version}.noarch.rpm",

  $cob_enabled      = true,
  $cob_version      = '1.0.0-1',

  $repodefaults   = {
    enabled         => '1',
    failovermethod  => 'priority',
    gpgcheck        => '1',
    metadata_expire => '300',
    priority        => '3',
    timeout         => '10',
  },

) {

  validate_array          ( $packages          )
  validate_hash           ( $repodefaults      )
  validate_string         ( $cob_version       )
  validate_string         ( $s3iam_version     )
  validate_absolute_path  ( $s3iam_installfile )

  # NOTE: hiera_hash does not work as expected in a parameterized class
  #   definition; so we call it here.
  #
  # http://docs.puppetlabs.com/hiera/1/puppet.html#limitations
  # https://tickets.puppetlabs.com/browse/HI-118
  #
  $repos        = hiera_hash('yum::repos', {})
  $versionlocks = hiera_hash('yum::versionlocks', {})

  validate_hash           ( $repos             )
  validate_hash           ( $versionlocks      )

  # NOTE: cannot use module framework due to dependency cycles with stages
  # clabs::module::init { $name: }
  contain "${name}::install"

  class { "${name}::config": require => Class["${name}::install"] }
  contain "${name}::config"

}
