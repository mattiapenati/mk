SHELL=/bin/bash
mkFlags?=

help:
	@echo "Help:"
	@echo "  clean    remove the downloaded files and eventualy the logs"
	@echo "  install  install the base package for the loaded toolchain"

clean:
	@rm -vf */*.{tar.{bz2,gz,xz},zip,tgz}
	@find . -name \*.log -exec rm -v '{}' \;
	@rm -vf readline/readline??-???

install:
	test -n "${mkToolchainBase}" && test -d "${mkToolchainBase}"
	rm -rf "${mkToolchainBase}"/*
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) make
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) diffutils
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) findutils
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) sed
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) m4
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) libtool
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) flex
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) bison
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) db
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) gdbm
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) perl
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) gmp
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) mpfr
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) mpc
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) gawk
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) autoconf
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) pkgconf
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) ncurses
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) readline
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) gawk
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) automake
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) zlib
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) gzip
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) bzip2
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) xz
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) tar
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) texinfo
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) pcre
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) grep
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) libffi
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) expat
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) sqlite
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) openssl
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) libssh2
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) python
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) lua
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) tcl
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) swig
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) sphinx
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) icu
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) libxml2
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) libidn
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) curl
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) libarchive
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) cmake
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) subversion
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) git
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) mercurial
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) sharutils
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) vim
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) emacs
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) libevent
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) tmux
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) htop
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) gdb
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) hwloc
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) openmpi
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) valgrind
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) openmpi
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) patchelf
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) pax-utils
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) unrar
	@"${mkPrefix}"/bin/mkpkg $(mkFlags)
