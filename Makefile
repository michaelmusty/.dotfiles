.POSIX:

.PHONY: all \
	clean \
	distclean \
	install \
	install-abook \
	install-bash \
	install-bin \
	install-bin-man \
	install-curl \
	install-dotfiles-man \
	install-dunst \
	install-ex \
	install-finger \
	install-games \
	install-games-man \
	install-git \
	install-gnupg \
	install-gtk \
	install-i3 \
	install-ksh \
	install-less \
	install-login-shell \
	install-mpd \
	install-mutt \
	install-mysql \
	install-ncmcpp \
	install-newsbeuter \
	install-perlcritic \
	install-perltidy \
	install-psql \
	install-readline \
	install-sh \
	install-subversion \
	install-terminfo \
	install-tmux \
	install-urxvt \
	install-vim \
	install-vim-config \
	install-vim-gui \
	install-vim-gui-config \
	install-vim-pathogen \
	install-vim-plugins \
	install-x \
	install-zsh \
	check \
	check-bash \
	check-bin \
	check-games \
	check-ksh \
	check-login-shell \
	check-man \
	check-sh \
	check-urxvt \
	check-xinit \
	check-zsh \
	lint \
	lint-bash \
	lint-bin \
	lint-games \
	lint-ksh \
	lint-sh \
	lint-urxvt \
	lint-xinit

.SUFFIXES:
.SUFFIXES: .awk .bash .m4 .mi5 .pl .sed .sh

NAME = 'Tom Ryder'
EMAIL = tom@sanctum.geek.nz
KEY = 0xC14286EA77BB8872
SENDMAIL = msmtp

BINS = bin/ap \
	bin/apf \
	bin/ax \
	bin/bcq \
	bin/bel \
	bin/bl \
	bin/bp \
	bin/br \
	bin/brnl \
	bin/ca \
	bin/cf \
	bin/cfr \
	bin/chc \
	bin/chn \
	bin/clog \
	bin/clrd \
	bin/clwr \
	bin/csmw \
	bin/dam \
	bin/d2u \
	bin/ddup \
	bin/dmp \
	bin/dub \
	bin/edda \
	bin/eds \
	bin/exm \
	bin/fgscr \
	bin/finc \
	bin/fnl \
	bin/fnp \
	bin/gms \
	bin/grc \
	bin/grec \
	bin/gred \
	bin/gscr \
	bin/gwp \
	bin/han \
	bin/hms \
	bin/htdec \
	bin/htenc \
	bin/htref \
	bin/hurl \
	bin/igex \
	bin/isgr \
	bin/ix \
	bin/jfc \
	bin/jfcd \
	bin/jfp \
	bin/loc \
	bin/mi5 \
	bin/max \
	bin/maybe \
	bin/mean \
	bin/med \
	bin/mex \
	bin/mftl \
	bin/min \
	bin/mkcp \
	bin/mkmv \
	bin/mktd \
	bin/mode \
	bin/motd \
	bin/murl \
	bin/mw \
	bin/nlbr \
	bin/onl \
	bin/osc \
	bin/pa \
	bin/paz \
	bin/ped \
	bin/pit \
	bin/plmu \
	bin/p \
	bin/pp \
	bin/pph \
	bin/pst \
	bin/pvi \
	bin/pwg \
	bin/quo \
	bin/rep \
	bin/rfcf \
	bin/rfcr \
	bin/rfct \
	bin/rgl \
	bin/rnda \
	bin/rndf \
	bin/rndi \
	bin/rndl \
	bin/rnds \
	bin/sd2u \
	bin/sec \
	bin/shb \
	bin/slow \
	bin/sls \
	bin/slsf \
	bin/sqs \
	bin/sra \
	bin/sshi \
	bin/sta \
	bin/stbl \
	bin/stex \
	bin/stws \
	bin/su2d \
	bin/sue \
	bin/supp \
	bin/swr \
	bin/td \
	bin/tl \
	bin/tlcs \
	bin/tm \
	bin/tot \
	bin/trs \
	bin/try \
	bin/u2d \
	bin/umake \
	bin/unf \
	bin/urlc \
	bin/urlh \
	bin/urlmt \
	bin/uts \
	bin/vest \
	bin/vex \
	bin/wro \
	bin/xgo \
	bin/xgoc \
	bin/xrbg \
	bin/xrq

BINS_M4 = bin/chn.m4 \
	bin/edda.m4 \
	bin/pst.m4 \
	bin/rndl.m4 \
	bin/swr.m4 \
	bin/tlcs.m4 \
	bin/try.m4 \
	bin/urlc.m4

BINS_SH = bin/chn.sh \
	bin/edda.sh \
	bin/pst.sh \
	bin/rndl.sh \
	bin/swr.sh \
	bin/tlcs.sh \
	bin/try.sh \
	bin/urlc.sh

GAMES = games/aaf \
	games/acq \
	games/aesth \
	games/chkl \
	games/dr \
	games/drakon \
	games/kvlt \
	games/rndn \
	games/rot13 \
	games/squ \
	games/strik \
	games/xyzzy \
	games/zs

all: $(BINS) git/gitconfig gnupg/gpg.conf

clean distclean:
	rm -f -- \
		$(BINS) \
		$(BINS_M4) \
		$(BINS_SH) \
		$(GAMES) \
		git/gitconfig \
		git/gitconfig.m4 \
		gnupg/gpg.conf \
		gnupg/gpg.conf.m4 \
		include/mktd.m4 \
		man/man8/dotfiles.7df \
		urxvt/ext/select

.awk:
	sh bin/shb.sh awk -f < $< > $@
	chmod +x ./$@

.bash:
	sh bin/shb.sh bash < $< > $@
	chmod +x ./$@

.pl:
	sh bin/shb.sh perl < $< > $@
	chmod +x ./$@

.sed:
	sh bin/shb.sh sed -f < $< > $@
	chmod +x ./$@

.sh:
	sh bin/shb.sh sh < $< > $@
	chmod +x ./$@

.mi5.m4:
	awk -f bin/mi5.awk < $< > $@

.m4.sh:
	m4 < $< > $@

bin/chn.sh: bin/chn.m4 include/mktd.m4
bin/edda.sh: bin/edda.m4 include/mktd.m4
bin/pst.sh: bin/pst.m4 include/mktd.m4
bin/rndl.sh: bin/rndl.m4 include/mktd.m4
bin/swr.sh: bin/swr.m4 include/mktd.m4
bin/tlcs.sh: bin/tlcs.m4 include/mktd.m4
bin/try.sh: bin/try.m4 include/mktd.m4
bin/urlc.sh: bin/urlc.m4 include/mktd.m4

git/gitconfig: git/gitconfig.m4
	m4 \
		-D NAME=$(NAME) \
		-D EMAIL=$(EMAIL) \
		-D KEY=$(KEY) \
		-D SENDMAIL=$(SENDMAIL) \
		git/gitconfig.m4 > $@

KEYSERVER = hkps://hkps.pool.sks-keyservers.net

gnupg/gpg.conf: gnupg/gpg.conf.m4
	m4 \
		-D HOME=$(HOME) \
		-D KEYSERVER=$(KEYSERVER) \
		gnupg/gpg.conf.m4 > $@

man/man7/dotfiles.7df: README.markdown man/man7/dotfiles.7df.header
	cat man/man7/dotfiles.7df.header README.markdown | \
		pandoc -sS -t man -o $@

MAILDIR = $(HOME)/Mail

install: install-bin \
	install-curl \
	install-ex \
	install-git \
	install-gnupg \
	install-less \
	install-login-shell \
	install-readline \
	install-vim

install-abook:
	mkdir -p -- $(HOME)/.abook
	cp -p -- abook/abookrc $(HOME)/.abook

install-bash: check-bash install-sh
	mkdir -p -- $(HOME)/.bashrc.d $(HOME)/.bash_completion.d $(HOME)/.config
	cp -p -- bash/bashrc $(HOME)/.bashrc
	cp -p -- bash/bashrc.d/* $(HOME)/.bashrc.d
	cp -p -- bash/bash_profile $(HOME)/.bash_profile
	cp -p -- bash/bash_logout $(HOME)/.bash_logout
	cp -p -- bash/bash_completion $(HOME)/.config
	cp -p -- bash/bash_completion.d/* $(HOME)/.bash_completion.d

install-bin: $(BINS) install-bin-man
	mkdir -p -- $(HOME)/.local/bin
	find bin -type f -perm -u=x \
		-exec cp -p -- {} $(HOME)/.local/bin \;

install-bin-man:
	mkdir -p -- $(HOME)/.local/share/man/man1 $(HOME)/.local/share/man/man8
	cp -p -- man/man1/*.1df $(HOME)/.local/share/man/man1
	cp -p -- man/man8/*.8df $(HOME)/.local/share/man/man8

install-curl:
	cp -p -- curl/curlrc $(HOME)/.curlrc

install-dotfiles-man: man/man7/dotfiles.7df
	mkdir -p -- $(HOME)/.local/share/man/man7
	cp -p -- man/man7/*.7df $(HOME)/.local/share/man/man7

install-dunst: install-x
	mkdir -p -- $(HOME)/.config/dunst
	cp -p -- dunst/dunstrc $(HOME)/.config/dunst

install-ex:
	cp -p -- ex/exrc $(HOME)/.exrc

install-finger:
	cp -p -- finger/plan $(HOME)/.plan
	cp -p -- finger/project $(HOME)/.project
	cp -p -- finger/pgpkey $(HOME)/.pgpkey

install-games: $(GAMES) install-games-man
	mkdir -p -- $(HOME)/.local/games
	find games -type f -perm -u=x \
		-exec cp -p -- {} $(HOME)/.local/games \;

install-games-man:
	mkdir -p -- $(HOME)/.local/share/man/man6
	cp -p -- man/man6/*.6df $(HOME)/.local/share/man/man6

install-git: git/gitconfig
	cp -p -- git/gitconfig $(HOME)/.gitconfig

install-gnupg: gnupg/gpg.conf
	mkdir -m 0700 -p -- $(HOME)/.gnupg $(HOME)/.gnupg/sks-keyservers.net
	cp -p -- gnupg/*.conf $(HOME)/.gnupg
	cp -p -- gnupg/sks-keyservers.net/* $(HOME)/.gnupg/sks-keyservers.net

install-gtk:
	mkdir -p -- $(HOME)/.config/gtk-3.0
	cp -p -- gtk/gtkrc-2.0 $(HOME)/.gtkrc-2.0
	cp -p -- gtk/gtk-3.0/settings.ini $(HOME)/.config/gtk-3.0

install-i3: install-x
	mkdir -p -- $(HOME)/.i3
	cp -p -- i3/* $(HOME)/.i3

install-less:
	cp -p -- less/lesskey $(HOME)/.lesskey
	lesskey

install-mpd: install-sh
	mkdir -p -- $(HOME)/.profile.d $(HOME)/.mpd $(HOME)/.mpd/playlists
	cp -p .. mpd/profile.d/* $(HOME)/.profile.d
	cp -p -- mpd/mpdconf $(HOME)/.mpdconf

install-mutt:
	mkdir -p -- $(HOME)/.muttrc.d $(HOME)/.cache/mutt
	cp -p -- mutt/muttrc $(HOME)/.muttrc
	cp -p -- mutt/muttrc.d/src $(HOME)/.muttrc.d

install-ncmcpp: install-mpd
	mkdir -p -- $(HOME)/.ncmpcpp
	cp -p -- ncmpcpp/config $(HOME)/.ncmpcpp

install-newsbeuter:
	mkdir -p -- $(HOME)/.config/newsbeuter $(HOME)/.local/share/newsbeuter
	cp -p -- newsbeuter/config $(HOME)/.config/newsbeuter

install-mysql:
	cp -p -- mysql/my.cnf $(HOME)/.my.cnf

install-ksh: check-ksh install-sh
	mkdir -p -- $(HOME)/.shrc.d $(HOME)/.kshrc.d
	cp -p -- ksh/shrc.d/* $(HOME)/.shrc.d
	cp -p -- ksh/kshrc $(HOME)/.kshrc
	cp -p -- ksh/kshrc.d/* $(HOME)/.kshrc.d

install-login-shell: check-login-shell
	sh install/install-login-shell.sh

install-perlcritic:
	cp -p -- perlcritic/perlcriticrc $(HOME)/.perlcriticrc

install-perltidy:
	cp -p -- perltidy/perltidyrc $(HOME)/.perltidyrc

install-plenv:
	mkdir -p -- $(HOME)/.profile.d/ $(HOME)/.shrc.d
	cp -p -- plenv/profile.d/* $(HOME)/.profile.d
	cp -p -- plenv/shrc.d/* $(HOME)/.shrc.d

install-psql:
	cp -p -- psql/psqlrc $(HOME)/.psqlrc

install-readline:
	cp -p -- readline/inputrc $(HOME)/.inputrc

install-sh: check-sh
	mkdir -p -- $(HOME)/.profile.d $(HOME)/.shrc.d
	cp -p -- sh/profile $(HOME)/.profile
	cp -p -- sh/profile.d/* $(HOME)/.profile.d
	cp -p -- sh/shinit $(HOME)/.shinit
	cp -p -- sh/shrc $(HOME)/.shrc
	cp -p -- sh/shrc.d/* $(HOME)/.shrc.d

install-subversion:
	mkdir -p -- $(HOME)/.subversion
	cp -p -- subversion/config $(HOME)/.subversion

install-terminfo:
	find terminfo -type f -name '*.info' \
		-exec tic -- {} \;

install-tmux: tmux/tmux.conf install-terminfo
	cp -p -- tmux/tmux.conf $(HOME)/.tmux.conf

install-urxvt: urxvt/ext/select
	mkdir -p -- $(HOME)/.urxvt/ext
	find urxvt/ext -type f ! -name '*.pl' \
		-exec cp -p -- {} $(HOME)/.urxvt/ext \;

install-vim: install-vim-config \
	install-vim-plugins \
	install-vim-pathogen

install-vim-config:
	cp -p -- vim/vimrc $(HOME)/.vimrc

install-vim-gui: install-vim \
	install-vim-gui-config

install-vim-gui-config:
	cp -p -- vim/gvimrc $(HOME)/.gvimrc

install-vim-plugins: install-vim-config
	find vim/after vim/bundle -name .git -prune -o \
		-type d -exec sh -c 'mkdir -p -- $(HOME)/."$$1"' _ {} \; -o \
		-type f -exec sh -c 'cp -p -- "$$1" $(HOME)/."$$1"' _ {} \;

install-vim-pathogen: install-vim-plugins
	mkdir -p -- $(HOME)/.vim/autoload
	ln -fs -- ../bundle/pathogen/autoload/pathogen.vim $(HOME)/.vim/autoload

install-x: check-xinit
	mkdir -p -- \
		$(HOME)/.config \
		$(HOME)/.config/sxhkdrc \
		$(HOME)/.xinitrc.d \
		$(HOME)/.Xresources.d
	cp -p -- X/redshift.conf $(HOME)/.config
	cp -p -- X/sxhkdrc $(HOME)/.config/sxhkd
	cp -p -- X/xinitrc $(HOME)/.xinitrc
	cp -p -- X/xinitrc.d/* $(HOME)/.xinitrc.d
	cp -p -- X/Xresources $(HOME)/.Xresources
	cp -p -- X/Xresources.d/* $(HOME)/.Xresources.d

install-zsh: check-zsh install-sh
	mkdir -p -- $(HOME)/.profile.d $(HOME)/.zshrc.d
	cp -p -- zsh/profile.d/* $(HOME)/.profile.d
	cp -p -- zsh/zprofile $(HOME)/.zprofile
	cp -p -- zsh/zshrc $(HOME)/.zshrc
	cp -p -- zsh/zshrc.d/* $(HOME)/.zshrc.d

check: check-bin \
	check-login-shell \
	check-man \
	check-sh

check-bash:
	sh check/bash.sh

check-bin: $(BINS_SH)
	sh check/bin.sh

check-games:
	sh check/games.sh

check-man:
	sh check/man.sh

check-ksh:
	sh check/ksh.sh

check-login-shell:
	sh check/login-shell.sh

check-sh:
	sh check/sh.sh

check-urxvt:
	sh check/urxvt.sh

check-xinit:
	sh check/xinit.sh

check-zsh:
	sh check/zsh.sh

lint: lint-bash \
	lint-bin \
	lint-games \
	lint-ksh \
	lint-sh \
	lint-urxvt \
	lint-xinit

lint-bash: check-bash
	sh lint/bash.sh

lint-bin: check-bin
	sh lint/bin.sh

lint-games: check-games
	sh lint/games.sh

lint-ksh: check-ksh
	sh lint/ksh.sh

lint-sh: check-sh
	sh lint/sh.sh

lint-urxvt: check-urxvt
	sh lint/urxvt.sh

lint-xinit: check-xinit
	sh lint/xinit.sh
