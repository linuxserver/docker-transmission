[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/index.php/irc/
[podcasturl]: https://www.linuxserver.io/index.php/category/podcast/

[![linuxserver.io](https://www.linuxserver.io/wp-content/uploads/2015/06/linuxserver_medium.png)][linuxserverurl]

The [LinuxServer.io][linuxserverurl] team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io][forumurl]
* [IRC][ircurl] on freenode at `#linuxserver.io`
* [Podcast][podcasturl] covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# linuxserver/transmission
[![](https://images.microbadger.com/badges/image/linuxserver/transmission.svg)](http://microbadger.com/images/linuxserver/transmission "Get your own image badge on microbadger.com")[![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/transmission.svg)][hub][![Docker Stars](https://img.shields.io/docker/stars/linuxserver/transmission.svg)][hub][![Build Status](http://jenkins.linuxserver.io:8080/buildStatus/icon?job=Dockers/LinuxServer.io/linuxserver-transmission)](http://jenkins.linuxserver.io:8080/job/Dockers/job/LinuxServer.io/job/linuxserver-transmission/)
[hub]: https://hub.docker.com/r/linuxserver/transmission/

Transmission is designed for easy, powerful use. Transmission has the features you want from a BitTorrent client: encryption, a web interface, peer exchange, magnet links, DHT, µTP, UPnP and NAT-PMP port forwarding, webseed support, watch directories, tracker editing, global and per-torrent speed limits, and more. [Transmission](http://www.transmissionbt.com/about/)

[![transmission](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/transmission.png)][transurl]
[transurl]: https://www.transmissionbt.com/

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

**Parameters**

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

## Securing the webui with a username/password.

this requires 3 settings to be changed in the settings.json file.

`Make sure the container is stopped before editing these settings.`

`"rpc-authentication-required": true,` - check this, the default is false, change to true.

`"rpc-username": "transmission",` substitute transmission for your chosen user name, this is just an example.

`rpc-password` will be a hash starting with {, replace everything including the { with your chosen password, keeping the quotes.

Transmission will convert it to a hash when you restart the container after making the above edits.


## Info

* To monitor the logs of the container in realtime `docker logs -f transmission`.



## Versions

+ **23.09.16:** Add information about securing the webui to README..
+ **21.09.16:** Add curl package.
+ **09.09.16:** Add layer badges to README.
+ **28.08.16:** Add badges to README.
+ **09.08.16:** Rebase to alpine linux.
+ **06.12.15:** Separate mapping for watch folder.
+ **16.11.15:** Initial Release. 

