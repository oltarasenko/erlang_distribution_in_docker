# Erlang in docker cloud sandbox #

This application demostrates how to setup a connection between erlang nodes
that are running inside containers which are destributed over the internet.

The application uses:
 1. epmdless - a distribution protocol implementation which allows to run erlang nodes without epmd (https://github.com/oltarasenko/epmdless)
 2. erlang-node-discovery - service which allows to setup dynamic node discovery accross different hosts (for the case when your application is scheduled on different physical hosts, e.g: Mesos) (https://github.com/oltarasenko/erlang-node-discovery)

 ## Example usage ##

 1) Build the release `rebar3 release`
 2) Build the docker container with the app inside `docker-compose build`
 3) Configure your `/etc/hosts` to add host1.com/host2.com aliases (production hosts will probably have their own hostnames). For example my contains the following:

    ```
        10.154.1.53     host1.local
        10.154.1.58     host2.local
    ```

 4) Run `docker-compose up app1 app2` on host1.com machine
 5) Run `docker-compose up app3` on host2.com machine

You will start getting:
```
2_1  | =INFO REPORT==== 14-Feb-2018::13:09:34 ===
app2_1  | Currently I know ['app1@host1.local','app3@host2.local'] nodes
```
which means that the nodes were able to discover each other.
