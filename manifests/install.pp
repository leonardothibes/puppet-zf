define zf::install($version = $title, $installdir, $zftool)
{
	include zf::params

	file {$zf::params::srcdir:
		ensure => directory,
		owner  => root,
		group  => root,
		mode   => 0755,
	}

	$pkgname = "ZendFramework-${version}.tar.gz"
	wget::fetch {'wget-zf':
		source      => $zf::params::zendurl,
		destination => "$zf::params::srcdir/$pkgname",
	}
}
