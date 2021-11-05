## Console bitcoin wallet

### Description

To build and run docker container please run

```
$ docker-compose up -d
```

To see all available options

```
$ docker-compose exec cwallet ruby cwallet.rb --help
```

To generate key to `.key` file

```
$ docker-compose exec cwallet ruby cwallet.rb --key
```

To see wallet balance

```
$ docker-compose exec cwallet ruby cwallet.rb --balance
```

To send sum to some address

```
$ docker-compose exec cwallet ruby cwallet.rb --sum=SUM --address=ADDRESS
```
