define zf::install($version = $title, $installdir, $zftool)
{
	# Params
	include zf::params
	Exec {
		path => ['/bin','/usr/bin'],
	}

	$splited     = split($version,'[.]')
	$major       = $splited[0]
	$ext         = $major ? {1 => 'tar.gz', 2 => 'tgz'}
	$pkgname     = "ZendFramework-${version}.${ext}"
	$zendurl     = "https://packages.zendframework.com/releases/ZendFramework-${version}/${pkgname}"
	$destination = "${zf::params::srcdir}/${pkgname}"
	# Params

	# Source directory
	file {$zf::params::srcdir:
		ensure => directory,
		owner  => root,
		group  => root,
		mode   => 0755,
	}
	# Source directory

	# Downloading the framework
	wget::fetch {'wget-zf':
		source      => $zendurl,
		destination => $destination,
		before      => Exec['tar-zf'],
	}
	# Downloading the framework

	# Unpacking the source
	exec {'tar-zf':
		command => "tar -xzf ${destination}",
		cwd     => $zf::params::srcdir,
		onlyif  => [
			"test -f ${destination}",
			"test ! -d ${zf::params::srcdir}/ZendFramework-${version}",
		],
		before  => Exec['copy-zf'],
	}
	# Unpacking the source

	# Installing the framework
	file {$zf::params::zenddir:
		ensure => directory,
		owner  => root,
		group  => root,
		mode   => 0755,
	}
	exec {'copy-zf':
		command => "cp -Rf ${zf::params::srcdir}/ZendFramework-${version} ${zf::params::zenddir}/${version}",
		onlyif  => [
			"test -d ${zf::params::srcdir}/ZendFramework-${version}",
			"test ! -d ${zf::params::zenddir}/${version}",
		],
		require => File[$zf::params::zenddir],
	}
	exec {'chmod-zf':
		command => "chmod -R 755 ${zf::params::zenddir}/${version}",
		require => Exec['copy-zf'],
	}
	file {"${zf::params::zenddir}/current":
		ensure => link,
		target => "${zf::params::zenddir}/${version}",
	}
	# Installing the framework

	# Integrating the framework to the include path of the PHP
	file {"${zf::params::peardir}/Zend":
		ensure => link,
		target => "${zf::params::zenddir}/current/library/Zend",
	}
	if $major == 1 {
		file {"${zf::params::peardir}/ZendX":
			ensure => link,
			target => "${zf::params::zenddir}/current/extras/library/ZendX",
		}
	} else {
		file {"${zf::params::peardir}/ZendX": ensure => absent}
	}
	# Integrating the framework to the include path of the PHP

	# Install Zend Tool
	if $zftool {
		zf::tool::install {$major:}
	} else {
		zf::tool::uninstall {'zftool-uninstall':}
	}
	# Install Zend Tool
}
