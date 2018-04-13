# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2
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

  # Merge all `yum::repos` defined at various points in hiera
  $allrepos = clabs_deep_merge({}, $repos)

  # Create repos
  if !empty($allrepos) {
    create_resources('yumrepo', $allrepos, $repodefaults)
  }

  if $versionlocks {
    clabs::template { '/etc/yum/pluginconf.d/versionlock.list': }
  }

}

