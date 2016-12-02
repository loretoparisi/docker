# hunspell dockerfile
[hunspell](https://github.com/hunspell/hunspell) and multiple languages [dictionaries](https://github.com/wooorm/dictionaries) docker container.

## How to build the Docker container
You can build build the docker image from the Dockerfile folder or from Docker repositories hub.

To pull the [hunspell image](https://store.docker.com/community/images/loretoparisi/hunspell) from the repo

```
docker pull loretoparisi/hunspell
```

To build from this Dockerfile folder:

```
docker build -t hunspell .
```

This will build all layers, cache each of them with a opportunist caching of git repositories for hunspell and dictionaries stable branches.

Then to run the container in interactive mode (bash) do

```
docker run --rm -it --name hunspell hunspell bash
```

This will make the container to run bash and test the installation

```
$ docker run --rm -it --name hunspell hunspell2 bash
root@27882a6508a7:~# echo "hallo how are yu?" | hunspell
Hunspell 1.5.3
& hallo 10 0: hall, halo, halloo, hallow, hello, halls, Gallo, hall o, Hall, Halon
*
*
& yu 15 14: yew, y, u, you, yum, yup, yuk, ye, ya, nu, yr, yo, cu, yd, mu

root@27882a6508a7:~# 
```

To check the list of installed dictionaries to support multiple languages

```
root@27882a6508a7:~# hunspell -D
SEARCH PATH:
.::/usr/share/hunspell:/usr/share/myspell:/usr/share/myspell/dicts:/Library/Spelling:/root/.openoffice.org/3/user/wordbook:.openoffice.org2/user/wordbook:.openoffice.org2.0/user/wordbook:Library/Spelling:/opt/openoffice.org/basis3.0/share/dict/ooo:/usr/lib/openoffice.org/basis3.0/share/dict/ooo:/opt/openoffice.org2.4/share/dict/ooo:/usr/lib/openoffice.org2.4/share/dict/ooo:/opt/openoffice.org2.3/share/dict/ooo:/usr/lib/openoffice.org2.3/share/dict/ooo:/opt/openoffice.org2.2/share/dict/ooo:/usr/lib/openoffice.org2.2/share/dict/ooo:/opt/openoffice.org2.1/share/dict/ooo:/usr/lib/openoffice.org2.1/share/dict/ooo:/opt/openoffice.org2.0/share/dict/ooo:/usr/lib/openoffice.org2.0/share/dict/ooo
AVAILABLE DICTIONARIES (path is not mandatory for -d option):
/usr/share/hunspell/en_ZA
/usr/share/hunspell/en_AU
/usr/share/hunspell/da_DK
/usr/share/hunspell/tr-TR
/usr/share/hunspell/eu_ES
/usr/share/hunspell/ru_RU
/usr/share/hunspell/fr_FR
/usr/share/hunspell/el_GR
/usr/share/hunspell/sl_SI
/usr/share/hunspell/gl_ES
/usr/share/hunspell/de_DE
/usr/share/hunspell/en_GB
/usr/share/hunspell/vi_VN
/usr/share/hunspell/en_CA
/usr/share/hunspell/it_IT
/usr/share/hunspell/sv_SE
/usr/share/hunspell/ro_RO
/usr/share/hunspell/sr_RS
/usr/share/hunspell/hr_HR
/usr/share/hunspell/de_AT
/usr/share/hunspell/nb_NO
/usr/share/hunspell/uk_UA
/usr/share/hunspell/ca_ES
/usr/share/hunspell/lb_LU
/usr/share/hunspell/nn_NO
/usr/share/hunspell/pt_PT
/usr/share/hunspell/sk_SK
/usr/share/hunspell/de_CH
/usr/share/hunspell/es_ES
/usr/share/hunspell/bg_BG
/usr/share/hunspell/default
/usr/share/hunspell/mn_MN
/usr/share/hunspell/pt_BR
/usr/share/hunspell/nl_NL
/usr/share/hunspell/pl_PL
/usr/share/hunspell/cs_CZ
/usr/share/hunspell/en_US
LOADED DICTIONARY:
/usr/share/hunspell/default.aff
/usr/share/hunspell/default.dic
Hunspell 1.5.3
```
