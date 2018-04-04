# SPARQL Wikidata Query Server
The Wikidata sparql server is based on Blazegraph.

## How to set up the Blazegraph server
To setup the server through the enclosed docker image please follow these steps

### Grab the docker image and utility tools
```bash
$ git clone https://github.com/loretoparisi/docker.git
$ cd docker/sparql
```

### Build the docker image
To build the docker image please use
```bash
$ ./build.sh
```

### Prepare the Wikidata folder
You need a data folder let's say `wikidata/` that will contain
- The Wikidata dump file like `wikidata-20180326-all-BETA.ttl.gz`
- The `split/` folder, with the splitted entities files from the dump file. This file will be automatically created by the `script/split.sh` script in the running container.
- The `wikidata.jnl` database journal file, where the database data will be stored. This file will be automatically created by the `script/run.sh` script in the running container.
Please note that a ordinary folder size will need at least 300GB of space to store the `en` Wikipedia entities database.

### Download the Wikidata dump
Please check the latest wikidata dump from `https://dumps.wikimedia.org/wikidatawiki/entities/` and select a daily dump file like `wikidata-%DATE%-all-BETA.ttl.gz`
```bash
# curl https://dumps.wikimedia.org/wikidatawiki/entities/20180326/wikidata-20180326-all-BETA.ttl.gz --output wikidata-20180326-all-BETA.ttl.gz
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
 13 32.0G   13 4498M    0     0  2027k      0  4:36:13  0:37:52  3:58:21 2034k
 ```

### Run the docker container as daemon (suggested)
You first need to run the docker container as a daemon in order to import the data from the Wikipedia dump as a batch process. You need to attach a volume to this docker container where the Wikidata folder is.
```bash
$ ./daemon.sh
```
Please then check that the container is up and running
```bash
$ docker ps
CONTAINER ID    IMAGE   COMMAND     CREATED         STATUS          PORTS                       NAMES
c5226871636f    sparql  "bash"      4 hours ago     Up 4 hours      0.0.0.0:9999->9999/tcp      angry_hawking
```

### Enter the docker container (suggested)
As soon as the container is running, to perform next operations, please enter that container in interactive mode
```bash
docker exec -it c5226 bash
#
```
Please note that by defaults `/root/data` will be the attached data volume `wikidata/` and the `/root/blazegraph` will be the server root folder. The scripts folder is `/root/script`.

### Run the Blazegraph server
Within the running container, to run the Blazegraph server 
```bash
$ cd script/
./run.sh
```
To check the server logs
```bash
$ tail -f /root/data/server.log
```
You can connect to the server to `http://localhost:9999/bigdata/` or replace your local server IP. Please note that the server must listen to `0.0.0.0` so a `HOST` env variable has been set for you. By defaults, the server listens to the port `9999`.

### Split the Wikidata dump file
As soon as the server is up and running, within the running container, please prepare the data starting to split the dump file. This will automatically create a `/root/data/split/` folder in the data folder in the container.
```bash
$ cd script/
./split.sh
```
To check the split progress you can tail the logs folder:
```bash
$ tail -f /root/data/split.log
```
When this process ends, a number of files will be available in the `/root/data/split/` folder:

```bash
~# ls -l /root/data/split/
total 26481488
-rw-r--r-- 1 root root 186839974 Mar 27 07:48 wikidump-000000001.ttl.gz
-rw-r--r-- 1 root root 114197889 Mar 27 07:51 wikidump-000000002.ttl.gz
-rw-r--r-- 1 root root  82660694 Mar 27 07:53 wikidump-000000003.ttl.gz
```

### Import the Wikidata entites data
When the split data is ready, you can import the data:
```bash
$ cd script/
./import.sh
```
To check the import progress you can tail the logs folder:
```bash
$ tail -f /root/data/import.log
```

### Update the data
When all the data has been imported, you can update the data on a schedule base (like on weekly bases)
```bash
$ cd script/
./update.sh
```
To check the import progress you can tail the logs folder:
```bash
$ tail -f /root/data/update.log

