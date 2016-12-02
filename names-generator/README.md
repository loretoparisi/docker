# Docker Random Images Names Generator
The docker command to generate silly random images names.

First set to `GOPATH` for source files.
```
 export GOPATH=$(pwd)
```

then build

```
go build -o dist/macos/docker_createname main.go
./dist/macos/docker_createname
```

and run

```
$ for i in `seq 10`; do ./dist/macos/docker_createname; done
hardcore_raman
agitated_golick
affectionate_raman
friendly_allen
inspiring_yonath
gallant_colden
condescending_brahmagupta
gallant_euler
frosty_babbage
happy_montalcini
```

# References
From docker pkg [names-generator](https://github.com/docker/docker/tree/master/pkg/namesgenerator).
