.POSIX:

.PHONY: all \
	clean \
	distclean \
	install \
	install-abook \
	install-bash \
	install-bash-completion \
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
	install-less \
	install-mutt \
	install-ncmcpp \
	install-newsbeuter \
	install-mysql \
	install-ksh \
	install-perlcritic \
	install-perltidy \
	install-psql \
	install-readline \
	install-sh \
	install-subversion \
	install-tmux \
	install-urxvt \
	install-vim \
	install-gvim \
	install-vim-config \
	install-gvim-config \
	install-vim-plugins \
	install-vim-pathogen \
	install-x \
	install-yash \
	install-zsh \
	check \
	check-bash \
	check-bin \
	check-games \
	check-ksh \
	check-sh \
	check-urxvt \
	check-yash \
	check-zsh \
	lint \
	lint-bash \
	lint-bin \
	lint-games \
	lint-ksh \
	lint-yash \
	lint-sh \
	lint-urxvt

.SUFFIXES: .awk .bash .pl .sed

NAME = 'Tom Ryder'
EMAIL = tom@sanctum.geek.nz
KEY = 0xC14286EA77BB8872
SENDMAIL = msmtp

BINS = bin/brnl \
	bin/csmw \
	bin/ddup \
	bin/gwp \
	bin/han \
	bin/hms \
	bin/htdec \
	bin/htenc \
	bin/htref \
	bin/jfp \
	bin/max \
	bin/mean \
	bin/med \
	bin/mftl \
	bin/min \
	bin/mode \
	bin/nlbr \
	bin/onl \
	bin/quo \
	bin/rfct \
	bin/rndi \
	bin/sd2u \
	bin/sec \
	bin/slsf \
	bin/su2d \
	bin/tot \
	bin/unf \
	bin/uts \
	bin/xrq

GAMES = games/acq \
	games/aesth \
	games/chkl \
	games/drakon \
	games/kvlt \
	games/rot13 \
	games/strik \
	games/zs

all: $(BINS) git/gitconfig gnupg/gpg.conf

clean distclean:
	rm -f -- \
		$(BINS) \
		$(GAMES) \
		git/gitconfig \
		gnupg/gpg.conf \
		man/man8/dotfiles.7df \
		tmux/tmux.conf \
		urxvt/ext/select

git/gitconfig: git/gitconfig.m4
	m4 \
		-D DF_NAME=$(NAME) \
		-D DF_EMAIL=$(EMAIL) \
		-D DF_KEY=$(KEY) \
		-D DF_SENDMAIL=$(SENDMAIL) \
		git/gitconfig.m4 > $@

KEYSERVER = hkps://hkps.pool.sks-keyservers.net

gnupg/gpg.conf: gnupg/gpg.conf.m4
	m4 -D DF_HOME=$(HOME) -D DF_KEYSERVER=$(KEYSERVER) \
		gnupg/gpg.conf.m4 > $@

man/man7/dotfiles.7df: README.markdown man/man7/dotfiles.7df.header
	cat man/man7/dotfiles.7df.header README.markdown | \
		pandoc -sS -t man -o $@

MAILDIR = $(HOME)/Mail

TMUX_BG = colour237
TMUX_FG = colour248

tmux/tmux.conf: tmux/tmux.conf.m4
	m4 -D DF_TMUX_BG=$(TMUX_BG) -D DF_TMUX_FG=$(TMUX_FG) \
		tmux/tmux.conf.m4 > $@

.awk:
	bin/shb awk -f < $< > $@
	chmod +x ./$@

.bash:
	bin/shb bash < $< > $@
	chmod +x ./$@

.pl:
	bin/shb perl < $< > $@
	chmod +x ./$@

.sed:
	bin/shb sed -f < $< > $@
	chmod +x ./$@

install: install-bash \
	install-bash-completion \
	install-bin \
	install-curl \
	install-ex \
	install-git \
	install-gnupg \
	install-less \
	install-readline \
	install-sh \
	install-vim

install-abook:
	mkdir -p -- $(HOME)/.abook
	cp -p -- abook/abookrc $(HOME)/.abook

install-bash: check-bash install-sh
	mkdir -p -- $(HOME)/.bashrc.d
	cp -p -- bash/bashrc $(HOME)/.bashrc
	cp -p -- bash/bashrc.d/* $(HOME)/.bashrc.d
	cp -p -- bash/bash_profile $(HOME)/.bash_profile
	cp -p -- bash/bash_logout $(HOME)/.bash_logout

install-bash-completion: install-bash
	mkdir -p -- $(HOME)/.bash_completion.d $(HOME)/.config
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
	mkdir -p -- $(HOME)/.config/gtkrc-3.0
	cp -p -- gtk/gtkrc-2.0 $(HOME)/.gtkrc-2.0
	cp -p -- gtk/gtkrc-3.0/settings.ini $(HOME)/.config/gtkrc-3.0

install-i3: install-x
	mkdir -p -- $(HOME)/.i3
	cp -p -- i3/* $(HOME)/.i3

install-less:
	cp -p -- less/lesskey $(HOME)/.lesskey
	command -v lesskey && lesskey

install-mutt:
	mkdir -p -- $(HOME)/.muttrc.d $(HOME)/.cache/mutt
	cp -p -- mutt/muttrc $(HOME)/.muttrc
	cp -p -- mutt/muttrc.d/src $(HOME)/.muttrc.d

install-ncmcpp:
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

install-perlcritic:
	cp -p -- perlcritic/perlcriticrc $(HOME)/.perlcriticrc

install-perltidy:
	cp -p -- perltidy/perltidyrc $(HOME)/.perltidyrc

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

install-urxvt: urxvt/ext/select check-urxvt
	mkdir -p -- $(HOME)/.urxvt/ext
	find urxvt/ext -type f ! -name '*.pl' \
		-exec cp -p -- {} $(HOME)/.urxvt/ext \;

install-vim: install-vim-config \
	install-vim-plugins \
	install-vim-pathogen

install-gvim: install-vim \
	install-gvim-config

install-vim-config:
	cp -p -- vim/vimrc $(HOME)/.vimrc

install-gvim-config:
	cp -p -- vim/gvimrc $(HOME)/.gvimrc

install-vim-plugins: install-vim-config
	find vim/after vim/bundle -name .git -prune -o \
		-type d -exec sh -c 'mkdir -p -- \
			$(HOME)/."$$1"' _ {} \; -o \
		-type f -exec sh -c 'cp -p -- \
			"$$1" $(HOME)/."$$1"' _ {} \;

install-vim-pathogen: install-vim-plugins
	mkdir -p -- $(HOME)/.vim/autoload
	ln -fs -- ../bundle/pathogen/autoload/pathogen.vim $(HOME)/.vim/autoload

install-x:
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

install-yash: check-yash install-sh
	mkdir -p -- $(HOME)/.yashrc.d
	cp -p -- yash/yash_profile $(HOME)/.yash_profile
	cp -p -- yash/yashrc $(HOME)/.yashrc
	cp -p -- yash/yashrc.d/* $(HOME)/.yashrc.d

install-zsh: check-zsh install-sh
	mkdir -p -- $(HOME)/.profile.d $(HOME)/.zshrc.d
	cp -p -- zsh/profile.d/* $(HOME)/.profile.d
	cp -p -- zsh/zprofile $(HOME)/.zprofile
	cp -p -- zsh/zshrc $(HOME)/.zshrc
	cp -p -- zsh/zshrc.d/* $(HOME)/.zshrc.d

check: check-bash \
	check-bin \
	check-games \
	check-man \
	check-sh \
	check-urxvt

check-bash:
	check/bash

check-bin: $(BINS)
	check/bin

check-games: $(GAMES)
	check/games

check-man:
	check/man

check-ksh:
	check/ksh

check-sh:
	check/sh

check-urxvt:
	check/urxvt

check-yash:
	check/yash

check-zsh:
	check/zsh

lint: check \
	lint-bash \
	lint-bin \
	lint-games \
	lint-ksh \
	lint-sh \
	lint-urxvt \
	lint-yash

lint-bash:
	lint/bash

lint-bin: $(BINS)
	lint/bin

lint-games: $(GAMES)
	lint/games

lint-ksh:
	lint/ksh

lint-sh:
	lint/sh

lint-urxvt:
	lint/urxvt

lint-yash:
	lint/yash
