class mysql
(
	$mysql_notify_message="mysql class has been called",
	$mysql_login_name="root",
	$mysql_password="password",
	$mysql_testdb="test_db",
	$mysql_purge_tries=3
)
 
{
	notify {'mysql_dev':
		message	=>	$mysql_notify_message
	}	
	
	if $osfamily == 'debian' {
		$mysql_version="5.5.54-0ubuntu0.12.04.1"
		$mysql_package_name="mysql-server"
		$mysql_service_name="mysql"
		$mysql_service_state="running"
		$mysql_service_enabled="true"
		$mysql_user="vagrant"
		$mysql_loginfile_mode=0600
		$mysql_loginfile_state='present'
		$mysql_client_path='/usr/bin/mysql'

		notify {'Debian mysql':}
	}

	package {'mysql_package':
		name	=>	$mysql_package_name,
		ensure	=>	$mysql_version
	}

	service {'mysql_server':
		name	=>	$mysql_service_name,
		ensure	=>	$mysql_service_state,
		enable	=>	$mysql_service_enabled
	}

	file {'mysql_login_file':
		path	=>	"/home/$mysql_user/.my.cnf",
		ensure	=>	$mysql_loginfile_state,
		mode	=>	$mysql_loginfile_mode,
		owner	=>	$mysql_user,
		replace	=>	true,
		content	=>	template('lamp_dev/mysql_login.erb')
	}

	exec {'mysql_purge_testdb':
		command	=>	"$mysql_client_path --defaults-file=/home/$mysql_user/.my.cnf -e \"DROP DATABASE $mysql_testdb\"",
		user	=>	$mysql_user,
		tries	=>	$mysql_purge_tries,
		onlyif	=>	"$mysql_client_path --defaults-file=/home/$mysql_user/.my.cnf -e \"USE DATABASE $mysql_testdb\""
	}

	Notify['Debian mysql'] -> Package['mysql_package'] -> Service['mysql_server'] -> File['mysql_login_file'] -> Exec['mysql_purge_testdb']
}
