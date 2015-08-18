FROM thesamet/docker-buck

USER root
RUN apt-get install -y zip
RUN mkdir /build && chown buck /build

USER buck

RUN git clone https://github.com/thesamet/gerrit.git /build/gerrit-src && \
    cd /build/gerrit-src && \
    /usr/bin/buck build gerrit && \
    /usr/bin/buck build release && \
    cp buck-out/gen/release.war /build/gerrit.war && \
    rm -rf /build/gerrit-src

