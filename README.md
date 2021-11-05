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

To generate new wallet

```
$ docker-compose exec cwallet ruby cwallet.rb --generate
```

To see wallet balance

```
$ docker-compose exec cwallet ruby cwallet.rb --balance=ADDRESS
```

To send sum to some address

```
$ docker-compose exec cwallet ruby cwallet.rb --sum=SUM --from=ADDRESS --to=ADDRESS
```

To run tests

```
$ docker-compose exec cwallet rspec
```
