FROM quay.io/centos-bootc/centos-bootc:stream10

RUN dnf install -y fuse-overlayfs

RUN <<PULL
sed -i -e 's|^#mount_program|mount_program|g' /usr/share/containers/storage.conf
podman --root /opt/additional-store pull fedora:latest
sed -i '/^additionalimagestores.*/a\   "/opt/additional-store",' /usr/share/containers/storage.conf
PULL

COPY ./Containerfile /etc/containers/Containerfile
COPY ./reproducer.sh /usr/bin/reproducer.sh
