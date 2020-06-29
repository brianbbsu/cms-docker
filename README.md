# CMS for YTP2020
## Architecture
We divide the whole cms into three parts - **MAIN**, **WEB**, and **WORKER**.

## Requirements
### For all machines
* docker 19.03.11
* docker-compose 1.26.0

### For **MAIN**

* psql (PostgreSQL) 10.12

## Setup
### Database (Only for **MAIN**)
- `sudo su - postgres`
- `createuser --username=postgres --pwprompt cmsuser` # will prompt for password for new user
- `createdb --username=postgres --owner=cmsuser cmsdb`
- `psql --username=postgres --dbname=cmsdb --command='ALTER SCHEMA public OWNER TO cmsuser'`
- `psql --username=postgres --dbname=cmsdb --command='GRANT SELECT ON pg_largeobject TO cmsuser'`
- https://blog.bigbinary.com/2016/01/23/configure-postgresql-to-allow-remote-connection.html
    - `postgresql.conf`
    - `pg_hba.conf`
    - Allow both LAN IP and VM external IP

### Set /etc/hosts (**For all machines**)
Add the hostname and corresponding ip of each machine to /etc/hosts

In our experiment, we have three virtual machines, **main**, **web1**, and **worker1**.

### Download Related Packages
* `$ git clone https://github.com/brianbbsu/cms-docker.git`
* `$ cd cms-docker`
* `$ git checkout YTP2020`

### Edit Config Files for CMS (need to sync across all server)

- `cms.conf`
    - Copy from `example.cms.conf`
    - Change `your_password_here` in the `Database` section to the password of PostgreSQL user `cmsuser`
    - Change the secret key in the `WebServers` section to any HEX string of the same length. **For security concern, the secret key should be unique between contests**
    - Change the username and password in the `ScoringService` section to any username and password (should be the same in `cms.ranking.conf`)
- `cms.ranking.conf`
    - Copy from `example.cms.ranking.conf`
    - Change the username and the password to the ones set in `cms.conf` 

### Init DB (Only for **MAIN**)

* `./shell.sh` # Open a shell in docker
* `cmsInitDB`

### Run Server

* `$ source setup_env <main/web/worker> <contest_id>`
* `$ docker-compose up -d`


