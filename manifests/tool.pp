class zf::tool
{
	define install($major = $title)
	{
		if $major == 1 {
			file {"$zf::params::toolbin":
				ensure => link,
				target => "${zf::params::zenddir}/current/bin/zf.sh",
			}
		} else {
			wget::fetch {'wget-zf2':
				source      => 'https://packages.zendframework.com/zftool.phar',
				destination => '/usr/bin/zf',
				before      => Exec['chmod-zftool'],
			}   
			exec {'chmod-zftool':
				command => 'chmod 755 /usr/bin/zf',
				path    => '/bin',
			}
		}
	}

	define uninstall()
	{
		file {"$zf::params::toolbin": ensure => absent}
	}
}
