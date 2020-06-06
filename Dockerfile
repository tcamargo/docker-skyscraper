FROM archlinux/base:latest

RUN pacman -Sy archlinux-keyring --noconfirm

# setup aur access for a new user "docker"
ADD add-aur.sh /usr/sbin/add-aur
RUN add-aur docker

RUN pacman -Syu qt5-base base-devel wget p7zip python nodejs npm mame wit --noconfirm && pacman -Scc --noconfirm

RUN npm install -g romtool

ENV HOME /root
WORKDIR ${HOME}

ADD build-skyscraper.sh ${HOME}
RUN chmod +x ${HOME}/build-skyscraper.sh && ./build-skyscraper.sh

ADD build-ciso.sh ${HOME}
RUN chmod +x ${HOME}/build-ciso.sh && ./build-ciso.sh

RUN su docker -c "yay -S --noprogressbar --needed --noconfirm nsz-git"

RUN rm ${HOME}/build-skyscraper.sh && rm ${HOME}/build-ciso.sh

ADD bash_profile ${HOME}/.bash_profile

VOLUME /roms
VOLUME /config

RUN ln -s /config $HOME/.skyscraper
RUN ln -s /usr/bin/mame-chdman /usr/bin/chdman

RUN /usr/share/wit/load-titles.sh && rm /tmp/titles-*

ENV LANG en_US.UTF-8

CMD ["/usr/bin/bash"]
