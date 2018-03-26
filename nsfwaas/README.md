# Yahoo! NSFW Neural Network Web Service
This repo implements Safe/not safe for work image classification using a convolutional neural network neural network over a REST service. It uses [Yahoo!'s open_nsfw](https://github.com/yahoo/open_nsfw) model to perform classification.

## Building the container
--
You can build the nsfwaas container by issuing the following command:

    docker build -t nsfwaas .

## Using NSFWaaS
--
First start the service:

```
docker run -p 80:80/tcp nsfwaas
```

You can submit the images over http. The result of the classification result will be returned in the response.

```
curl -X POST -F "image=@beach.jpg" http://localhost/classify
```

## Apache2 Configuration
The server Virtual Host configuration has been provided. If you find errors while starting the service please explicitly add `wsgi_module` load:


```
LoadModule wsgi_module modules/mod_wsgi.so
WSGIScriptAlias / /workspace/config.py
WSGIApplicationGroup %{GLOBAL}
```




