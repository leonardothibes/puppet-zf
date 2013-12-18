define zf::install($version = $title, $installdir, $zftool)
{
	include zf::params

	file {$zf::params::srcdir:
		ensure => directory,
		owner  => root,
		group  => root,
		mode   => 0755,
	}

	$pkgname     = "ZendFramework-${version}.tar.gz"
	$destination = "${zf::params::srcdir}/${pkgname}"

	wget::fetch {'wget-zf':
		source      => $zf::params::zendurl,
		destination => $destination,
		before      => Exec['tar-zf'],
	}

	exec {'tar-zf':
		command => "tar -xzvf ${destination}",
		path    => ['/bin','/usr/bin'],
		cwd     => $zf::params::srcdir,
		onlyif  => [
			"test -f ${destination}",
			"test ! -d ${zf::params::srcdir}/ZendFramework-${version}",
		],
	}
}
