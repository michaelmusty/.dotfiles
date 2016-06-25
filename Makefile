.PHONY : all \
	clean \
	distclean \
	install \
	install-abook \
	install-bash \
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

all : gnupg/gpg.conf

clean distclean :
	rm -f \
		gnupg/gpg.conf \
		man/man7/dotfiles.7 \
		tmux/tmux.conf

gnupg/gpg.conf : gnupg/gpg.conf.m4
	m4 -D DOTFILES_HOME="$(HOME)" \
		gnupg/gpg.conf.m4 > gnupg/gpg.conf

man/man7/dotfiles.7 : README.markdown man/man7/dotfiles.7.header
	cat man/man7/dotfiles.7.header README.markdown | \
		pandoc -sS -t man -o "$@"

TMUX_COLOR := colour237

tmux/tmux.conf : tmux/tmux.conf.m4
	m4 -D TMUX_COLOR="$(TMUX_COLOR)" \
		tmux/tmux.conf.m4 > tmux/tmux.conf

install : install-bash \
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
	install -pm 0644 -- bash/bash_completion "$(HOME)"/.config/bash_completion

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

install-games : test-games install-games-man
	install -m 0755 -d -- "$(HOME)"/.local/games
	install -m 0755 -- games/* "$(HOME)"/.local/games

install-games-man :
	install -m 0755 -d -- "$(HOME)"/.local/share/man/man6
	install -pm 0644 -- man/man6/*.6 "$(HOME)"/.local/share/man/man6

install-git :
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

install-maildir :
	install -m 0755 -d -- \
		"$(HOME)"/Mail/inbox/cur \
		"$(HOME)"/Mail/inbox/new \
		"$(HOME)"/Mail/inbox/tmp \
		"$(HOME)"/Mail/sent/cur \
		"$(HOME)"/Mail/sent/new \
		"$(HOME)"/Mail/sent/tmp

install-mutt : install-maildir
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
		"$(HOME)"/.xbackgrounds \
		"$(HOME)"/.Xresources.d
	install -pm 0644 -- X/redshift.conf "$(HOME)"/.config/redshift.conf
	install -pm 0644 -- X/backgrounds/* "$(HOME)"/.xbackgrounds
	install -pm 0644 -- X/xbindkeysrc "$(HOME)"/.xbindkeysrc
	install -pm 0644 -- X/xinitrc "$(HOME)"/.xinitrc
	install -pm 0644 -- X/Xresources "$(HOME)"/.Xresources
	install -pm 0644 -- X/Xresources.d/* "$(HOME)"/.Xresources.d

install-zsh :
	install -pm 0644 -- zsh/zprofile "$(HOME)"/.zprofile
	install -pm 0644 -- zsh/zshrc "$(HOME)"/.zshrc

test : test-bash test-bin test-games test-sh test-urxvt

test-bash :
	@for bash in bash/* bash/bashrc.d/* bash/bash_profile.d/* ; do \
		if [ -f "$$bash" ] && ! bash -n "$$bash" ; then \
			exit 1 ; \
		fi \
	done
	@printf 'All bash(1) scripts parsed successfully.\n'

test-bin :
	@for bin in bin/* ; do \
		if sed 1q "$$bin" | grep -q 'bash$$' ; then \
			bash -n "$$bin" || exit 1 ; \
		elif sed 1q "$$bin" | grep -q 'sh$$' ; then \
			sh -n "$$bin" || exit 1 ; \
		fi ; \
	done
	@printf 'All shell scripts in bin parsed successfully.\n'

test-games :
	@for game in games/* ; do \
		if sed 1q "$$game" | grep -q 'bash$$' ; then \
			bash -n "$$game" || exit 1 ; \
		elif sed 1q "$$game" | grep -q 'sh$$' ; then \
			sh -n "$$game" || exit 1 ; \
		fi ; \
	done
	@printf 'All shell scripts in games parsed successfully.\n'

test-sh :
	@for sh in sh/* sh/profile.d/* ; do \
		if [ -f "$$sh" ] && ! sh -n "$$sh" ; then \
			exit 1 ; \
		fi \
	done
	@printf 'All sh(1) scripts parsed successfully.\n'

test-urxvt :
	@for perl in urxvt/ext/* ; do \
		perl -c "$$perl" >/dev/null || exit 1 ; \
	done
	@printf 'All Perl scripts in urxvt/ext parsed successfully.\n'

lint : lint-sh lint-bash lint-bin lint-games lint-urxvt

lint-bash :
	find bash -type f -print -exec shellcheck -- {} \;

lint-bin :
	@for bin in bin/* ; do \
		if sed 1q "$$bin" | grep -q -- 'sh$$' ; then \
			printf '%s\n' "$$bin" ; \
			shellcheck -- "$$bin" ; \
		fi ; \
	done

lint-games :
	@for game in games/* ; do \
		if sed 1q "$$game" | grep -q -- 'sh$$' ; then \
			printf '%s\n' "$$game" ; \
			shellcheck -- "$$game" ; \
		fi ; \
	done

lint-sh :
	find sh -type f -print -exec shellcheck -- {} \;

lint-urxvt :
	find urxvt/ext -type f -print -exec perlcritic --brutal -- {} \;
