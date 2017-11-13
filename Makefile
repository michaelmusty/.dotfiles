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
	install-newsbeuter \
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
	install-vim-after-ftdetect \
	install-vim-after-indent \
	install-vim-after-syntax \
	install-vim-autoload \
	install-vim-bundle \
	install-vim-config \
	install-vim-ftdetect \
	install-vim-gui \
	install-vim-gui-config \
	install-vim-indent \
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
	lint-xinit \
	dist-vim-plugin \
	dist-vim-plugin-auto-backupdir \
	dist-vim-plugin-auto-swapdir \
	dist-vim-plugin-auto-undodir \
	dist-vim-plugin-big-file-options \
	dist-vim-plugin-command-typos \
	dist-vim-plugin-copy-linebreak \
	dist-vim-plugin-fixed-join \
	dist-vim-plugin-insert-suspend-hlsearch \
	dist-vim-plugin-mail-mutt \
	dist-vim-plugin-strip-trailing-whitespace \
	dist-vim-plugin-toggle-option-flag

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
	bin/oii.m4 \
	bin/pst.m4 \
	bin/swr.m4 \
	bin/tlcs.m4 \
	bin/try.m4 \
	bin/urlc.m4

BINS_SH = bin/chn.sh \
	bin/dfv.sh \
	bin/edda.sh \
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

gnupg/gpg.conf: gnupg/gpg.conf.m4
	m4 \
		-D KEYSERVER=$(KEYSERVER) \
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

install-newsbeuter:
	mkdir -p -- $(HOME)/.config/newsbeuter $(HOME)/.local/share/newsbeuter
	cp -p -- newsbeuter/config $(HOME)/.config/newsbeuter

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
	find terminfo -type f -name '*.info' \
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

install-vim: install-vim-after \
	install-vim-autoload \
	install-vim-bundle \
	install-vim-config \
	install-vim-doc \
	install-vim-ftdetect \
	install-vim-indent \
	install-vim-plugin

install-vim-after: install-vim-after-ftplugin \
	install-vim-after-indent \
	install-vim-after-syntax

install-vim-after-ftplugin:
	mkdir -p $(HOME)/.vim/after/ftplugin
	for type in vim/after/ftplugin/* ; do \
		mkdir -p -- $(HOME)/.vim/after/ftplugin/"$${type##*/}" ; \
		cp -p "$$type"/* $(HOME)/.vim/after/ftplugin/"$${type##*/}" ; \
		done

install-vim-after-indent:
	mkdir -p $(HOME)/.vim/after/indent
	cp -p -- vim/after/indent/*.vim $(HOME)/.vim/after/indent

install-vim-after-syntax:
	mkdir -p $(HOME)/.vim/after/syntax
	cp -p -- vim/after/syntax/*.vim $(HOME)/.vim/after/syntax

install-vim-autoload:
	mkdir -p -- $(HOME)/.vim/autoload
	cp -p -- vim/autoload/*.vim $(HOME)/.vim/autoload

install-vim-bundle: install-vim-config
	find vim/bundle -name .git -prune -o \
		-type d -exec sh -c 'mkdir -p -- $(HOME)/."$$1"' _ {} \; -o \
		-type f -exec sh -c 'cp -p -- "$$1" $(HOME)/."$$1"' _ {} \;

install-vim-config:
	mkdir -p -- $(HOME)/.vim/config
	cp -p -- vim/vimrc $(HOME)/.vimrc
	cp -p -- vim/config/*.vim $(HOME)/.vim/config

install-vim-doc:
	mkdir -p -- $(HOME)/.vim/doc
	cp -p -- vim/doc/*.txt $(HOME)/.vim/doc

install-vim-ftdetect:
	mkdir -p -- $(HOME)/.vim/ftdetect
	cp -p -- vim/ftdetect/*.vim $(HOME)/.vim/ftdetect

install-vim-indent:
	mkdir -p -- $(HOME)/.vim/indent
	cp -p -- vim/indent/*.vim $(HOME)/.vim/indent

install-vim-plugin:
	mkdir -p -- $(HOME)/.vim/plugin
	cp -p -- vim/plugin/*.vim $(HOME)/.vim/plugin

install-vim-gui: install-vim \
	install-vim-gui-config

install-vim-gui-config:
	cp -p -- vim/gvimrc $(HOME)/.gvimrc

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

dist-vim-plugin: dist-vim-plugin-auto-backupdir \
	dist-vim-plugin-auto-swapdir \
	dist-vim-plugin-auto-undodir \
	dist-vim-plugin-big-file-options \
	dist-vim-plugin-command-typos \
	dist-vim-plugin-copy-linebreak \
	dist-vim-plugin-detect-background \
	dist-vim-plugin-fixed-join \
	dist-vim-plugin-insert-suspend-hlsearch \
	dist-vim-plugin-mail-mutt \
	dist-vim-plugin-strip-trailing-whitespace \
	dist-vim-plugin-toggle-option-flag

dist-vim-plugin-auto-backupdir: \
	vim/plugin/auto_backupdir.vim \
	vim/doc/auto_backupdir.txt \
	VERSION
	sh dist/vim-plugin.sh auto_backupdir
dist-vim-plugin-auto-swapdir: \
	vim/plugin/auto_swapdir.vim \
	vim/doc/auto_swapdir.txt \
	VERSION
	sh dist/vim-plugin.sh auto_swapdir
dist-vim-plugin-auto-undodir: \
	vim/plugin/auto_undodir.vim \
	vim/doc/auto_undodir.txt \
	VERSION
	sh dist/vim-plugin.sh auto_undodir
dist-vim-plugin-big-file-options: \
	vim/plugin/big_file_options.vim \
	vim/doc/big_file_options.txt \
	VERSION
	sh dist/vim-plugin.sh big_file_options
dist-vim-plugin-command-typos: \
	vim/plugin/command_typos.vim \
	vim/doc/command_typos.txt \
	VERSION
	sh dist/vim-plugin.sh command_typos
dist-vim-plugin-copy-linebreak: \
	vim/plugin/copy_linebreak.vim \
	vim/doc/copy_linebreak.txt \
	VERSION
	sh dist/vim-plugin.sh copy_linebreak
dist-vim-plugin-detect-background: \
	vim/autoload/detect_background.vim \
	vim/doc/detect_background.txt \
	VERSION
	sh dist/vim-plugin.sh detect_background
dist-vim-plugin-fixed-join: \
	vim/plugin/fixed_join.vim \
	vim/doc/fixed_join.txt \
	VERSION
	sh dist/vim-plugin.sh fixed_join
dist-vim-plugin-insert-suspend-hlsearch: \
	vim/plugin/insert_suspend_hlsearch.vim \
	vim/doc/insert_suspend_hlsearch.txt \
	VERSION
	sh dist/vim-plugin.sh insert_suspend_hlsearch
dist-vim-plugin-mail-mutt: \
	vim/plugin/mail_mutt.vim \
	vim/doc/mail_mutt.txt \
	VERSION
	sh dist/vim-plugin.sh mail_mutt
dist-vim-plugin-strip-trailing-whitespace: \
	vim/plugin/strip_trailing_whitespace.vim \
	vim/doc/strip_trailing_whitespace.txt \
	VERSION
	sh dist/vim-plugin.sh strip_trailing_whitespace
dist-vim-plugin-toggle-option-flag: \
	vim/plugin/toggle_option_flag.vim \
	vim/doc/toggle_option_flag.txt \
	VERSION
	sh dist/vim-plugin.sh toggle_option_flag
