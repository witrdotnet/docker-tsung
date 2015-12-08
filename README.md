# docker-tsung
run tsung in a docker container

# how-to

## Consider following :

* container_to_stress: name of docker container which contains ou server to stress
* myserver : just a name (of server to stress) to be used in tsung.xml config file
* /path/to/my_tsung_workspace : path to local directory which must contains at least the tsung.xml config file

Example of tsung config file
```
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE tsung SYSTEM "/usr/share/tsung/tsung-1.0.dtd" []>
<tsung loglevel="warning">

  <clients>
    <client host="localhost" cpu="2" maxusers="30000000"/>
  </clients>

  <servers>
    <server host="myserver" port="8080" type="tcp"/>
  </servers>

  <load>
    <arrivalphase phase="1" duration="1" unit="minute">
      <users arrivalrate="5" unit="second"/>
    </arrivalphase>
  </load>

  <sessions>
    <session name="es_load" weight="1" type="ts_http">
      <request>
      <http url="/endpoint?param1=val1&param2=val2" method="GET" />
      </request>
    </session>
  </sessions>
</tsung>
```

## run
```
docker run \
    --link container_to_stress:myserver \
    -p 8091:8091 \
    -v /path/to/my_tsung_workspace:/.tsung \
    -ti  witrdotnet/docker-tsung
```

Finally browse : http://localhost:8091
