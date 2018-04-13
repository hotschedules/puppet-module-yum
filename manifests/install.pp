# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2
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

  clabs::template { '/etc/yum.conf': }

  if $cob_enabled == true {

    $cob_installfile  = "/tmp/yum-plugin-cob-${cob_version}.amzn1.noarch.rpm"
    validate_absolute_path  ( $cob_installfile )
    clabs::config {
      [ $cob_installfile ]:
    }
    package { 'yum-plugin-cob':
      provider => "rpm",
      ensure   => installed,
      require  => Clabs::Config[$cob_installfile],
      source   => $cob_installfile;
    }
    package { 'yum-plugin-s3-iam':
      provider => "rpm",
      ensure   => absent,
    }
  } elsif $s3iam_enabled == true {

    validate_absolute_path  ( $s3iam_installfile )

    clabs::config {
      [ $s3iam_installfile ]:
    }
    package { 'yum-plugin-s3-iam':
      provider => "rpm",
      ensure   => installed,
      require  => Clabs::Config[$s3iam_installfile],
      source   => $s3iam_installfile;
    }
    package { 'yum-plugin-cob':
      provider => "rpm",
      ensure   => absent,
    }
  }
  if $versionlocks {
    clabs::install { 'yum-plugin-versionlock': }
  }
}
