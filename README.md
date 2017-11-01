This setup provides each container a host directory for config files. Each app has its own docker-compose file in its directory and an env file if its environmental variables are excessive.

I have a defined network which was mostly for the reverse proxy. It probably doesnt benefit in any way but you will have to create the network before container creation.  
            ```docker network create --driver=bridge media```
My directory structure is like so. The compose file will make some of the folders but the folder structure can be created with this: 
```
├── apps
│   ├── cardigann
│   ├── couchpotato
│   ├── deluge
│   ├── filebot
│   ├── handbrake
│   ├── Jackett
│   ├── letsencrypt
│   │   └── nginx
│   ├── misc
│   │   ├── scripts
│   │   └── systemd
│   ├── nzbget
│   ├── nzbhydra
│   ├── ombi
│   ├── organizr
│   ├── plex
│   ├── plexpy
│   ├── portainer
│   ├── radarr
│   ├── rtorrent
│   │   └── build
│   ├── sabnzbd
│   ├── shellinabox
│   ├── sonarr
│   └── wetty
├── downloads
│   ├── complete
│   ├── convert
│   │   ├── movies
│   │   └── tv
│   ├── incomplete
│   │   ├── movies
│   │   └── tv
│   ├── nzb
│   ├── queue
│   ├── tmp
│   └── watch
│       ├── movies
│       └── tv
└── media
    ├── Kids Movies
    ├── Kids TV Shows
    ├── Movies
    └── TV Shows
```

##### I normally run my setup in /srv or /opt but its up to you as long as the level structure remains the same:

```mkdir -p /opt/downloads{/complete,/convert/movies,/convert/tv,/incomplete/movies,/incomplete/tv,/watch/tv,/watch/movies}
mkdir -p /opt/media{/Kids\ Movies,/Kids\ TV\ Shows,/Movies,/TV\ Shows}
```

#### Either run my ghetto little script that doesnt have checks or 
  
  *      initial.setup.sh       *

           ## or

#### Manually edit the following files:
   * /apps/id.env
   * /apps/emby/id.env
   * /apps/letsencrypt/id.env
   * /apps/letsencrypt/nginx/site-confs/default needs to have domain corrected. 
   * Wetty/Shellinabox have some crazy permissions on their docker-compose.yml. Change those to your preference.
   
### Compose File Setup
----------------------
###### Our compose file will always contain the following info:

    version: 2
    services:
    
###### And with our media network heres our compose file base

    networks:
      default:
        external:
          name: media
          
    version: 2
    services:
###### Now we to pick the apps to add and add them to the compose file with this format

      plex:
        extends:
          file: plex/docker-compose.yml
          service: plex

###### All together with a few more apps added and it will look like so:

````
networks:
  default:
    external:
      name: media

version: '2'
services:
  plex:
    extends:
      file: plex/docker-compose.yml
      service: plex
  organizr:
    extends:
      file: organizr/docker-compose.yml
      service: organizr
  ombi:
    extends:
      file: ombi/docker-compose.yml
      service: ombi
  plexpy:
    extends:
      file: plexpy/docker-compose.yml
      service: plexpy
  sonarr:
    extends:
      file: sonarr/docker-compose.yml
      service: sonarr
  radarr:
    extends:
      file: radarr/docker-compose.yml
      service: radarr
````

#### Once we have our file above set up. While in the same directory run

```docker-compose -f compose-setup.yml config```

#### If we have no quick fixes to make run the same command this time redirecting it:

```docker-compose -f compose-setup.yml config >> docker-compose.yml```

#### And now we have our docker-compose from the redirect:

````
networks:
  defaults:
    external:
      name: media

version: '2'
networks:
  ombi:
    container_name: ombi
    environment:
      PGID: -gid-
      PUID: -uid-
      TZ: -tz-
    image: lsiodev/ombi-preview
    ports:
    - 3579:3579
    restart: always
    volumes:
    - /srv/apps/ombi:/config:rw
    - /etc/localtime:/etc/localtime:ro
  organizr:
    container_name: organizr
    environment:
      PGID: -gid-
      PUID: -uid-
      TZ: -tz-
    image: lsiocommunity/organizr
    ports:
    - 8888:80
    restart: always
    volumes:
    - /srv/apps/organizr:/config:rw
  plex:
    container_name: plex
    environment:
      PGID: -gid-
      PUID: -uid-
      TZ: -tz-
    image: linuxserver/plex
    ports:
    - 1900:1900/udp
    - 32400:32400
    - 32400:32400/udp
    - 32469:32469
    - 32469:32469/udp
    - 5353:5353/udp
    restart: always
    volumes:
    - /srv/apps/plex:/config:rw
    - /srv/media:/data:rw
    - /srv/apps/plex/transcode:/transcode:rw
  plexpy:
    container_name: plexpy
    environment:      
      PGID: -gid-
      PUID: -uid-
      TZ: -tz-
    image: linuxserver/plexpy
    ports:
    - 8181:8181
    restart: always
    volumes:
    - /srv/apps/plexpy:/config:rw
    - /srv/apps/plex/Library/Application\ Support/Plex\ Media\ Server/Logs:/logs:ro
  radarr:
    container_name: radarr
    environment:
      PGID: -gid-
      PUID: -uid-
      TZ: -tz-
    image: linuxserver/radarr
    ports:
    - 7878:7878
    restart: always
    volumes:
    - /srv/apps/radarr:/config:rw
    - /srv/downloads:/downloads:rw
    - /etc/localtime:/etc/localtime:ro
    - /srv/media:/movies:rw
  sonarr:
    container_name: sonarr
    environment:
      PGID: -gid-
      PUID: -uid-
      TZ: -tz-
    image: linuxserver/sonarr
    ports:
    - 8989:8989
    restart: always
    volumes:
    - /srv/apps/sonarr:/config:rw
    - /srv/downloads:/downloads:rw
    - /etc/localtime:/etc/localtime:ro
    - /srv/media:/tv:rw
version: '2.0'
volumes: {}
````


