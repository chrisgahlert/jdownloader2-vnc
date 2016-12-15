# jdownloader2-vnc

This image is for running JDownloader 2 with using a virtual X display that you can connect to using VNC.

### Basic
#### Minimal
For running this container, the minimal command is:
```sh
docker run \
    -p 5900:5900 \
    chrisgahlert/jdownloader2-vnc
# Now you can connect to the host via VNC using the 
# default password "jd2". 
```

#### Change password
In order to change the default password you can use:
```sh
docker run \
    -p 5900:5900 \
    -e PASSWORD="mypassword" \
    chrisgahlert/jdownloader2-vnc
```

#### Window size
For customizing the size of the window you can add the following enviroment variables:
```
docker run \
    -p 5900:5900 \
    -e WIDTH=1024 \
    -e HEIGHT=768 \
    chrisgahlert/jdownloader2-vnc
```

### Permissions & Persistence
#### Persist downloads
In order to persist your downloads into a directory on your host system you can mount any folder into the container:
```
docker run \
    -p 5900:5900 \
    -v /download/dir/on/host:/download \
    chrisgahlert/jdownloader2-vnc
# Remember to configure JDownloader's 
# default download directory to "/download" 
# in this case
```

#### User/Group
Often it is undesirable that downloads created by the container are owned by root. For that reason you can modify the user/group that is used to run JDownloader:
```
docker run \
    -p 5900:5900 \
    -v /download/dir/on/host:/download \
    -e USER_ID=1000 \
    -e GROUP_ID=100 \
    chrisgahlert/jdownloader2-vnc
# Please make sure that the download directory 
# on the host is writable by the user defined above.
```

#### JD config
If you want to persist JDownloader's settings you can mount the /app folder onto your host system like this:
```
docker run \
    -p 5900:5900 \
    -v /jd_conf/dir/on/host:/app \
    chrisgahlert/jdownloader2-vnc
# If combined with custom user/group id, 
# make sure that this directory is also writable.
```

### Putting all options together
```
docker run \
    -p 5900:5900 \
    -v /download/dir/on/host:/download \
    -v /jd_conf/dir/on/host:/app \
    -e WIDTH=1024 \
    -e HEIGHT=768 \
    -e PASSWORD="mypassword" \
    -e USER_ID=1000 \
    -e GROUP_ID=100 \
    chrisgahlert/jdownloader2-vnc
```
