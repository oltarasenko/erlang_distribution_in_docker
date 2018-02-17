FROM erlang:20.2.2

# Updating apt repository of the related OS
RUN apt-get clean && \
    apt-get update && \
    apt-get install -y lsof telnet


COPY _build/ /sample
RUN ln -s  sample/default/rel/sample_app/bin/sample_app /sample_app