# Dockerfile template to generate Wombat Docker image
#
# copyright 2016-2018, Erlang Solutions Ltd
#

FROM erlang:20.2.2

# Updating apt repository of the related OS
RUN apt-get clean && \
    apt-get update && \
    apt-get install -y lsof telnet


COPY _build/ /simple