echo '
	# Root logger
	log4j.rootLogger=INFO, stdout, osgi:*VmLogAppender
	log4j.throwableRenderer=org.apache.log4j.OsgiThrowableRenderer
	# CONSOLE appender not used by default
	log4j.appender.stdout=org.apache.log4j.ConsoleAppender
	log4j.appender.stdout.layout=org.apache.log4j.PatternLayout
	log4j.appender.stdout.layout.ConversionPattern=%d{ABSOLUTE} | %-5.5p | %-16.16t | %-32.32c{1} | %X{bundle.id} - %X{bundle.name} - %X{bundle.version} | %m%n
' > ${FUSE_ARTIFACT}/etc/org.ops4j.pax.logging.cfg

echo '
	JAVA_MIN_MEM=512M
	JAVA_MAX_MEM=512M
	JAVA_PERM_MEM=128M
	JAVA_MAX_PERM_MEM=256M
	if [ -z "$FUSE_KARAF_NAME" ]; then 
		export FUSE_KARAF_NAME="$HOSTNAME"
	fi
	if [ -z "$FUSE_RUNTIME_ID" ]; then 
		export FUSE_RUNTIME_ID="$FUSE_KARAF_NAME"
	fi
	export JAVA_MIN_MEM
	export JAVA_MAX_MEM
	export JAVA_PERM_MEM
	export JAVA_MAX_PERM_MEM
	export KARAF_OPTS="-Dkaraf.name=${FUSE_KARAF_NAME} -Druntime.id=${FUSE_RUNTIME_ID}"
' > ${FUSE_ARTIFACT}/bin/setenv

rm /opt/fuse/config.sh
