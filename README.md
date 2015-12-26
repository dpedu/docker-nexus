# docker-nexus

**A nginx/cgi/sshd server for prototyping services or data hubs.**

## Quick start

* Clone: `git clone ssh://git@gitlab.xmopx.net:222/dave/docker-nexus.git`
* Build: `cd docker-nexus ; docker build -t nexus .`
* Run: `docker run nexus`


## Usage

Nexus offers a couple services:

### SSHD

For shell related activities, an sshd daemonr runs on the standard port. Username and password, by default, is `nexus`.

### Nginx

For accessing data or calling CGI scripts, nginx runs on the standard port. The document root is `/nexus/`.

### CGI

Standard CGI scripts can be placed in `/nexus/cgi-bin/`. Some sample scripts exist in `./examples/cgi-scripts/`.

### Cron

Cron is present in the container.

## TODO

* Allow ssh password to be set by passing an env var
* More sample CGI scripts
