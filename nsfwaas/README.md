NSFW as a Service
===============
This repo implements Safe/not safe for work image classification using a convolutional neural network neural network over a REST service. It uses [Yahoo!'s open_nsfw](https://github.com/yahoo/open_nsfw) model to perform classification.

Building the container
--
You can build the nsfwaas container by issuing the following command:

    docker build -t nsfwaas .

Using NSFWaaS
--
First start the service:

    docker run -p 80:80/tcp nsfwaas

You can submit the images over http. The result of the classification result will be returned in the response.

    curl -X POST -F "image=@beach.jpg" http://localhost/classify




