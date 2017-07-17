class lamp_dev {
	notify {"test highlevel":}

	class {"nginx":}
	class {"mysql":}
	class {"php":}
	
	Class['nginx'] -> Class['mysql'] -> Class['php']
}
