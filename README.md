# Erlang in docker cloud sandbox #

This application demostrates how to setup a connection between erlang nodes
which are running inside containers which are destributed over the internet.

The application uses:
 1. epmdless - a distribution protocol implementation which allows to run erlang nodes without epmd (https://github.com/oltarasenko/epmdless)
 2. erlang-node-discovery - service which allows to setup dynamic node discovery accross different hosts (for cases when your application can scheduled on different phisical hosts, like in caso of Mesos) (https://github.com/oltarasenko/erlang-node-discovery)

 ## Example usage ##

 1) Build the release `rebar3 release`
 2) Build the docker container with the app inside `docker-compose build`
 3) Configure your `/etc/hosts` to add host1.com/host2.com aliases (production hosts will probably have own hostnames)
 4) Run `docker-compose up app1 app2` on host1.com machine
 5) Run `docker-compose up app3` on host2.com machine

You will start getting:
```
2_1  | =INFO REPORT==== 14-Feb-2018::13:09:34 ===
app2_1  | Currently I know ['app1@host1.local','app3@host2.local'] nodes
```
which means that nodes was able to discover each other
