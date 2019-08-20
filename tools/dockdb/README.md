# Docker DataBase Launcher

Small console tool to run database server localy inside a docker container.

Supported databases:

* [Postgresql](https://hub.docker.com/_/postgres/) 
* [MySQL](https://hub.docker.com/_/mysql/)
* [MongoDB](https://hub.docker.com/_/mongo/)
* [MSSQL for Linux](https://hub.docker.com/r/microsoft/mssql-server-linux/)
* [Oracle](https://hub.docker.com/r/sath89/oracle-12c/)


## Install

1. Download a script [dockdb](https://raw.githubusercontent.com/revgen/docker-repository/master/docker-database/bin/dockdb)
2. Put it to the ~/bin directory or other place
3. Add this directory to the system PATH if you need it
4. Use the tool from the command line


## Usage

### Help screen

    Usage: dockdb <db type> <command>

    DB Types:
       postgresql  - docker image with a postgresql database
       mysql       - docker image with mysql database
       mongo       - docker image with mongo database
       mssql       - docker image with MS SQL database
       oracle      - docker image with Oracle 12 databse with APEX

    Commands:
       start       - start a new container with a specific database
       stop        - stop a specific container
       status      - show current status for the container with a specific database
       remove      - remove a container and an image with a specific database
       console     - connect to the database inside the docker using a console
       shell       - open a system shell inside the docker container
       logs        - show logs for the specific container
       version     - show the version of the specific database
       help        - show this help screen

### Examples

...
