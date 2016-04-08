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
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) openblas
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) blacs
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) scalapack
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) tbb
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) fftw
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) glpk
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) qhull
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) qrupdate
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) metis
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) scotch
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) suitesparse
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) mumps
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) superlu
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) eigen
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) lis
