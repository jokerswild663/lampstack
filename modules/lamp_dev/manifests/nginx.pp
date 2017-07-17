class nginx {
	notify {'nginx':
		name	=> 'nginx_notify',
		message	=> 'nginx class called'
	}
	
	if $osfamily == 'debian' {
                notify {'Debian nginx':}
        }
}
