FROM public.ecr.aws/lts/ubuntu:20.04_stable

ENV VNC_PASSWORD=""
ENV DEBIAN_FRONTEND="noninteractive"
ENV LC_ALL="C.UTF-8"
ENV LANG="en_US.UTF-8"
ENV LANGUAGE="en_US.UTF-8"
ENV RESOLUTION="1366x768x24"
ENV SCALE="1"

RUN	apt-get update
RUN	apt-get install -y fonts-takao pulseaudio supervisor x11vnc fluxbox mc xfce4 xrdp xvfb wget nano grep sudo
RUN	apt-get install awesome awesome-extra -y
RUN apt-get install firefox -y
RUN	apt-get clean -y && apt-get autoremove -y
RUN	rm -rf /var/cache/* /var/log/apt/* /var/lib/apt/lists/* /tmp/*
RUN SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/root/.bash_history" && echo "$SNIPPET" >> "/root/.bashrc"

RUN	useradd -m -G pulse-access -p user user
RUN	{ echo "user"; echo "user"; } | passwd user
RUN	mkdir -p /home/user/.config/awesome/

ADD conf/ /
RUN	chown -R user:user /home/user/

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]


