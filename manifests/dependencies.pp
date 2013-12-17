class zf::dependencies
{
	if $osfamily != 'Debian' {
		fail("Unsupported platform: ${osfamily}/${operatingsystem}")
	}
	require wget
	package {['php5', 'php-pear']: ensure  => present}
}
