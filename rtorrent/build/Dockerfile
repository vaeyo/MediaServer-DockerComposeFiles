FROM lsiobase/alpine:3.6

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
	screen \
	tar \
	unrar \
	unzip \
	wget \
	zip && \
 apk add --no-cache --virtual=build-dependencies \
 	git && \
 apk add --no-cache \
	--repository http://nl.alpinelinux.org/alpine/edge/community \
	mediainfo && \

# install webui
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
# Rutorrent ratiocolor, material theme, mobile plugins 
 git clone https://github.com/nelu/rutorrent-thirdparty-plugins /tmp/rutorrent-thirdparty-plugins && \
    mv /tmp/rutorrent-thirdparty-plugins/* \
 /usr/share/webapps/rutorrent/plugins/ && \
    git clone https://github.com/xombiemp/rutorrentMobile.git \
 /usr/share/webapps/rutorrent/plugins/mobile && \
    git clone https://github.com/Phlooo/ruTorrent-MaterialDesign.git \
 /usr/share/webapps/rutorrent/plugins/theme/themes/materialdesign && \
    wget -qNO /tmp/ratio.zip http://git.io/71cumA && \
 unzip -qo /tmp/ratio.zip -d /usr/share/webapps/rutorrent/plugins && \
    sed -i 's/changeWhat = "cell-background";/changeWhat = "font";/g' \
 /usr/share/webapps/rutorrent/plugins/ratiocolor/init.js && \

# cleanup
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/etc/nginx/conf.d/default.conf \
	/tmp/* && \

# fix logrotate
 sed -i "s#/var/log/messages {}.*# #g" /etc/logrotate.conf

# add local files
COPY root/ /

# ports and volumes
EXPOSE 80 6881 55000
VOLUME /config /downloads
