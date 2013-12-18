define zf::uninstall
{
	# Removing Zend Tool
	zf::tool::uninstall{'zftool':}

	# Removing Zend links of include path
	file {["${zf::params::peardir}/Zend", "${zf::params::peardir}/ZendX"]: ensure => absent}

	# Removing the framework
	exec {"rm -Rf ${zf::params::zenddir}": path => '/bin'}

	# Removing the framework source
	exec {"rm -Rf ${zf::params::srcdir}/ZendFramework-*": path => '/bin'}
}
