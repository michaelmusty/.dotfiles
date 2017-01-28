.PHONY : all \
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

NAME := Tom Ryder
EMAIL := tom@sanctum.geek.nz
KEY := 0xC14286EA77BB8872
SENDMAIL := msmtp

BINS = bin/brnl \
	bin/csmw \
	bin/ddup \
	bin/gwp \
	bin/han \
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

all : $(BINS) git/gitconfig gnupg/gpg.conf

clean distclean :
	rm -f \
		$(BINS) \
		$(GAMES) \
		git/gitconfig \
		gnupg/gpg.conf \
		man/man8/dotfiles.7df \
		tmux/tmux.conf \
		urxvt/ext/select

git/gitconfig : git/gitconfig.m4
	m4 \
		-D DOTFILES_NAME="$(NAME)" \
		-D DOTFILES_EMAIL="$(EMAIL)" \
		-D DOTFILES_KEY="$(KEY)" \
		-D DOTFILES_SENDMAIL="$(SENDMAIL)" \
		git/gitconfig.m4 > git/gitconfig

KEYSERVER := hkps://hkps.pool.sks-keyservers.net

gnupg/gpg.conf : gnupg/gpg.conf.m4
	m4 \
		-D DOTFILES_HOME="$(HOME)" \
		-D DOTFILES_KEYSERVER="$(KEYSERVER)" \
		gnupg/gpg.conf.m4 > gnupg/gpg.conf

man/man7/dotfiles.7df : README.markdown man/man7/dotfiles.7df.header
	cat man/man7/dotfiles.7df.header README.markdown | \
		pandoc -sS -t man -o "$@"

MAILDIR := $(HOME)/Mail

TMUX_BG := colour237
TMUX_FG := colour248

tmux/tmux.conf : tmux/tmux.conf.m4
	m4 -D TMUX_BG="$(TMUX_BG)" -D TMUX_FG="$(TMUX_FG)" \
		tmux/tmux.conf.m4 > tmux/tmux.conf

.awk :
	bin/shb "$<" awk -f > "$@"
	chmod +x "$@"

.bash :
	bin/shb "$<" bash > "$@"
	chmod +x "$@"

.pl :
	bin/shb "$<" perl > "$@"
	chmod +x "$@"

.sed :
	bin/shb "$<" sed -f > "$@"
	chmod +x "$@"

install : install-bash \
	install-bash-completion \
	install-bin \
	install-curl \
	install-git \
	install-gnupg \
	install-less \
	install-readline \
	install-sh \
	install-vim

install-abook :
	install -m 0755 -d -- \
		"$(HOME)"/.abook
	install -pm 0644 -- abook/abookrc "$(HOME)"/.abook

install-bash : check-bash install-sh
	install -m 0755 -d -- \
		"$(HOME)"/.config \
		"$(HOME)"/.bashrc.d
	install -pm 0644 -- bash/bashrc "$(HOME)"/.bashrc
	install -pm 0644 -- bash/bashrc.d/* "$(HOME)"/.bashrc.d
	install -pm 0644 -- bash/bash_profile "$(HOME)"/.bash_profile
	install -pm 0644 -- bash/bash_logout "$(HOME)"/.bash_logout

install-bash-completion : install-bash
	install -m 0755 -d -- "$(HOME)"/.bash_completion.d
	install -pm 0644 -- bash/bash_completion "$(HOME)"/.config/bash_completion
	install -pm 0644 -- bash/bash_completion.d/* "$(HOME)"/.bash_completion.d

install-bin : $(BINS) install-bin-man
	install -m 0755 -d -- "$(HOME)"/.local/bin
	for name in bin/* ; do \
		[ -x "$$name" ] || continue ; \
		install -m 0755 -- "$$name" "$(HOME)"/.local/bin ; \
	done

install-bin-man :
	install -m 0755 -d -- \
		"$(HOME)"/.local/share/man/man1 \
		"$(HOME)"/.local/share/man/man8
	install -pm 0644 -- man/man1/*.1df "$(HOME)"/.local/share/man/man1
	install -pm 0644 -- man/man8/*.8df "$(HOME)"/.local/share/man/man8

install-curl :
	install -pm 0644 -- curl/curlrc "$(HOME)"/.curlrc

install-dotfiles-man : man/man7/dotfiles.7df
	install -m 0755 -d -- "$(HOME)"/.local/share/man/man7
	install -pm 0644 -- man/man7/*.7df "$(HOME)"/.local/share/man/man7

install-dunst : install-x
	install -m 0755 -d -- "$(HOME)"/.config/dunst
	install -pm 0644 -- dunst/dunstrc "$(HOME)"/.config/dunst

install-finger :
	install -pm 0644 -- finger/plan "$(HOME)"/.plan
	install -pm 0644 -- finger/project "$(HOME)"/.project
	install -pm 0644 -- finger/pgpkey "$(HOME)"/.pgpkey

install-games : $(GAMES) install-games-man
	install -m 0755 -d -- "$(HOME)"/.local/games
	for name in games/* ; do \
		[ -x "$$name" ] || continue ; \
		install -m 0755 -- "$$name" "$(HOME)"/.local/games ; \
	done

install-games-man :
	install -m 0755 -d -- "$(HOME)"/.local/share/man/man6
	install -pm 0644 -- man/man6/*.6df "$(HOME)"/.local/share/man/man6

install-git : git/gitconfig
	install -pm 0644 -- git/gitconfig "$(HOME)"/.gitconfig

install-gnupg : gnupg/gpg.conf
	install -m 0700 -d -- \
		"$(HOME)"/.gnupg \
		"$(HOME)"/.gnupg/sks-keyservers.net
	install -pm 0600 -- gnupg/*.conf "$(HOME)"/.gnupg
	install -pm 0644 -- gnupg/sks-keyservers.net/* \
		"$(HOME)"/.gnupg/sks-keyservers.net

install-gtk :
	install -m 0755 -d -- \
		"$(HOME)"/.config/gtkrc-3.0
	install -pm 0644 -- gtk/gtkrc-2.0 "$(HOME)"/.gtkrc-2.0
	install -pm 0644 -- gtk/gtkrc-3.0/settings.ini "$(HOME)"/.config/gtkrc-3.0

install-i3 : install-x
	install -m 0755 -d -- "$(HOME)"/.i3
	install -pm 0644 -- i3/* "$(HOME)"/.i3

install-less :
	install -pm 0644 -- less/lesskey "$(HOME)"/.lesskey
	command -v lesskey && lesskey

install-mutt :
	install -m 0755 -d -- \
		"$(HOME)"/.muttrc.d \
		"$(HOME)"/.cache/mutt
	install -pm 0644 -- mutt/muttrc "$(HOME)"/.muttrc
	install -pm 0755 -- mutt/muttrc.d/src "$(HOME)"/.muttrc.d

install-ncmcpp :
	install -m 0755 -d -- "$(HOME)"/.ncmpcpp
	install -pm 0644 -- ncmpcpp/config "$(HOME)"/.ncmpcpp/config

install-newsbeuter :
	install -m 0755 -d -- \
		"$(HOME)"/.config/newsbeuter \
		"$(HOME)"/.local/share/newsbeuter
	install -pm 0644 -- newsbeuter/config "$(HOME)"/.config/newsbeuter/config

install-mysql :
	install -pm 0644 -- mysql/my.cnf "$(HOME)"/.my.cnf

install-ksh : check-ksh install-sh
	install -m 0755 -d -- \
		"$(HOME)"/.shrc.d \
		"$(HOME)"/.kshrc.d
	install -pm 0644 -- ksh/shrc.d/* "$(HOME)"/.shrc.d
	install -pm 0644 -- ksh/kshrc "$(HOME)"/.kshrc
	install -pm 0644 -- ksh/kshrc.d/* "$(HOME)"/.kshrc.d

install-perlcritic :
	install -pm 0644 -- perlcritic/perlcriticrc "$(HOME)"/.perlcriticrc

install-perltidy :
	install -pm 0644 -- perltidy/perltidyrc "$(HOME)"/.perltidyrc

install-psql :
	install -pm 0644 -- psql/psqlrc "$(HOME)"/.psqlrc

install-readline :
	install -pm 0644 -- readline/inputrc "$(HOME)"/.inputrc

install-sh : check-sh
	install -m 0755 -d -- \
		"$(HOME)"/.profile.d \
		"$(HOME)"/.shrc.d
	install -pm 0644 -- sh/profile "$(HOME)"/.profile
	install -pm 0644 -- sh/profile.d/* "$(HOME)"/.profile.d
	install -pm 0644 -- sh/shinit "$(HOME)"/.shinit
	install -pm 0644 -- sh/shrc "$(HOME)"/.shrc
	install -pm 0644 -- sh/shrc.d/* "$(HOME)"/.shrc.d

install-subversion :
	install -m 0755 -d -- "$(HOME)"/.subversion
	install -pm 0644 -- subversion/config "$(HOME)"/.subversion/config

install-terminfo :
	for info in terminfo/*.info ; do \
		tic -- "$$info" ; \
	done

install-tmux : tmux/tmux.conf install-terminfo
	install -pm 0644 -- tmux/tmux.conf "$(HOME)"/.tmux.conf

install-urxvt : urxvt/ext/select check-urxvt
	install -m 0755 -d -- "$(HOME)"/.urxvt/ext
	for name in urxvt/ext/* ; do \
		case $$name in \
			*.pl) ;; \
			*) install -m 0644 -- "$$name" "$(HOME)"/.urxvt/ext ;; \
		esac \
	done

install-vim : install-vim-config \
	install-vim-plugins \
	install-vim-pathogen

install-gvim : install-vim \
	install-gvim-config

install-vim-config :
	install -pm 0644 -- vim/vimrc "$(HOME)"/.vimrc

install-gvim-config :
	install -pm 0644 -- vim/gvimrc "$(HOME)"/.gvimrc

install-vim-plugins : install-vim-config
	find vim/after vim/bundle -name .git -prune -o \
		-type d -exec sh -c 'install -m 0755 -d -- \
			"$(HOME)"/."$$1"' _ {} \; -o \
		-type f -exec sh -c 'install -m 0644 -- \
			"$$1" "$(HOME)"/."$$1"' _ {} \;

install-vim-pathogen : install-vim-plugins
	install -m 0755 -d -- "$(HOME)"/.vim/autoload
	rm -f -- "$(HOME)"/.vim/autoload/pathogen.vim
	ln -s -- ../bundle/pathogen/autoload/pathogen.vim \
		"$(HOME)"/.vim/autoload/pathogen.vim

install-x :
	install -m 0755 -d -- \
		"$(HOME)"/.config \
		"$(HOME)"/.xinitrc.d \
		"$(HOME)"/.Xresources.d
	install -pm 0644 -- X/redshift.conf "$(HOME)"/.config/redshift.conf
	install -pm 0644 -- X/xbindkeysrc "$(HOME)"/.xbindkeysrc
	install -pm 0644 -- X/xinitrc "$(HOME)"/.xinitrc
	install -pm 0644 -- X/xinitrc.d/* "$(HOME)"/.xinitrc.d
	install -pm 0644 -- X/Xresources "$(HOME)"/.Xresources
	install -pm 0644 -- X/Xresources.d/* "$(HOME)"/.Xresources.d

install-yash : check-yash install-sh
	install -m 0755 -d -- "$(HOME)"/.yashrc.d
	install -pm 0644 -- yash/yash_profile "$(HOME)"/.yash_profile
	install -pm 0644 -- yash/yashrc "$(HOME)"/.yashrc
	install -pm 0644 -- yash/yashrc.d/* "$(HOME)"/.yashrc.d

install-zsh : check-zsh install-sh
	install -m 0755 -d -- \
		"$(HOME)"/.profile.d \
		"$(HOME)"/.zshrc.d
	install -pm 0644 -- zsh/profile.d/* "$(HOME)"/.profile.d
	install -pm 0644 -- zsh/zprofile "$(HOME)"/.zprofile
	install -pm 0644 -- zsh/zshrc "$(HOME)"/.zshrc
	install -pm 0644 -- zsh/zshrc.d/* "$(HOME)"/.zshrc.d

check : check-bash \
	check-bin \
	check-games \
	check-man \
	check-sh \
	check-urxvt

check-bash :
	check/bash

check-bin : $(BINS)
	check/bin

check-games : $(GAMES)
	check/games

check-man :
	check/man

check-ksh :
	check/ksh

check-sh :
	check/sh

check-urxvt :
	check/urxvt

check-yash :
	check/yash

check-zsh :
	check/zsh

lint : check \
	lint-bash  \
	lint-bin  \
	lint-games  \
	lint-ksh  \
	lint-sh  \
	lint-urxvt \
	lint-yash

lint-bash :
	lint/bash

lint-bin : $(BINS)
	lint/bin

lint-games : $(GAMES)
	lint/games

lint-ksh :
	lint/ksh

lint-sh :
	lint/sh

lint-urxvt :
	lint/urxvt

lint-yash :
	lint/yash
