# Docker Laravel - Lumen
All this project is completely based on the work of [prbdias](https://github.com/prbdias/docker-lumen) 
in his repository [docker-lumen](https://github.com/prbdias/docker-lumen)

I created this fork for personal use, to be able to use the docker setup with any version of Lumen (this repo does not 
include the Lumen source files)

### Install

Before you start make sure you have [Docker](https://docs.docker.com/install/) and [Docker Compose](https://docs.docker.com/compose/install/) installed on your machine.

Clone the repo by running the following command

    git clone https://github.com/josevavia/docker-lumen.git

### Create project
You can use this docker-compose setup either with a Lumen or Laravel project. The only thing you need is to put the
source of your app in the `./src` directory.

You have a lot of ways to do this, but I prefer to user de Laravel/Lumen installers.

NOTE:  the "name" of the project should be **src** to create the folder properly

#### Laravel project

    composer global require laravel/installer
    laravel new src
    
#### Lumen project

    composer global require "laravel/lumen-installer"
    lumen new src
    
#### Other options
Any other option to create a `./src` directory with the source code of the laravel/lumen project should work.    
    


### Config
#### Configure containers
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
                 
#### Configure project
You can configure the project following the steps of a normal installation 
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

You can follow the official guides to configure the other variables in the `.env` file 
- https://laravel.com/docs/5.6/configuration
- https://lumen.laravel.com/docs/5.6/installation#configuration

 
### Start
To start you application you just need to run the following command 

    $ docker-compose up
    
### Test

Notes: 
- NGINX ports are 9080 and 9443, forwarded to 80 and 443
- Mysql port is 9306, forwarded to 3306
- Redis port is 6379
- Mailhog SMTP port is 1025, and HTTP port is 8025
- You can change this ports and forwardings in `docker-compose.yaml`

##### PHP-FPM
Give it 5min while composer installs all the dependencies automatically under the vendor folder.

Once it has finished you should be able to see your default page on your [http://127.0.0.1:9080](http://127.0.0.1:9080).


##### PHP-CLI
In order to run PHP on the command line you can list all the containers by running 

    $ docker-compose ps
    
Assuming you left the the config value `COMPOSE_PROJECT_NAME=app` you should see a container running with the name **app_workspace_1**


All you have to do is to run the following command to use the workspace container as your main bash 

    $ docker exec -i -t app_workspace_1 /bin/bash

And then you will have PHP ready for you, just give it a try!


    $ php artisan 



##### MAILHOG
To allow rapid testing and development, this docker-compose configuration includes a Mailhog container.
In order to configure your mailer to use Mailhog, you can follow this setup (based in a .env file of Laravel)

```
MAIL_DRIVER=smtp
MAIL_HOST=mail
MAIL_PORT=1025
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
```

Note that the host name and port are the Mailhog container name and exposed port respectively
