SHELL?=/u/sw/bin/bash
mkFlags?=

help:
	@echo "Help:"
	@echo "  clean    remove the downloaded files and eventualy the logs"
	@echo "  install  install the base package for the loaded toolchain"

clean:
	@rm -vf */*.{tar.{bz2,gz,xz},zip,tgz}
	@find . -name \*.log -exec rm -v '{}' \;
	@rm -vf readline/readline??-???
	@rm -vf bash/bash??-???
	@rm -vf openssl/certdata.txt

install:
	@test -n "${mkToolchainBase}" && test -d "${mkToolchainBase}"
	@rm -rf "${mkToolchainBase}"/*
	@mkpkg $(mkFlags) make
	@mkpkg $(mkFlags) diffutils
	@mkpkg $(mkFlags) findutils
	@mkpkg $(mkFlags) sed
	@mkpkg $(mkFlags) m4
	@mkpkg $(mkFlags) libtool
	@mkpkg $(mkFlags) flex
	@mkpkg $(mkFlags) bison
	@mkpkg $(mkFlags) db
	@mkpkg $(mkFlags) gdbm
	@mkpkg $(mkFlags) perl
	@mkpkg $(mkFlags) gmp
	@mkpkg $(mkFlags) mpfr
	@mkpkg $(mkFlags) mpc
	@mkpkg $(mkFlags) gawk
	@mkpkg $(mkFlags) autoconf
	@mkpkg $(mkFlags) automake
	@mkpkg $(mkFlags) pkgconf
	@mkpkg $(mkFlags) ncurses
	@mkpkg $(mkFlags) readline
	@mkpkg $(mkFlags) gawk
	@mkpkg $(mkFlags) bash
	@mkpkg $(mkFlags) zlib
	@mkpkg $(mkFlags) gzip
	@mkpkg $(mkFlags) bzip2
	@mkpkg $(mkFlags) xz
	@mkpkg $(mkFlags) tar
	@mkpkg $(mkFlags) texinfo
	@mkpkg $(mkFlags) pcre
	@mkpkg $(mkFlags) grep
	@mkpkg $(mkFlags) libtool
	@mkpkg $(mkFlags) libffi
	@mkpkg $(mkFlags) expat
	@mkpkg $(mkFlags) sqlite
	@mkpkg $(mkFlags) openssl
	@mkpkg $(mkFlags) libssh2
	@mkpkg $(mkFlags) python
	@mkpkg $(mkFlags) lua
	@mkpkg $(mkFlags) tcl
	@mkpkg $(mkFlags) swig
	@mkpkg $(mkFlags) sphinx
	@mkpkg $(mkFlags) icu
	@mkpkg $(mkFlags) libxml2
	@mkpkg $(mkFlags) libidn
	@mkpkg $(mkFlags) curl
	@mkpkg $(mkFlags) libarchive
	@mkpkg $(mkFlags) cmake
	@mkpkg $(mkFlags) subversion
	@mkpkg $(mkFlags) git
	@mkpkg $(mkFlags) mercurial
	@mkpkg $(mkFlags) sharutils
	@mkpkg $(mkFlags) vim
	@mkpkg $(mkFlags) emacs
	@mkpkg $(mkFlags) libevent
	@mkpkg $(mkFlags) tmux
	@mkpkg $(mkFlags) htop
	@mkpkg $(mkFlags) gdb
	@mkpkg $(mkFlags) libnl
	@mkpkg $(mkFlags) hwloc
	@mkpkg $(mkFlags) openmpi
	@mkpkg $(mkFlags) valgrind
	@mkpkg $(mkFlags) openmpi
	@mkpkg $(mkFlags) patchelf
	@mkpkg $(mkFlags) chrpath
	@mkpkg $(mkFlags) pax-utils
	@mkpkg $(mkFlags) unrar
	@mkpkg $(mkFlags)
