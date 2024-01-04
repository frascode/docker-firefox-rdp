FROM public.ecr.aws/lts/ubuntu:20.04_stable

ENV VNC_PASSWORD=""
ENV DEBIAN_FRONTEND="noninteractive"
ENV LC_ALL="C.UTF-8"
ENV LANG="en_US.UTF-8"
ENV LANGUAGE="en_US.UTF-8"
ENV RESOLUTION="1366x768x24"

RUN	apt-get update
RUN	apt-get install -y fonts-takao pulseaudio supervisor x11vnc fluxbox mc xfce4 xrdp xvfb wget nano grep sudo
RUN	apt install software-properties-common -y
RUN add-apt-repository ppa:mozillateam/ppa -y
RUN echo "Package: * Pin: release o=LP-PPA-mozillateam Pin-Priority: 1001" > /etc/apt/preferences.d/mozilla-firefox
RUN apt update -y
RUN apt install firefox -y
RUN	apt-get clean -y
RUN	apt-get autoremove -y
RUN	rm -rf /var/cache/* /var/log/apt/* /var/lib/apt/lists/* /tmp/*
RUN SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history" \
    && echo "$SNIPPET" >> "/root/.bashrc"

RUN	useradd -m -G pulse-access -p user user
RUN	{ echo "user"; echo "user"; } | passwd user
RUN	ln -s /crdonly /usr/local/sbin/crdonly
RUN	ln -s /update /usr/local/sbin/update
RUN	mkdir -p /home/user/.config/user-remote-desktop
RUN	mkdir -p /home/user/.fluxbox
RUN	echo ' \n\
		session.screen0.toolbar.visible:        false\n\
		session.screen0.fullMaximization:       true\n\
		session.screen0.maxDisableResize:       true\n\
		session.screen0.maxDisableMove: 		true\n\
		session.screen0.defaultDeco:    		NONE\n\
		' >> /home/user/.fluxbox/init

RUN	echo ' \n\
		[startup] {firefox --kiosk $URL}\n\
		[app] (class=firefox)\n\
			[Maximized] {yes}\n\
		[end]\n\
		' > /home/user/.fluxbox/apps

RUN	chown -R user:user /home/user/.config /home/user/.fluxbox

ADD conf/ /

VOLUME ["/home/user"]

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

