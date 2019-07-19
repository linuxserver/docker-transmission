# My Blog
http://blog.auska.win

## Usage

```
docker create --name=transmission \
-v <path to data>:/config \
-v <path to downloads>:/downloads \
-v <path to watch folder>:/watch \
-e PGID=<gid> -e PUID=<uid> \
-e TZ=<timezone> \
-e USER=<default : admin> -e PASSWD=<default : admin> \
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

## Updating Blocklists Automatically

This requires `"blocklist-enabled": true,` to be set. By setting this to true, it is assumed you have also populated `blocklist-url` with a valid block list.

The automatic update is a shell script that downloads a blocklist from the url stored in the settings.json, gunzips it, and restarts the transmission daemon.

The automatic update will run once a day at 3am local server time.

## Versions

+ **15.08.18:** Rebase to alpine linux 3.8.
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

