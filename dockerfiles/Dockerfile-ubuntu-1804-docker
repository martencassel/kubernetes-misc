FROM ubuntu:18.04

RUN apt-get -y update && apt-get -y install iputils-ping traceroute

COPY ./scripts/clean-install /usr/local/bin/clean-install
RUN chmod +x /usr/local/bin/clean-install

COPY ./scripts/init-master.sh /tmp/init-master.sh
RUN chmod +x /tmp/init-master.sh

RUN clean-install \
      apt-transport-https ca-certificates curl software-properties-common gnupg2 lsb-release \
      systemd systemd-sysv libsystemd0 \
      conntrack iptables iproute2 ethtool socat util-linux mount ebtables udev kmod aufs-tools \
      bash rsync \
    && find /lib/systemd/system/sysinit.target.wants/ -name "systemd-tmpfiles-setup.service" -delete \
    && rm -f /lib/systemd/system/multi-user.target.wants/* \
    && rm -f /etc/systemd/system/*.wants/* \
    && rm -f /lib/systemd/system/local-fs.target.wants/* \
    && rm -f /lib/systemd/system/sockets.target.wants/*udev* \
    && rm -f /lib/systemd/system/sockets.target.wants/*initctl* \
    && rm -f /lib/systemd/system/basic.target.wants/* \
    && echo "ReadKMsg=no" >> /etc/systemd/journald.conf

ARG DOCKER_VERSION="18.06.*"
# another temporary env, not a real argument. setting this to a non-zero value
# silences this warning from apt-key:
# "Warning: apt-key output should not be parsed (stdout is not a terminal)"
ARG APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE="false"
RUN curl -fsSL "https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg" | apt-key add - \
    && apt-key fingerprint 0EBFCD88 \
    && add-apt-repository \
        "deb https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable" \
    && clean-install "docker-ce=${DOCKER_VERSION}"

ENV container docker
# systemd exits on SIGRTMIN+3, not SIGTERM (which re-executes it)
# https://bugzilla.redhat.com/show_bug.cgi?id=1201657
STOPSIGNAL SIGRTMIN+3

VOLUME [ "/sys/fs/cgroup" ]
VOLUME [ "/var/lib/docker" ]

CMD ["/sbin/init"]
