# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: yum::config::redhat
# ---
#
# Yum & Yum Repository Management
#
# === Parameters
# ---
#
# [*baserepos*]
# - Default - OS Specific
# - Type - Hash
# - A default (base) list of OS specific Yum software repositories
#
class yum::config::redhat inherits yum {

  # NOTE: $baserepos will not work as a selector based class param.
  #
  #   https://projects.puppetlabs.com/issues/14301
  #
  if ($::operatingsystem == 'Amazon' and $amzn_guid == undef) {
    $baserepos = {

# -- Base ------------------------------------------------------------------ {{{
      'amzn-main'               => {
        descr       => 'amzn-main-Base',
        gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-amazon-ga',
        mirrorlist  => "http://repo.${::ec2_region}.amazonaws.com/$releasever/main/mirror.list",
      },
      'amzn-main-debuginfo'     => {
        descr       => 'amzn-main-debuginfo',
        gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-amazon-ga',
        mirrorlist  => "http://repo.${::ec2_region}.amazonaws.com/$releasever/main/debuginfo/mirror.list",
      },
      'amzn-nosrc'              => {
        descr       => 'amzn-nosrc-Base',
        enabled     => '0',
        gpgcheck    => '0',
        gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-amazon-ga',
        mirrorlist  => "http://repo.${::ec2_region}.amazonaws.com/$releasever/nosrc/mirror.list",
      },
      'amzn-preview'            => {
        descr       => 'amzn-preview-Base',
        enabled     => '0',
        gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-amazon-ga',
        mirrorlist  => "http://repo.${::ec2_region}.amazonaws.com/$releasever/preview/mirror.list",
      },
      'amzn-preview-debuginfo'  => {
        descr       => 'amzn-preview-debuginfo',
        enabled     => '0',
        gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-amazon-ga',
        mirrorlist  => "http://repo.${::ec2_region}.amazonaws.com/$releasever/preview/debuginfo/mirror.list",
      },
      'amzn-updates'            => {
        descr       => 'amzn-updates-Base',
        enabled     => '1',
        gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-amazon-ga',
        mirrorlist  => "http://repo.${::ec2_region}.amazonaws.com/$releasever/updates/mirror.list",
      },
      'amzn-updates-debuginfo'  => {
        descr       => 'amzn-updates-debuginfo',
        gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-amazon-ga',
        mirrorlist  => "http://repo.${::ec2_region}.amazonaws.com/$releasever/updates/debuginfo/mirror.list",
      },
# -------------------------------------------------------------------------- }}}

# -- EPEL ------------------------------------------------------------------ {{{
      'epel'                    => {
        mirrorlist  => "https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=${::architecture}",
        enabled     => '0',
        gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6',
      },
      'epel-debuginfo'          => {
        mirrorlist  => "https://mirrors.fedoraproject.org/metalink?repo=epel-debug-6&arch=${::architecture}",
        enabled     => '0',
        gpgkey      => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6",
      },
      'epel-source'             => {
        mirrorlist  => "https://mirrors.fedoraproject.org/metalink?repo=epel-source-6&arch=${::architecture}",
        enabled     => '0',
        enabled     => '0',
        gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6',
      },
# -------------------------------------------------------------------------- }}}

    }

  } elsif ($::operatingsystem == 'Amazon' and $amzn_guid != undef) {
        $baserepos = {

# -- Base ------------------------------------------------------------------ {{{
      'amzn-main'               => {
        descr       => 'amzn-main-Base',
        gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-amazon-ga',
        mirrorlist  => "http://repo.${::ec2_region}.amazonaws.com/${amzn_releasever}/main/mirror.list",
      },
      'amzn-main-debuginfo'     => {
        descr       => 'amzn-main-debuginfo',
        enabled     => '0',
        gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-amazon-ga',
        baseurl     => "http://packages.${::ec2_region}.amazonaws.com/${amzn_releasever}/main/debuginfo/${amzn_guid}/${::architecture}",
      },
      'amzn-nosrc'              => {
        descr       => 'amzn-nosrc-Base',
        enabled     => '0',
        gpgcheck    => '0',
        gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-amazon-ga',
        baseurl     => "http://packages.${::ec2_region}.amazonaws.com/${amzn_releasever}/nosrc/${amzn_guid}/${::architecture}",
      },
      'amzn-preview'            => {
        descr       => 'amzn-preview-Base',
        enabled     => '0',
        gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-amazon-ga',
        baseurl     => "http://packages.${::ec2_region}.amazonaws.com/${amzn_releasever}/preview/${amzn_guid}/${::architecture}",
      },
      'amzn-preview-debuginfo'  => {
        descr       => 'amzn-preview-debuginfo',
        enabled     => '0',
        gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-amazon-ga',
        baseurl     => "http://packages.${::ec2_region}.amazonaws.com/${amzn_releasever}/preview/debuginfo/${amzn_guid}/${::architecture}",
      },
      'amzn-updates'            => {
        descr       => 'amzn-updates-Base',
        enabled     => '1',
        gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-amazon-ga',
        baseurl     => "http://packages.${::ec2_region}.amazonaws.com/${amzn_releasever}/updates/${amzn_guid}/${::architecture}",
      },
      'amzn-updates-debuginfo'  => {
        descr       => 'amzn-updates-debuginfo',
        enabled     => '0',
        gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-amazon-ga',
        baseurl     => "http://repo.${::ec2_region}.amazonaws.com/$releasever/updates/debuginfo/${amzn_guid}/${::architecture}",
      },
# -------------------------------------------------------------------------- }}}

# -- EPEL ------------------------------------------------------------------ {{{
      'epel'                    => {
        mirrorlist  => "https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=${::architecture}",
        enabled     => '0',
        gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6',
      },
      'epel-debuginfo'          => {
        mirrorlist  => "https://mirrors.fedoraproject.org/metalink?repo=epel-debug-6&arch=${::architecture}",
        enabled     => '0',
        gpgkey      => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6",
      },
      'epel-source'             => {
        mirrorlist    => "https://mirrors.fedoraproject.org/metalink?repo=epel-source-6&arch=${::architecture}",
        enabled       => '0',
        enabled       => '0',
        gpgkey        => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6',
      },
# -------------------------------------------------------------------------- }}}

    }
  } else {

    $baserepos = {

# -- EPEL ------------------------------------------------------------------ {{{
      'epel'                    => {
        mirrorlist  => "https://mirrors.fedoraproject.org/metalink?repo=epel-${::lsbmajdistrelease}&arch=${::architecture}",
        enabled     => '0',
        gpgkey      => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${::lsbmajdistrelease}",
      },
      'epel-debuginfo'          => {
        mirrorlist  => "https://mirrors.fedoraproject.org/metalink?repo=epel-debug-${::lsbmajdistrelease}&arch=${::architecture}",
        enabled     => '0',
        gpgkey      => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${::lsbmajdistrelease}",
      },
      'epel-source'             => {
        mirrorlist    => "https://mirrors.fedoraproject.org/metalink?repo=epel-source-${::lsbmajdistrelease}&arch=${::architecture}",
        enabled       => '0',
        gpgkey        => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${::lsbmajdistrelease}",
      },
# -------------------------------------------------------------------------- }}}

    }

  }

  if $versionlocks {
    clabs::template { '/etc/yum/pluginconf.d/versionlock.list': }
  }

}

