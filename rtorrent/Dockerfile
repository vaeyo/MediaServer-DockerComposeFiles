FROM lsiobase/alpine:3.6
MAINTAINER vaeyo

# install packages
RUN \
 apk add --no-cache \
	ca-certificates \
	curl \
	fcgi \
	ffmpeg \
	geoip \
	gzip \
	logrotate \
	nginx \
	php7 \
	php7-cgi \
	php7-fpm \
	php7-json  \
	php7-mbstring \
	php7-pear \
	rtorrent \
	nodejs-npm \
	screen \
	tar \
	unrar \
	unzip \
	wget \
	zip && \
 apk add --no-cache \
	--repository http://nl.alpinelinux.org/alpine/edge/community \
	mediainfo && \
# install ruTorrent
 mkdir -p \
	/usr/share/webapps/rutorrent \
	/defaults/rutorrent-conf && \
 curl -o \
 /tmp/rutorrent.tar.gz -L \
	"https://github.com/Novik/ruTorrent/archive/master.tar.gz" && \
 tar xf \
 /tmp/rutorrent.tar.gz -C \
	/usr/share/webapps/rutorrent --strip-components=1 && \
 mv /usr/share/webapps/rutorrent/conf/* \
	/defaults/rutorrent-conf/ && \
 rm -rf \
	/defaults/rutorrent-conf/users && \
# install flood
 mkdir -p \
	/app/flood && \
 flood_tag=$(curl -sX GET "https://api.github.com/repos/jfurrow/flood/releases/latest" \
	| awk '/tag_name/{print $4;exit}' FS='[""]') && \
 curl -o \
 /tmp/flood.tar.gz -L \
	"https://github.com/jfurrow/flood/archive/${flood_tag}.tar.gz" && \
 tar xf \
 /tmp/flood.tar.gz -C \
	/app/flood --strip-components=1 && \
 cd /app/flood && \
 npm install --production && \
# cleanup
 rm -rf \
	/etc/nginx/conf.d/default.conf \
	/tmp/* && \
# fix logrotate
 sed -i "s#/var/log/messages {}.*# #g" /etc/logrotate.conf

# add local files
COPY root/ /
COPY config.js /app/flood/

# ports and volumes
EXPOSE 80 3000
VOLUME /config /downloads
