class php {
	notify{'php':
		name	=>	'php',
		message	=>	'php called'
	}
	
	if $osfamily == 'debian' {
                notify {'Debian php':}
        }
}
