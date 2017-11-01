This setup provides each container a host directory for config files. Each app has its own docker-compose file in its directory and an env file if its environmental variables are excessive

My directory structure is like so. Only have to make the Media/Download folders as the apps folder setup will be git cloned.

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


 * To set this up youll first need to edit the following files to your info:
  * /apps/id.env
  * /apps/emby/id.env
  * /apps/letsencrypt/id.env
  * /apps/letsencrypt/nginx/site-confs/default needs to have domain corrected. 

 * Wetty/Shellinabox have some crazy permissions under environments. Check to make sure you are comfortable with them.






