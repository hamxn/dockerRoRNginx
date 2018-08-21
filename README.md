### PREREQUISITE
Install docker to your local pc via the instruction in [Docker](https://docs.docker.com/install/) As the image is based on AmazonLinux, the local pc should be Unix-like operation system.

### SETUP ENVIRONMENT

#### Step 1: Install docker Community Edition (CE) for developers and small teams looking to get started with Docker and experimenting with container-based apps
Manual:  [Install](https://docs.docker.com/install/) 
By Command: 

* MacOS
  Install the latest version of Docker CE
  
  `$ brew install docker`
  
  Verify that Docker CE is installed correctly by running the hello-world image
  
  `$ sudo docker run hello-world` 

* Ubuntu
   Update the apt package index:
   
   `$ sudo apt-get update`
   
   Install the latest version of Docker CE, or go to the next step to install a specific version. Any existing installation of Docker is replaced
   
   `$ sudo apt-get install docker-ce`
   
   Verify that Docker CE is installed correctly by running the hello-world image
   
   `$ sudo docker run hello-world`   

#### Step 2: Build image by command
There are 2 images will be built: a app image and mysql database image
The app image will content the following applications:

* Ruby 2.5.0
* Rails 5.2.0
* ImageMagick 6.7.8-9
* Redis 3.2.11
* Yarn 1.7.0
* Nginx 1.12.1
* Node.js 6.14.3
* Unicorn 5.4.0

Copy the files of docker to source code
```
$ cp -r dockerRoRNginx/* ~/ruby_source
$ cd ~/ruby_source
```
Build image and launch container
```
$ docker-compose build
$ docker-compose up -d
```
It will take time for the first time. Coffee break.
After finish, the result would be:
```
$ docker-compose ps
     Name                   Command               State                      Ports
-----------------------------------------------------------------------------------------------------
dbserver_1   docker-entrypoint.sh mysqld      Up      0.0.0.0:3306->3306/tcp, 33060/tcp
webserver_1   /bin/sh -c /etc/init.d/ngi ...   Up      0.0.0.0:8443->443/tcp, 0.0.0.0:8080->80/tcp
```
Login to container by command

`$ docker exec -ti -u ec2-user webserver_1 bash`

#### Step 3: Setup environment in source code 
* Modify Database connection in the following files (change from localhost to dbserver)
```
$ vi ./config/database.yml
$ vi ./lib/tasks/ridgepole.rake
```
* Install ruby bundle
```
$ sudo su -
$ bundle install
```
* Config database with bunlde
```
$ bundle config --local build.mysql2 "--with-ldflags=-L/usr/local/opt/openssl/lib --with-cppflags=-I/usr/local/opt/openssl/include"
```
* Database creation and config
```
$ bin/rake db:setup
$ bin/rake ridgepole:apply
$ bin/rake db:seed_fu
```
* Set pre-commit with Rubocop
```
$ bundle exec pre-commit enable git checks rubocop
$ pre-commit install
```
* Start Unicorn service
```
bundle exec unicorn -E development -c config/unicorn/development.rb
```

