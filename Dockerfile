FROM debian
RUN dpkg --add-architecture i386
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    qemu-kvm \
    fonts-wqy-zenhei \
    xz-utils \
    dbus-x11 \
    curl \
    firefox-esr \
    gnome-system-monitor \
    mate-system-monitor \
    git \
    xfce4 \
    xfce4-terminal \
    tightvncserver \
    wget \
    zip \
    qbittorrent-nox
RUN wget https://github.com/novnc/noVNC/archive/refs/tags/v1.2.0.tar.gz
RUN curl -LO https://proot.gitlab.io/proot/bin/proot
RUN chmod 755 proot
RUN mv proot /bin
RUN tar -xvf v1.2.0.tar.gz
RUN mkdir $HOME/.vnc
RUN echo 'luo' | vncpasswd -f > $HOME/.vnc/passwd
RUN echo '/bin/env MOZ_FAKE_NO_SANDBOX=1 dbus-launch startxfce4' > $HOME/.vnc/xstartup
RUN chmod 600 $HOME/.vnc/passwd
RUN echo 'whoami' >> /luo.sh
RUN echo 'cd' >> /luo.sh
RUN echo "su -l -c 'vncserver :2000 -geometry 1280x800'" >> /luo.sh
RUN echo "su -l -c 'vncserver :2000 -geometry 1360x768'" >> /luo.sh
RUN echo 'cd /noVNC-1.2.0' >> /luo.sh
RUN echo './utils/launch.sh --vnc localhost:7900 --listen 8900' >> /luo.sh
RUN chmod 755 /luo.sh
EXPOSE 8900
CMD /luo.sh
