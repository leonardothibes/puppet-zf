class zf::dependencies
{
	if $osfamily != 'Debian' {
		fail("Unsupported platform: ${osfamily}/${operatingsystem}")
	}
	require wget
    if !defined(Packages['php5'])     { package {'php5'    : ensure  => present} }
    if !defined(Packages['php-pear']) { package {'php-pear': ensure  => present} }
}
