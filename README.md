# build-docker-containers
This repository contains bunch of docker containers bringing the neccessary tools to compile ArangoDB for a linux distribution.

#distros
This contains the docker container descriptions. The layout is the following:

    <linux distro>/<version> -- Dockerfile # the file to build this container
                             +- scripts/ + # utility scripts 
                                         +- install.sh # will pull GCC etc.
                                         +- prepare_buildenv.sh # should be sourced during compilation to set up the environment / paths etc. for compiling.


