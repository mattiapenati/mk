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
	@rm -vf bash/bash??-???

install:
	test -n "${mkToolchainBase}" && test -d "${mkToolchainBase}"
	rm -rf "${mkToolchainBase}"/*
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) make
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) diffutils
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) m4
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) libtool
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) flex
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) bison
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) db
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) gdbm
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) perl
	@"${mkPrefix}"/bin/bash shebang "${mkToolchainPrefix}"/bin /usr/bin/perl "${mkToolchainBase}"/bin/perl
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) gmp
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) mpfr
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) mpc
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) gawk
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) autoconf
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) pkgconf
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) ncurses
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) readline
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) gawk
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) bash
	@"${mkPrefix}"/bin/bash shebang "${mkToolchainPrefix}"/bin /bin/bash "${mkToolchainBase}"/bin/bash
	@"${mkPrefix}"/bin/bash shebang "${mkToolchainPrefix}"/bin /bin/sh "${mkToolchainBase}"/bin/sh
	@"${mkPrefix}"/bin/bash shebang "${mkToolchainPrefix}"/libexec/gcc/*/*/install-tools /bin/sh "${mkToolchainBase}"/bin/sh
	@"${mkPrefix}"/bin/bash shebang "${mkToolchainBase}"/bin /bin/bash "${mkToolchainBase}"/bin/bash
	@"${mkPrefix}"/bin/bash shebang "${mkToolchainBase}"/bin /bin/sh "${mkToolchainBase}"/bin/sh
	@"${mkPrefix}"/bin/bash shebang "${mkToolchainBase}"/share/libtool /bin/sh "${mkToolchainBase}"/bin/sh
	@"${mkPrefix}"/bin/bash shebang "${mkToolchainBase}"/share/libtool/build-aux /bin/sh "${mkToolchainBase}"/bin/sh
