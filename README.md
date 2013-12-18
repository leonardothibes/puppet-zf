puppet-zf
=========

A Puppet module that installs Zend Framework 1.x.x.

## Sample Usage
Install zf and use the provided configuration defaults
```puppet
node default {
	class {'zf':}
}
```
or
```puppet
node default {
	include zf
}
```

Install diferent version
```puppet
node default {
	class {'zf':
		ensure  => install,
		version => '1.11.11',
	}
}
```

Install Zend Tool
```puppet
node default {
	class {'zf':
		ensure => install,
		ztool  => true,
	}
}
```

Uninstall zf
```puppet
node default {
	class {'zf':
		ensure => absent,
	}
}
```

Contact
-------

Principal developer:
	[Leonardo Thibes](http://leonardothibes.com) => [eu@leonardothibes.com](mailto:eu@leonardothibes.com)

Support
-------

Please log tickets and issues at our [Projects site](https://github.com/leonardothibes/puppet-zf/issues)
