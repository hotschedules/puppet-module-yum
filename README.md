# puppet-module-yum

Puppet Plugin for managing Yum and Yum Repositories

## Requirements
---

- Puppet version 3.3 or greater with Hiera support
- Puppet Modules:

| OS Family      | Module |
| :------------- |:-------------: |
| ALL            | [puppetlabs/stdlib](https://forge.puppetlabs.com/puppetlabs/stdlib) |
| ALL            | [clabs/core](https://bitbucket.org/convectionlabs/puppet-module-core)|

## Usage
---

Loading the yum class:

```puppet
include yum
```

## Configuration
---

All configuration settings should be defined using Hiera.

### Repository Defaults

- Set some repo defaults.
- Any attribute supported by the [Puppet Yumrepo Type](http://docs.puppetlabs.com/references/3.stable/type.html#yumrepo) may be used.

```yaml
yum::repodefaults:
    enabled         : '1'
    failovermethod  : 'priority'
    gpgcheck        : '1'
    metadata_expire : '300'
    priority        : '1'
    timeout         : '10'
```

- Define some yum repositories (defaults for a Redhat based Amazon instance show).
- The defaults defined under Repository Defaults will be inherited for all repostitories listed.
- Any attribute supported by the [Puppet Yumrepo Type](http://docs.puppetlabs.com/references/3.stable/type.html#yumrepo) may be used.

```yaml
yum::repos:
    amzn-main:
        descr       : 'amzn-main-Base'
        gpgkey      : 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-amazon-ga'
        mirrorlist  : 'http://repo.us-east-1.amazonaws.com/$releasever/main/mirror.list'
    amzn-main-debuginfo:
        descr       : 'amzn-main-debuginfo'
        enabled     : '0'
        gpgkey      : 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-amazon-ga'
        mirrorlist  : 'http://repo.us-east-1.amazonaws.com/$releasever/main/debuginfo/mirror.list'
    amzn-nosrc:
        descr       : 'amzn-nosrc-Base'
        enabled     : '0'
        gpgcheck    : '0'
        gpgkey      : 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-amazon-ga'
        mirrorlist  : 'http://repo.us-east-1.amazonaws.com/$releasever/nosrc/mirror.list'
    amzn-preview:
        descr       : 'amzn-preview-Base'
        enabled     : '0'
        gpgkey      : 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-amazon-ga'
        mirrorlist  : 'http://repo.us-east-1.amazonaws.com/$releasever/preview/mirror.list'
    amzn-preview-debuginfo:
        descr       : 'amzn-preview-debuginfo'
        enabled     : '0'
        gpgkey      : 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-amazon-ga'
        mirrorlist  : 'http://repo.us-east-1.amazonaws.com/$releasever/preview/debuginfo/mirror.list'
    amzn-updates:
        descr       : 'amzn-updates-Base'
        enabled     : '1'
        gpgkey      : 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-amazon-ga'
        mirrorlist  : 'http://repo.us-east-1.amazonaws.com/$releasever/updates/mirror.list'
    amzn-updates-debuginfo:
        descr       : 'amzn-updates-debuginfo'
        enabled     : '0'
        gpgkey      : 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-amazon-ga'
        mirrorlist  : 'http://repo.us-east-1.amazonaws.com/$releasever/updates/debuginfo/mirror.list'
```

### Package version locking

Package version locking is supported under RedHat.
In the following example, puppet agent and server packages are locked to version 3.5.1.

```yaml
yum::versionlock:
  puppet        : 3.5.1
  puppet-server : 3.5.1
```

## See Also

* [Puppet Yumrepo Type Reference](http://docs.puppetlabs.com/references/3.stable/type.html#yumrepo)
* [Yum s3 Plugin](https://github.com/NumberFour/yum-s3-plugin)
* [Yum s3 IAM Plugin](https://github.com/seporaitis/yum-s3-iam)

