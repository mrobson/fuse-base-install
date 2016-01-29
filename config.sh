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
# Root logger
log4j.rootLogger=INFO, stdout, osgi:*
log4j.throwableRenderer=org.apache.log4j.OsgiThrowableRenderer

# CONSOLE appender not used by default
log4j.appender.stdout=org.apache.log4j.ConsoleAppender
log4j.appender.stdout.layout=org.apache.log4j.PatternLayout
log4j.appender.stdout.layout.replacement=\\\\n  |\u0020
log4j.appender.stdout.layout.ConversionPattern=%d{ISO8601} | %-5.5p | %-16.16t | %-32.32c{1} | %X{bundle.id} - %X{bundle.name} - %X{bundle.version} | %m%n
# use this for source code lines enabled in the logs (beware it impacts performance)
# To avoid flooding the log when using DEBUG level on an ssh connection and doing log:tail
#log4j.appender.stdout.layout.ConversionPattern=%d{ISO8601} | %-5.5p | %-16.16t | %-32.32c{1} | %-32.32C %4L | %X{bundle.id} - %X{bundle.name} - %X{bundle.version} | %m%n

log4j.logger.org.apache.sshd.server.channel.ChannelSession = INFO

# tone down the ZooKeeper logging
log4j.logger.org.apache.zookeeper.ClientCnxn = ERROR
log4j.logger.org.apache.zookeeper.ClientCnxn$SendThread = ERROR
log4j.logger.org.apache.zookeeper.server.NIOServerCnxnFactory = ERROR
log4j.logger.org.apache.zookeeper.server.NIOServerCnxn  = ERROR
log4j.logger.org.apache.zookeeper.server.ZooKeeperServer = ERROR
log4j.logger.org.apache.zookeeper.server.PrepRequestProcessor = WARN
log4j.logger.org.apache.zookeeper.client.ZooKeeperSaslClient = WARN

# tone down httpclient logging
log4j.logger.httpclient.wire = WARN
log4j.logger.org.apache.commons.httpclient = WARN
' > ${FUSE_ARTIFACT}/fabric/import/fabric/profiles/karaf.profile/org.ops4j.pax.logging.properties

echo '
JAVA_MIN_MEM=512M
JAVA_MAX_MEM=512M
JAVA_PERM_MEM=128M
JAVA_MAX_PERM_MEM=256M
if [ -z "$FUSE_KARAF_NAME" ]; then 
	export FUSE_KARAF_NAME="$FABRIC_ENSEMBLE_CONTAINER_NAME"
fi
if [ -z "$FUSE_RUNTIME_ID" ]; then 
	export FUSE_RUNTIME_ID="$FUSE_KARAF_NAME"
fi
export JAVA_MIN_MEM
export JAVA_MAX_MEM
export JAVA_PERM_MEM
export JAVA_MAX_PERM_MEM
export KARAF_OPTS="-Dkaraf.name=${FUSE_KARAF_NAME} -Druntime.id=${FUSE_RUNTIME_ID} -Djava.security.egd=file:/dev/urandom -Daether.updateCheckManager.sessionState=bypass"
' > ${FUSE_ARTIFACT}/bin/setenv

rm /opt/fuse/config.sh
