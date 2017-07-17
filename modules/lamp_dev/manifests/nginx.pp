class nginx {
	notify {'nginx':
		name	=> 'nginx_notify',
		message	=> 'nginx class called'
	}
}
