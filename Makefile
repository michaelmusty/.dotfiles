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
	install-dircolors \
	install-dotfiles-man \
	install-dunst \
	install-finger \
	install-games \
	install-games-man \
	install-git \
	install-gnupg \
	install-gtk \
	install-i3 \
	install-maildir \
	install-mutt \
	install-ncmcpp \
	install-newsbeuter \
	install-mysql \
	install-pdksh \
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
	install-gvim \
	install-vim-config \
	install-gvim-config \
	install-vim-plugins \
	install-vim-pathogen \
	install-wyrd \
	install-x \
	install-zsh \
	test \
	test-bash \
	test-bin \
	test-games \
	test-sh \
	test-urxvt \
	lint \
	lint-bash \
	lint-bin \
	lint-games \
	lint-sh \
	lint-urxvt

NAME := Tom Ryder
EMAIL := tom@sanctum.geek.nz
KEY := 0xC14286EA77BB8872
SENDMAIL := /usr/bin/msmtp

all : git/gitconfig gnupg/gpg.conf

clean distclean :
	rm -f \
		games/acq \
		games/kvlt \
		games/zs \
		git/gitconfig \
		gnupg/gpg.conf \
		man/man7/dotfiles.7 \
		mutt/muttrc \
		tmux/tmux.conf

games/acq : games/acq.sed
	bin/shb games/acq.sed sed -f > "$@"
	chmod +x "$@"

games/kvlt : games/kvlt.sed
	bin/shb games/kvlt.sed sed -f > "$@"
	chmod +x "$@"

games/zs : games/zs.sed
	bin/shb games/zs.sed sed -f > "$@"
	chmod +x "$@"

git/gitconfig : git/gitconfig.m4
	m4 \
		-D DOTFILES_NAME="$(NAME)" \
		-D DOTFILES_EMAIL="$(EMAIL)" \
		-D DOTFILES_KEY="$(KEY)" \
		-D DOTFILES_SENDMAIL="$(SENDMAIL)" \
		git/gitconfig.m4 > git/gitconfig

gnupg/gpg.conf : gnupg/gpg.conf.m4
	m4 -D DOTFILES_HOME="$(HOME)" \
		gnupg/gpg.conf.m4 > gnupg/gpg.conf

man/man7/dotfiles.7 : README.markdown man/man7/dotfiles.7.header
	cat man/man7/dotfiles.7.header README.markdown | \
		pandoc -sS -t man -o "$@"

mutt/muttrc : mutt/muttrc.m4
	m4 \
		-D DOTFILES_SENDMAIL="$(SENDMAIL)" \
		mutt/muttrc.m4 > mutt/muttrc

TMUX_COLOR := colour237

tmux/tmux.conf : tmux/tmux.conf.m4
	m4 -D TMUX_COLOR="$(TMUX_COLOR)" \
		tmux/tmux.conf.m4 > tmux/tmux.conf

install : install-bash \
	install-bash-completion \
	install-bin \
	install-curl \
	install-dircolors \
	install-git \
	install-gnupg \
	install-readline \
	install-sh \
	install-terminfo \
	install-vim

install-abook :
	install -m 0755 -d -- \
		"$(HOME)"/.abook
	install -pm 0644 -- abook/abookrc "$(HOME)"/.abook

install-bash : test-bash
	install -m 0755 -d -- \
		"$(HOME)"/.config \
		"$(HOME)"/.bashrc.d \
		"$(HOME)"/.bash_profile.d
	install -pm 0644 -- bash/bashrc "$(HOME)"/.bashrc
	install -pm 0644 -- bash/bashrc.d/* "$(HOME)"/.bashrc.d
	install -pm 0644 -- bash/bash_profile "$(HOME)"/.bash_profile
	install -pm 0644 -- bash/bash_profile.d/* "$(HOME)"/.bash_profile.d
	install -pm 0644 -- bash/bash_logout "$(HOME)"/.bash_logout

install-bash-completion : install-bash
	install -m 0755 -d -- "$(HOME)"/.bash_completion.d
	install -pm 0644 -- bash/bash_completion "$(HOME)"/.config/bash_completion
	install -pm 0644 -- bash/bash_completion.d/* "$(HOME)"/.bash_completion.d

install-bin : test-bin install-bin-man
	install -m 0755 -d -- "$(HOME)"/.local/bin
	install -m 0755 -- bin/* "$(HOME)"/.local/bin

install-bin-man :
	install -m 0755 -d -- \
		"$(HOME)"/.local/share/man/man1 \
		"$(HOME)"/.local/share/man/man8
	install -pm 0644 -- man/man1/*.1 "$(HOME)"/.local/share/man/man1
	install -pm 0644 -- man/man8/*.8 "$(HOME)"/.local/share/man/man8

install-curl :
	install -pm 0644 -- curl/curlrc "$(HOME)"/.curlrc

install-dircolors :
	install -pm 0644 -- dircolors/dircolors "$(HOME)"/.dircolors

install-dotfiles-man : man/man7/dotfiles.7
	install -m 0755 -d -- "$(HOME)"/.local/share/man/man7
	install -pm 0644 -- man/man7/*.7 "$(HOME)"/.local/share/man/man7

install-dunst : install-x
	install -m 0755 -d -- "$(HOME)"/.config/dunst
	install -pm 0644 -- dunst/dunstrc "$(HOME)"/.config/dunst

install-finger :
	install -pm 0644 -- finger/plan "$(HOME)"/.plan
	install -pm 0644 -- finger/project "$(HOME)"/.project
	install -pm 0644 -- finger/pgpkey "$(HOME)"/.pgpkey

install-games : games/acq games/kvlt games/zs test-games install-games-man
	install -m 0755 -d -- "$(HOME)"/.local/games
	for game in games/* ; do \
		case $$game in \
			*.sed) ;; \
			*) install -m 0755 -- "$$game" "$(HOME)"/.local/games ;; \
		esac \
	done

install-games-man :
	install -m 0755 -d -- "$(HOME)"/.local/share/man/man6
	install -pm 0644 -- man/man6/*.6 "$(HOME)"/.local/share/man/man6

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

install-pdksh : test-pdksh
	install -m 0755 -d -- \
		"$(HOME)"/.kshrc.d
	install -pm 0644 -- pdksh/kshrc "$(HOME)"/.kshrc
	install -pm 0644 -- pdksh/kshrc.d/* "$(HOME)"/.kshrc.d

install-maildir :
	install -m 0755 -d -- \
		"$(HOME)"/Mail/inbox/cur \
		"$(HOME)"/Mail/inbox/new \
		"$(HOME)"/Mail/inbox/tmp \
		"$(HOME)"/Mail/sent/cur \
		"$(HOME)"/Mail/sent/new \
		"$(HOME)"/Mail/sent/tmp

install-mutt : mutt/muttrc install-maildir
	install -m 0755 -d -- \
		"$(HOME)"/.mutt \
		"$(HOME)"/.cache/mutt
	install -pm 0644 -- mutt/muttrc "$(HOME)"/.muttrc
	install -pm 0644 -- mutt/signature "$(HOME)"/.signature

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

install-perlcritic :
	install -pm 0644 -- perlcritic/perlcriticrc "$(HOME)"/.perlcriticrc

install-perltidy :
	install -pm 0644 -- perltidy/perltidyrc "$(HOME)"/.perltidyrc

install-psql :
	install -pm 0644 -- psql/psqlrc "$(HOME)"/.psqlrc

install-readline :
	install -pm 0644 -- readline/inputrc "$(HOME)"/.inputrc

install-sh : test-sh
	install -m 0755 -d -- "$(HOME)"/.profile.d
	install -pm 0644 -- sh/profile "$(HOME)"/.profile
	install -pm 0644 -- sh/profile.d/* "$(HOME)"/.profile.d

install-subversion :
	install -m 0755 -d -- "$(HOME)"/.subversion
	install -pm 0644 -- subversion/config "$(HOME)"/.subversion/config

install-terminfo :
	for info in terminfo/*.info ; do \
		tic -- "$$info" ; \
	done

install-tmux : tmux/tmux.conf
	install -pm 0644 -- tmux/tmux.conf "$(HOME)"/.tmux.conf

install-urxvt : test-urxvt
	install -m 0755 -d -- "$(HOME)"/.urxvt/ext
	install -m 0755 -- urxvt/ext/* "$(HOME)"/.urxvt/ext

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
	install -m 0755 -d -- "$(HOME)"/.vim/bundle
	find vim/bundle -name .git -prune -o \
		\( -type d -print \) | \
			while IFS= read -r dir ; do \
				install -m 0755 -d -- \
					"$$dir" "$(HOME)"/.vim/"$${dir#vim/}" ; \
			done
	find vim/bundle -name .git -prune -o \
		\( -type f ! -name '.git*' -print \) | \
			while IFS= read -r file ; do \
				install -pm 0644 -- \
					"$$file" "$(HOME)"/.vim/"$${file#vim/}" ; \
			done
	for dir in vim/after/* ; do \
		install -m 0755 -d -- "$(HOME)"/.vim/after/"$${dir##*/}" ; \
		install -pm 0644 -- "$$dir"/* \
			"$(HOME)"/.vim/after/"$${dir##*/}" ; \
	done

install-vim-pathogen : install-vim-plugins
	install -m 0755 -d -- "$(HOME)"/.vim/autoload
	rm -f -- "$(HOME)"/.vim/autoload/pathogen.vim
	ln -s -- ../bundle/pathogen/autoload/pathogen.vim \
		"$(HOME)"/.vim/autoload/pathogen.vim

install-wyrd :
	install -pm 0644 -- wyrd/wyrdrc "$(HOME)"/.wyrdrc

install-x :
	install -m 0755 -d -- \
		"$(HOME)"/.config \
		"$(HOME)"/.Xresources.d
	install -pm 0644 -- X/redshift.conf "$(HOME)"/.config/redshift.conf
	install -pm 0644 -- X/xbindkeysrc "$(HOME)"/.xbindkeysrc
	install -pm 0644 -- X/xinitrc "$(HOME)"/.xinitrc
	install -pm 0644 -- X/Xresources "$(HOME)"/.Xresources
	install -pm 0644 -- X/Xresources.d/* "$(HOME)"/.Xresources.d

install-zsh :
	install -pm 0644 -- zsh/zprofile "$(HOME)"/.zprofile
	install -pm 0644 -- zsh/zshrc "$(HOME)"/.zshrc

test : test-bash test-bin test-games test-man test-sh test-urxvt

test-bash :
	test/bash

test-bin :
	test/bin

test-games :
	test/games

test-pdksh :
	test/pdksh

test-man :
	test/man

test-sh :
	test/sh

test-urxvt :
	test/urxvt

lint : lint-bash lint-bin lint-games lint-sh lint-urxvt

lint-bash :
	lint/bash

lint-bin :
	lint/bin

lint-games :
	lint/games

lint-sh :
	lint/sh

lint-urxvt :
	lint/urxvt
