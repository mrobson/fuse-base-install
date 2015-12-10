FROM mrobson/fuse-base-os:latest

MAINTAINER Matthew Robson <matthewrobson@gmail.com>

#Binary Variables
ENV FUSE_VERSION 6.2.1.redhat-084
ENV FUSE_ARTIFACT jboss-fuse-full
ENV FUSE_RELEASE ${FUSE_ARTIFACT}-${FUSE_VERSION}
ENV FUSE_HOME /opt/fuse

COPY jboss-fuse-full-6.2.1.redhat-084.zip ${FUSE_HOME}/

#Install Run
RUN \
	jar -xvf ${FUSE_RELEASE}.zip && \
	rm ${FUSE_RELEASE}.zip && \
	mv jboss-fuse-${FUSE_VERSION} ${FUSE_ARTIFACT} && \
	chmod +x ${FUSE_ARTIFACT}/bin/* && \
	rm ${FUSE_ARTIFACT}/bin/*.bat && \
	rm ${FUSE_ARTIFACT}/bin/status && \
	rm ${FUSE_ARTIFACT}/bin/patch && \
	rm -rf ${FUSE_ARTIFACT}/extras && \
	rm -rf ${FUSE_ARTIFACT}/quickstarts

#Config Edit Run
RUN \
	sed -i -e '/karaf.name = root/d' ${FUSE_ARTIFACT}/etc/system.properties && \
	sed -i -e '/runtime.id=/d' ${FUSE_ARTIFACT}/etc/system.properties && \
	sed -i -e 's/karaf.delay.console=true/karaf.delay.console=false/' ${FUSE_ARTIFACT}/etc/config.properties && \
	sed -i -e 's/karaf.delay.console=true/karaf.delay.console=false/' ${FUSE_ARTIFACT}/etc/custom.properties

COPY config.sh ${FUSE_HOME}/config.sh

RUN ${FUSE_HOME}/config.sh
