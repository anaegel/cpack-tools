
## Docker image
```
docker build .
docker buildx build -f docker-standalone/Dockerfile --platform linux/amd64,linux/arm64 . 
```

## Creating packages
Create package and checksum file as follows:
```
cpack -G DEB --verbose
```


## Publish pa

## Local install

Download package 'UG4-0.1.1-Linux.deb' from server. 

Install as follows:

```
dpkg -x UG4-0.1.1-Linux.deb <DESTDIR>
```

Adjust rpath
```
cd <DESTDIR>/bin
patchelf --set-rpath '../lib' ugshell
```

