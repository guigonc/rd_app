#Development
---------------
### Install:

  - Linux
    - [docker](https://docs.docker.com/engine/installation/linux/ubuntulinux/)
    - [docker-compose](https://docs.docker.com/compose/install/)
    - [docker-machine](https://docs.docker.com/machine/install-machine/)

  - Mac
    - [docker-toolbox](https://www.docker.com/products/docker-toolbox)

### Execute the application in development environment

#### Linux
Just go to the  `Starting containers step`

#### Mac
With docker-machine, create a local VM:

```sh
docker-machine create default --driver virtualbox
```

If you already have a machine, just certify that it is up to date and running:
```sh
docker-machine start default
docker-machine upgrade default
```

Point your docker client to your server:
```sh
eval $(docker-machine env default)
```

#### Starting containers
```sh
docker-compose build
docker-compose up
```

##### Run Migrations and Seeds
```sh
docker-compose run api rake db:create
docker-compose run api rake db:migrate
```

#### Access the application
- Linux sem docker-machine
```sh
echo "127.0.0.1 dev.contactracker.com api.contactracker.com" | sudo tee -a /etc/hosts > /dev/null
```
- Mac / Linux com docker-machine
```sh
echo "$(docker-machine ip default) dev.contactracker.com api.contactracker.com" | sudo tee -a /etc/hosts > /dev/null
```

### Publishing the application:

#### Client application
```sh
docker-compose run client npm run build
git commit -am 'Production version'
git subtree push --prefix dist origin gh-pages
```

#### Contact Tracker

```sh
git commit -am 'Production version'
git push heroku master
```
