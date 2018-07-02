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
	install-man \
	install-mpd \
	install-mutt \
	install-mysql \
	install-ncmcpp \
	install-newsboat \
	install-perlcritic \
	install-perltidy \
	install-psql \
	install-readline \
	install-sh \
	install-subversion \
	install-terminfo \
	install-tidy \
	install-tmux \
	install-urxvt \
	install-vim \
	install-vim-after \
	install-vim-after-ftplugin \
	install-vim-after-indent \
	install-vim-after-plugin \
	install-vim-after-syntax \
	install-vim-bundle \
	install-vim-compiler \
	install-vim-config \
	install-vim-filetype \
	install-vim-ftplugin \
	install-vim-gui \
	install-vim-gui-config \
	install-vim-indent \
	install-vim-plugin \
	install-vint \
	install-wget \
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
	lint-vim \
	lint-xinit

.SUFFIXES:
.SUFFIXES: .awk .bash .m4 .mi5 .pl .sed .sh

NAME = 'Tom Ryder'
EMAIL = tom@sanctum.geek.nz
KEY = FA09C06E1B670CD0B2F5DE60C14286EA77BB8872
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
	bin/dfv \
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
	bin/mim \
	bin/min \
	bin/mkcp \
	bin/mkmv \
	bin/mktd \
	bin/mode \
	bin/motd \
	bin/murl \
	bin/mw \
	bin/nlbr \
	bin/oii \
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
	bin/dfv.m4 \
	bin/edda.m4 \
	bin/mim.m4 \
	bin/oii.m4 \
	bin/pst.m4 \
	bin/swr.m4 \
	bin/tlcs.m4 \
	bin/try.m4 \
	bin/urlc.m4

BINS_SH = bin/chn.sh \
	bin/dfv.sh \
	bin/edda.sh \
	bin/mim.sh \
	bin/oii.sh \
	bin/pst.sh \
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
	games/philsay \
	games/pks \
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
		urxvt/ext/select \
		vim/dist/*

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
bin/dfv.sh: bin/dfv.m4 include/mktd.m4
bin/edda.sh: bin/edda.m4 include/mktd.m4
bin/mim.sh: bin/mim.m4 include/mktd.m4
bin/oii.sh: bin/oii.m4 include/mktd.m4
bin/pst.sh: bin/pst.m4 include/mktd.m4
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
KEYID_FORMAT = none

gnupg/gpg.conf: gnupg/gpg.conf.m4
	m4 \
		-D KEYSERVER=$(KEYSERVER) \
		-D KEYID_FORMAT=$(KEYID_FORMAT) \
		gnupg/gpg.conf.m4 > $@

MAILDIR = $(HOME)/Mail

install: install-bin \
	install-curl \
	install-ex \
	install-git \
	install-gnupg \
	install-less \
	install-man \
	install-login-shell \
	install-readline \
	install-vim

install-conf:
	sh install/install-conf.sh

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
	mkdir -m 0700 -p -- $(HOME)/.gnupg
	cp -p -- gnupg/*.conf $(HOME)/.gnupg

install-gtk:
	mkdir -p -- $(HOME)/.config/gtk-3.0
	cp -p -- gtk/gtkrc-2.0 $(HOME)/.gtkrc-2.0
	cp -p -- gtk/gtk-3.0/settings.ini $(HOME)/.config/gtk-3.0

install-i3: install-x
	mkdir -p -- $(HOME)/.i3
	cp -p -- i3/* $(HOME)/.i3

install-keychain: install-sh
	cp -p -- keychain/profile.d/* $(HOME)/.profile.d
	cp -p -- keychain/shrc.d/* $(HOME)/.shrc.d

install-less:
	cp -p -- less/lesskey $(HOME)/.lesskey
	lesskey

install-man:
	mkdir -p -- $(HOME)/.local/share/man/man7
	cp -p -- man/man7/dotfiles.7df $(HOME)/.local/share/man/man7

install-mpd: install-sh
	mkdir -p -- $(HOME)/.mpd/playlists
	cp -p -- mpd/profile.d/* $(HOME)/.profile.d
	cp -p -- mpd/mpdconf $(HOME)/.mpdconf

install-mutt:
	mkdir -p -- $(HOME)/.muttrc.d $(HOME)/.cache/mutt
	cp -p -- mutt/muttrc $(HOME)/.muttrc
	cp -p -- mutt/muttrc.d/src $(HOME)/.muttrc.d

install-ncmcpp: install-mpd
	mkdir -p -- $(HOME)/.ncmpcpp
	cp -p -- ncmpcpp/config $(HOME)/.ncmpcpp

install-neovim:
	make install-vim \
	    VIMDIR=$${XDG_CONFIG_HOME:-"$$HOME"/.config}/nvim \
	    VIMRC=$${XDF_CONFIG_HOME:="$$HOME"/.config}/init.vim

install-newsboat:
	mkdir -p -- $(HOME)/.config/newsboat $(HOME)/.local/share/newsboat
	cp -p -- newsboat/config $(HOME)/.config/newsboat

install-mysql:
	cp -p -- mysql/my.cnf $(HOME)/.my.cnf

install-ksh: check-ksh install-sh
	mkdir -p -- $(HOME)/.kshrc.d
	cp -p -- ksh/shrc.d/* $(HOME)/.shrc.d
	cp -p -- ksh/kshrc $(HOME)/.kshrc
	cp -p -- ksh/kshrc.d/* $(HOME)/.kshrc.d

install-login-shell: check-login-shell
	sh install/install-login-shell.sh

install-perlcritic:
	cp -p -- perlcritic/perlcriticrc $(HOME)/.perlcriticrc

install-perltidy:
	cp -p -- perltidy/perltidyrc $(HOME)/.perltidyrc

install-plenv: install-sh
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
	find terminfo -type f -name '*.ti' \
		-exec tic -- {} \;

install-tidy: install-sh
	cp -p -- tidy/profile.d/* $(HOME)/.profile.d
	cp -p -- tidy/tidyrc $(HOME)/.tidyrc

install-tmux: tmux/tmux.conf install-terminfo
	cp -p -- tmux/tmux.conf $(HOME)/.tmux.conf

install-urxvt: urxvt/ext/select
	mkdir -p -- $(HOME)/.urxvt/ext
	find urxvt/ext -type f ! -name '*.pl' \
		-exec cp -p -- {} $(HOME)/.urxvt/ext \;

# Change these at invocation to install for NeoVim; see README.md
VIMDIR = $(HOME)/.vim
VIMRC = $(HOME)/.vimrc

install-vim: install-vim-after \
	install-vim-autoload \
	install-vim-bundle \
	install-vim-compiler \
	install-vim-config \
	install-vim-filetype \
	install-vim-ftplugin \
	install-vim-indent \
	install-vim-plugin

install-vim-after: install-vim-after-ftplugin \
	install-vim-after-indent \
	install-vim-after-plugin \
	install-vim-after-syntax

install-vim-after-ftplugin:
	mkdir -p $(VIMDIR)/after/ftplugin
	cp -p -- vim/after/ftplugin/*.vim $(VIMDIR)/after/ftplugin

install-vim-after-indent:
	mkdir -p $(VIMDIR)/after/indent
	cp -p -- vim/after/indent/*.vim $(VIMDIR)/after/indent

install-vim-after-plugin:
	mkdir -p $(VIMDIR)/after/plugin
	cp -p -- vim/after/plugin/*.vim $(VIMDIR)/after/plugin

install-vim-after-syntax:
	mkdir -p $(VIMDIR)/after/syntax
	cp -p -- vim/after/syntax/*.vim $(VIMDIR)/after/syntax

install-vim-autoload:
	mkdir -p $(VIMDIR)/autoload
	cp -p -- vim/autoload/*.vim $(VIMDIR)/autoload

install-vim-bundle: install-vim-config
	find vim/bundle/*/* \
		-type d -exec sh -c \
		'mkdir -p -- $(VIMDIR)/"$${1#vim/bundle/*/}"' _ {} \;
	find vim/bundle/*/*/* \
		-type f -exec sh -c \
		'cp -p -- "$$1" $(VIMDIR)/"$${1#vim/bundle/*/}"' _ {} \;
	vim -e -u NONE -c 'helptags $(VIMDIR)/doc' -c quit

install-vim-compiler:
	mkdir -p -- $(VIMDIR)/compiler
	cp -p -- vim/compiler/*.vim $(VIMDIR)/compiler

install-vim-config:
	mkdir -p -- $(VIMDIR)/config
	cp -p -- vim/vimrc $(VIMRC)
	cp -p -- vim/config/*.vim $(VIMDIR)/config

install-vim-filetype:
	cp -p -- vim/filetype.vim vim/scripts.vim $(VIMDIR)

install-vim-ftplugin:
	mkdir -p -- $(VIMDIR)/ftplugin
	cp -p -- vim/ftplugin/*.vim $(VIMDIR)/ftplugin

install-vim-gui: install-vim \
	install-vim-gui-config

install-vim-gui-config:
	cp -p -- vim/gvimrc $(HOME)/.gvimrc

install-vim-indent:
	mkdir -p -- $(VIMDIR)/indent
	cp -p -- vim/indent/*.vim $(VIMDIR)/indent

install-vim-plugin:
	mkdir -p -- $(VIMDIR)/plugin
	cp -p -- vim/plugin/*.vim $(VIMDIR)/plugin

install-vint:
	cp -p -- vint/vintrc.yaml $(HOME)/.vintrc.yaml

install-wget:
	cp -p -- wget/wgetrc $(HOME)/.wgetrc

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

check-bin: $(BINS)
	sh check/bin.sh

check-games: $(GAMES)
	sh check/games.sh

check-man:
	sh check/man.sh

check-ksh:
	sh check/ksh.sh

check-login-shell:
	sh check/login-shell.sh

check-sh:
	sh check/sh.sh

check-urxvt: urxvt/ext/select
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
	lint-vim \
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

lint-vim:
	sh lint/vim.sh

lint-xinit: check-xinit
	sh lint/xinit.sh
