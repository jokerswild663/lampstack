class mysql {
	notify {'mysql_dev':
		name	=>	'mysql_notify',
		message	=>	'mysql called'
	}	
	
	if $osfamily == 'debian' {
		notify {'Debian mysql':}
	}
}
