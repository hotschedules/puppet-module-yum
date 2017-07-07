# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: yum::install::redhat
# ---
#
# Yum & Yum Repository Management
#
# Installs OS specific packages & plugins
#
class yum::install::redhat inherits yum {

  if $::operatingsystem == 'Amazon' {

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
    }
    elsif $s3iam_enabled == true {

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
}