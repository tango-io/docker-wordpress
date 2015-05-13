# Wordpress docker instance

You can run this instance with `docker-compose up`. You require [docker compose](https://github.com/docker/compose)


# salt secrets

You should create secret keys and change the default if you are going to run it in production

```
curl https://api.wordpress.org/secret-key/1.1/salt/
```

# Connect to the database

You can run a bash console with 

```
docker-compose run wordpress bash
```

and then execute

```
mysql -u $DB_USER -p$DB_PASS -h $MYSQL_PORT_3306_TCP_ADDR $DB_NAME
```

Also you can change the url with this command:

```
update wp_options set option_value='http://192.168.59.103/' where option_name='siteurl'
```
