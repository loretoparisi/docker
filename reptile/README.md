# Reptile
Reptile is a Scalable Meta-Learning Algorithm made by OpenAI.

# Disclaimer
For more info please see about Reptile here: https://blog.openai.com/reptile/

# How to build
To build the reptile example docker image please run the `./build.sh` script. 

# How to Run with a Attached Display
To run on macOS with attached display please do the following. The first script will install the necessary libraries to bind your display to a socket server via XQuartz. If your dependency are all installed you should see the following:

```
./macos_install.sh
XQuartz installed!
Homebrew installed!
socat installed!
```

Otherwise the script will try to install `brew` and `socat` and guide you to install `XQuartz`.

# Run the examples
To run the examples start the `docker` image with the following and run the example:

```
$ ./run.sh 
2018/03/08 00:37:41 socat[96754] E bind(5, {LEN=0 AF=2 0.0.0.0:6000}, 16):
root@e51bb89514a7:~# python reptile-sinewaves-demo.py 
-----------------------------
iteration               {iteration+1}
loss on plotted curve   {lossval:.3f}
```

The `XQuartz` server will start and you should see `matplotlib` working

<img width="640" alt="schermata 2018-03-08 alle 00 39 04" src="https://user-images.githubusercontent.com/163333/37124591-42f6996c-2269-11e8-83d5-a13f85492f4c.png">
