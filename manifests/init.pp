class zf(
  $ensure      = $zf::params::ensure,
  $version     = $zf::params::version,
  $installdir  = $zf::params::zenddir,
  $zftool      = $zf::params::zftool,
  $manage_deps = $zf::params::manage_deps,
) inherits zf::params {

  if $manage_deps {
    include zf::dependencies
  }

	case $ensure {
		'present': {
			case $version {
				'1.x.x','1.x','1'         : { $zfversion = get_last_ver(1) }
				'2.x.x','2.x','2','latest': { $zfversion = get_last_ver(2) }
				default                   : { $zfversion = $version }
			}
			zf::install {$zfversion:
				installdir => $installdir,
				zftool     => $zftool,
			}
		}
		'absent': { zf::uninstall {'uninstall':} }
		default : { fail("Unsupported option for \"ensure\" param: ${ensure}") }
	}
}
