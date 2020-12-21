FROM archlinux/base:latest

RUN pacman -Syu archlinux-keyring qt5-base base-devel wget p7zip python nodejs npm mame wit git --noconfirm && pacman -Scc --noconfirm

# setup aur access for a new user "docker"
# ADD add-aur.sh /usr/sbin/add-aur
# RUN add-aur docker

RUN npm install -g romtool

ADD build-skyscraper.sh .
RUN chmod +x ./build-skyscraper.sh && ./build-skyscraper.sh 

ADD build-ciso.sh .
RUN chmod +x ./build-ciso.sh && ./build-ciso.sh

RUN rm ./build-skyscraper.sh;  rm ./build-ciso.sh

# RUN su docker -c "yay -S --noprogressbar --needed --noconfirm nsz-git"

VOLUME /roms

RUN ln -s /usr/bin/mame-chdman /usr/bin/chdman

# RUN /usr/share/wit/load-titles.sh && rm /tmp/titles-*

ENV LANG en_US.UTF-8

CMD ["/usr/bin/bash"]
