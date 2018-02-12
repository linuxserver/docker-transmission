[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/irc/
[podcasturl]: https://www.linuxserver.io/podcast/
[appurl]: https://www.transmissionbt.com/
[hub]: https://hub.docker.com/r/linuxserver/transmission/

[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)][linuxserverurl]

The [LinuxServer.io][linuxserverurl] team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io][forumurl]
* [IRC][ircurl] on freenode at `#linuxserver.io`
* [Podcast][podcasturl] covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# linuxserver/transmission
[![](https://images.microbadger.com/badges/version/linuxserver/transmission.svg)](https://microbadger.com/images/linuxserver/transmission "Get your own version badge on microbadger.com")[![](https://images.microbadger.com/badges/image/linuxserver/transmission.svg)](https://microbadger.com/images/linuxserver/transmission "Get your own image badge on microbadger.com")[![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/transmission.svg)][hub][![Docker Stars](https://img.shields.io/docker/stars/linuxserver/transmission.svg)][hub][![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Builders/x86-64/x86-64-transmission)](https://ci.linuxserver.io/job/Docker-Builders/job/x86-64/job/x86-64-transmission/)

Transmission is designed for easy, powerful use. Transmission has the features you want from a BitTorrent client: encryption, a web interface, peer exchange, magnet links, DHT, µTP, UPnP and NAT-PMP port forwarding, webseed support, watch directories, tracker editing, global and per-torrent speed limits, and more. [Transmission](http://www.transmissionbt.com/about/)

[![transmission](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/transmission.png)][appurl]

## Usage

```
docker create --name=transmission \
-v <path to data>:/config \
-v <path to downloads>:/downloads \
-v <path to watch folder>:/watch \
-e PGID=<gid> -e PUID=<uid> \
-e TZ=<timezone> \
-p 9091:9091 -p 51413:51413 \
-p 51413:51413/udp \
linuxserver/transmission
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`


* `-p 9091` 
* `-p 51413` - the port(s)
* `-v /config` - where transmission should store config files and logs
* `-v /downloads` - local path for downloads
* `-v /watch` - watch folder for torrent files
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation
* `-e TZ` for timezone information, eg Europe/London

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it transmission /bin/bash`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application 

Webui is on port 9091, the settings.json file in /config has extra settings not available in the webui. Stop the container before editing it or any changes won't be saved.

## Securing the webui with a username/password.

this requires 3 settings to be changed in the settings.json file.

`Make sure the container is stopped before editing these settings.`

`"rpc-authentication-required": true,` - check this, the default is false, change to true.

`"rpc-username": "transmission",` substitute transmission for your chosen user name, this is just an example.

`rpc-password` will be a hash starting with {, replace everything including the { with your chosen password, keeping the quotes.

Transmission will convert it to a hash when you restart the container after making the above edits.

## Updating Blocklists Automatically

This requires `"blocklist-enabled": true,` to be set. By setting this to true, it is assumed you have also populated `blocklist-url` with a valid block list.

The automatic update is a shell script that downloads a blocklist from the url stored in the settings.json, gunzips it, and restarts the transmission daemon.

The automatic update will run once a day at 3am local server time.

## Info

* To monitor the logs of the container in realtime `docker logs -f transmission`.

* container version number 

`docker inspect -f '{{ index .Config.Labels "build_version" }}' transmission`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/transmission`


## Versions

+ **12.02.18:** Pull transmission from edge repo.
+ **10.01.18:** Rebase to alpine linux 3.7.
+ **25.07.17:** Add rsync package.
+ **27.05.17:** Rebase to alpine linux 3.6.
+ **06.02.17:** Rebase to alpine linux 3.5.
+ **15.01.17:** Add p7zip, tar , unrar and unzip packages.
+ **16.10.16:** Blocklist autoupdate with optional authentication.
+ **14.10.16:** Add version layer information.
+ **23.09.16:** Add information about securing the webui to README..
+ **21.09.16:** Add curl package.
+ **09.09.16:** Add layer badges to README.
+ **28.08.16:** Add badges to README.
+ **09.08.16:** Rebase to alpine linux.
+ **06.12.15:** Separate mapping for watch folder.
+ **16.11.15:** Initial Release. 

