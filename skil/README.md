# SKIL CE Dockerfile
SKIL Community Edition (SKIL CE) gives developers an easy way to train and deploy powerful deep learning models to production quickly and easily.
For more info see [SKIL Quickstart](https://skymind.ai/quickstart).

## How to build the Docker container
You can build build the docker image from the Dockerfile folder or from Docker repositories hub.

To pull the [skil image](https://store.docker.com/community/images/loretoparisi/skil) from the repo

```
docker pull loretoparisi/skil
```

To build from this Dockerfile folder:

```
docker build -t skil .
```

You can also use the provided `build.sh` script:

```
./build.sh
```

This will build all layers, cache each of them with a opportunist caching of git repositories for hunspell and dictionaries stable branches.

## How to run the SKIL server
To run the SKIL server please use the provided `run.sh` script, this will setup the right configuration for you:

```
./run.sh
```

The server will start in few minutes and you will be able to login here[http://localhost:9008](http://localhost:9008)

