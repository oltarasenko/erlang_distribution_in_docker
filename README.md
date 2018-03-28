# Erlang in docker cloud sandbox #

This application demostrates how to setup a connection between erlang nodes
that are running inside containers which are destributed over the internet.

The application uses:
 1. epmdless - a distribution protocol implementation which allows to run erlang nodes without epmd (https://github.com/oltarasenko/epmdless)
 2. erlang-node-discovery - service which allows to setup dynamic node discovery accross different hosts (for the case when your application is scheduled on different physical hosts, e.g: Mesos) (https://github.com/oltarasenko/erlang-node-discovery)


 ## EPMDLess example ##

This short example shows how to use epmdless to connect nodes without epmd

 0) Checkout to the epmdless_example branch `git checkout epmdless_example`
 1) Build the docker image with the app inside `docker-compose build`
 2) Run `docker-compose up`
 3) Connect to app3 machine and start sample app in the console mode:
```
    $ docker-compose exec app3 bash
    $ _build/default/rel/sample_app/bin/sample_app console
    (app3@host1.local)1> epmdless_dist:add_node('app1@host1.local', 17012).
    =ERROR REPORT==== 28-Feb-2018::11:25:48 ===
    Adding a node: 'app1@host1.local'
    ok
    (app3@host1.local)2> epmdless_dist:list_nodes().
    [{'app1@host1.local',{"host1.local",17012}}]
    (app3@host1.local)3> net_adm:ping('app1@host1.local').
    (app3@host1.local)5> nodes().
    ['app1@host1.local']
```
Which means that you've successfully connected nodes without epmd

 ## Epmdless with node discovery ##

 The only thing you need to organize node discovery is the following config section:

```{ erlang_node_discovery, [
    % epmdless_dist as our database
    {db_callback, epmdless_dist},
    % discovery will happen on one machine only
    {hosts, ["host1.com", "host2.com", "host3.com"]},
    % query following appnames/ports
    {node_ports, [
      {'app1', 17012},
      {'app2', 17013},
      {'app3', 17014}
    ]}
  ]}
```
Which means that app1,app2 and app3 could be randomly started on host1.com, host2.com or host3.com

Lets try it out:

 0) Checkout to the master branch `git checkout master`
 1) Build the docker image with the app inside `docker-compose build`
 2) Run docker-compose up to bring everything up

You will start getting:
```
2_1  | =INFO REPORT==== 14-Feb-2018::13:09:34 ===
app2_1  | Currently I know ['app1@host1.local','app3@host2.local'] nodes
```
which means that the nodes were able to discover each other.

