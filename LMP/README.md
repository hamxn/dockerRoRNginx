# Docker for LAMP/LNMP by AmazonLinux
Creates a stack image using the official Amazon Linux image for Docker. The image contents of:

* Apache
* PHP
* MySQL
* PHP composer latest
* MySQL client
* Xdebug 2.6
* nginx

## Prerequisite
Install docker to your local pc via the instruction in [Docker](https://docs.docker.com/install/)
As the image is based on AmazonLinux, the local pc should be Unix-like operation system.
## Getting Started
This container is recommended for development use, to mirror or mimic development of an AWS EC2 instance running Amazon Linux.

### Build Image
There is enviroment file named .env in the repo to define which version of Apache, mysql, nginx and php to build
```
##This file for setup version of Middleware - please use only the prodived value.
##Either apache or nginx are installed, the other need to be NULL
#mysql (value to add: mysql55, mysql56, mysql57)
mysql=mysql57
#apache (value to add: httpd24)
apache=
#nginx (value to add: nginx)
nginx=nginx
#php (value to add: php56, php70, php71, php72, phpcustom)
php=php72
```
Navigate to directory containing docker file. If downloading from Docker Hub, move on to "Create Container" section.
```
docker build -t imageName .
```
### Create Container
You will most likely want to develop on your local machine. Create your directory structure on your local machine and figure out where you want your web root to reside. Update the -v ~/www:/var/www/html with the path to your working directory. You can obviously change this to include multiple filepath mappings, where needed.
```
# Custom Image Build
docker run -ti --name alamp -p 80:80 -p 443:443 -p 3306:3306  -v ~/www:/var/www/html -d imagesName
```

### Working with MySQL
By default, the root user doesn't have a password. Run the following to set the root user password.
```
docker exec -ti --privileged alamp mysql_secure_installation
```
### Login as ec2-user
```
docker exec -ti -u ec2-user alamp bash
```


```
