class zf(
  $ensure     = $zf::params::ensure,
  $version    = $zf::params::version,
  $installdir = $zf::params::zenddir,
  $zftool     = $zf::params::zftool,
) inherits zf::params {

	include zf::dependencies
	case $ensure {
		'present': {
			zf::install {$version:
				installdir => $installdir,
				zftool     => $zftool,
			}
		}
		'absent': {
			zf::uninstall {'':}
		}
		default: {
			fail("Unsupported option for \"ensure\" param: ${ensure}")
		}
	}
}
