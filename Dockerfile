FROM thesamet/docker-buck

USER root
RUN mkdir /gerrit-src && chown buck /gerrit-src

USER buck

RUN git clone https://github.com/thesamet/gerrit.git /gerrit-src

USER root
RUN apt-get install -y zip
USER buck

WORKDIR /gerrit-src

RUN /usr/bin/buck build gerrit

