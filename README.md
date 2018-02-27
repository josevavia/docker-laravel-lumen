# Docker Lumen
All this project is completely based on the work of [prbdias](https://github.com/prbdias/docker-lumen) 
in his repository [docker-lumen](https://github.com/prbdias/docker-lumen)

I created this fork for personal use, to be able to use the docker setup with any version of Lumen (this repo does not 
include the Lumen source files)

### Install

Before you start make sure you have [Docker Compose](https://docs.docker.com/compose/install/) installed on your machine.

Clone the repo by running the following command

    git clone https://github.com/josevavia/docker-lumen.git

### Create lumen project
The Lumen project (and all the *php files of your application) should be in the `./src` directory.
You can create this directory and all the files of the Lumen framework following the steps of a normal installation of lumen (https://lumen.laravel.com/docs/5.6/installation)

I recommend to use the Lumen installer via composer: 

#### Install lumen installer (if needed):

    composer global require "laravel/lumen-installer"
    
#### Create a new Lumen project in the last version

    lumen new src
    
NOTE:  the "name" of the project should be "src" to create the folder properly


### Config
####Configure containers
Before you start your application make sure you have created the file `.env` with the correct Docker configuration values. Please take a look into the example on the file **.env.example**
```
    cp .env.example .env
    vim .env
```

Explanation of each variable in the `.env` file:
- COMPOSE_PROJECT_NAME => name of your application. It will be used to name the containers 
- DB_NAME => name of your database. This database will be created when the mysql container is created      
- DB_USER => username for your database connections              
- DB_PASS => password for your database connections              
- DB_ROOT_PASS => password of the root user of the mysql server inside the mysql container         
                 
####Configure Lumen
You can configure Lumen following the steps of a normal installation of Lumen (https://lumen.laravel.com/docs/5.6/installation#configuration)
To configure the connection to the database in the mysql container, your `./src/.env` file must be configured as follows:
```
DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=databasename
DB_USERNAME=user
DB_PASSWORD=pass
```
Notes: 
- The hostname is the name of the mysql container (defined in docker-compose.yaml)
- The database, username and password are the same values as configured in `.env`
 
### Start
To start you application you just need to run the following command 

    $ docker-compose up
    
### Test
##### PHP-FPM
Give it 5min while composer installs all the Lumen dependencies automatically under the vendor folder.

Once it has finished you should be able to see Lumen's default page on your [http://127.0.0.1:9080](http://127.0.0.1:9080).

Notes: 
- NGINX ports are 9080 and 9443, forwarded to 80 and 443
- Mysql port is 9306, forwarded to 3306
- Redis port is 6379
- You can change this ports and forwardings in `docker-compose.yaml`

##### PHP-CLI
In order to run PHP on the command line you can list all the containers by running 

    $ docker-compose ps
    
Assuming you left the the config value `COMPOSE_PROJECT_NAME=app` you should see a container running with the name **app_workspace_1**


All you have to do is to run the following command to use the workspace container as your main bash 

    $ docker exec -i -t app_workspace_1 /bin/bash

And then you will have PHP ready for you, just give it a try!


    $ php artisan 
