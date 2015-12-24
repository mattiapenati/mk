SHELL=/bin/bash
mkFlags?=

help:
	@echo "Help:"
	@echo "  clean    remove the downloaded files and eventualy the logs"
	@echo "  install  install the packages for the loaded toolchain"

clean:
	@rm -vf */*.{tar.{bz2,gz,xz},zip,tgz}
	@find . -name \*.log -exec rm -v '{}' \;

install:
	test -n "${mkToolchainBase}" && test -d "${mkToolchainBase}"
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) tbb
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) openblas
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) fftw
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) metis
