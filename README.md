# busybox-entware

A lightweight docker image based on [busybox](https://hub.docker.com/_/busybox?tab=description) and [Entware](https://github.com/Entware/Entware)

This image provides `opkg` with support for 2500+ packages from [Entware repository](https://github.com/Entware/Entware)

## How to use?

Use `rahulthakoor/busybox-entware` as base image in your Dockerfile.

E.g :

```dockerfile
FROM rahulthakoor/busybox-entware

# Install lighttpd
RUN opkg update &&\
    opkg install lighttpd

WORKDIR /usr/src/app

COPY start.sh ./

COPY lighttpd.conf ./

RUN mkdir -p /var/www/servers/test/pages/

COPY index.html /var/www/servers/test/pages/

RUN mkdir /var/tmp

CMD ["sh", "start.sh"]
```

## Package lists

- [ARMv5](https://bin.entware.net/armv5sf-k3.2/Packages.html) 
- [ARMv7](https://bin.entware.net/armv7sf-k3.2/Packages.html)
- [ARMv8(aarch64)](https://bin.entware.net/aarch64-k3.10/Packages.html)
- [x64](https://bin.entware.net/x64-k3.2/Packages.html)
- [x86(i386)](https://bin.entware.net/x86-k2.6/Packages.html)

## Attribution

This project simply installs `opkg` from Entware repository in the busybox image. All credits go to the original developers