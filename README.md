# docker-nexus

**A nginx + cgi + sshd server for prototyping services or data hubs.**


## Quick start

* Clone: `git clone ssh://git@git.davepedu.com:222/dave/docker-nexus.git`
* Build: `cd docker-nexus ; docker build -t nexus .`
* Run: `docker run nexus`


## Usage

Nexus offers a couple services:


### SSHD

For shell related activities, an sshd daemon runs on the standard port. Username and password, by default, is `nexus`.

Mount `/data/keys` to persist host keys. Ssh public keys in `/data/nexus_authorized_keys` will be authorized for the
`nexus` user.


### Nginx

For accessing data or calling CGI scripts via nginx on port 80.

The document root is `/data/data/`.


### CGI

CGI scripts can be placed in `/data/scripts/`. Some sample scripts exist in `./examples/cgi-scripts/`.

The library in `scripts/nexus/cgi.py` can be imported like:

```
>>> from nexus.cgi import *
>>> start_response()
Status: 200 OK
Content-Type: text/html

>>>
```


### Cron

Cron is present in the container. Place tabs in `/etc/cron.d`.


## Protips

* Drop executable scripts into `/startup.d/` for startup tasks
* Persistance - mount `/data/` somewhere persistent.


## TODO

* Allow ssh password to be set by passing an env var
* More sample CGI scripts
