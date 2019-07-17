FROM archlinux/base:latest

RUN pacman -Syu --noconfirm

RUN pacman -S qt5-base base-devel wget p7zip python nodejs npm mame wit --noconfirm
RUN npm install -g romtool

ENV HOME /root
WORKDIR ${HOME}

ADD build-skyscraper.sh ${HOME}
RUN chmod +x ${HOME}/build-skyscraper.sh && ./build-skyscraper.sh

ADD build-ciso.sh ${HOME}
RUN chmod +x ${HOME}/build-ciso.sh && ./build-ciso.sh

ADD bash_profile ${HOME}/.bash_profile

RUN rm ${HOME}/build-skyscraper.sh
RUN pacman -Scc --noconfirm

VOLUME /roms
VOLUME /config

RUN ln -s /config $HOME/.skyscraper
RUN ln -s /usr/bin/mame-chdman /usr/bin/chdman

RUN /usr/share/wit/load-titles.sh

ENV LANG en_US.UTF-8

CMD ["/usr/bin/bash"]
