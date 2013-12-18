class zf::tool
{
	define install()
	{
		file {"$zf::params::toolbin":
			ensure => link,
			target => "${zf::params::zenddir}/current/bin/zf.sh",
		}
	}

	define uninstall()
	{
		file {"$zf::params::toolbin":
			ensure => absent,
		}
	}
}
