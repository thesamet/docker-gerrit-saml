FROM thesamet/docker-buck

USER root
RUN apt-get install -y zip patch
RUN mkdir /build && chown buck /build

USER buck

RUN curl https://github.com/thesamet/gerrit/commit/a6997e7a8997af6d859172dc46411fe8a6aea6d3.patch -o /tmp/patch

RUN git clone --recursive https://gerrit.googlesource.com/gerrit /build/gerrit-src && \
    cd /build/gerrit-src && \
    git checkout origin/stable-2.11 && \
    git submodule update && \
    patch -p1 < /tmp/patch && \
    echo -Xms4000m -Xmx4000m > .buckjavaargs && \
    /usr/bin/buck build gerrit && \
    /usr/bin/buck build release && \
    cp buck-out/gen/release.war /build/gerrit.war && \
    rm -rf /build/gerrit-src

