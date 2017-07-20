class lamp_dev {
	notify {"test highlevel":}

	## repo update
	if $osfamily == 'debian' {
		exec {'apt-update':
                        command =>      '/usr/bin/apt-get update',
                        path    =>      '/usr/bin',
                }
	}
	
	class {"nginx":}
	class {"mysql":}
	class {"php":}
	
	Exec['apt-update'] -> Class['nginx'] -> Class['mysql'] -> Class['php']
}
