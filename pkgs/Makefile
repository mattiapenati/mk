SHELL?=/u/sw/bin/bash
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
	@mkpkg $(mkFlags) boost
	@mkpkg $(mkFlags) tbb
	@mkpkg $(mkFlags) openblas
	@mkpkg $(mkFlags) blacs
	@mkpkg $(mkFlags) scalapack
	@mkpkg $(mkFlags) arpack
	@mkpkg $(mkFlags) fftw
	@mkpkg $(mkFlags) glpk
	@mkpkg $(mkFlags) qhull
	@mkpkg $(mkFlags) qrupdate
	@mkpkg $(mkFlags) metis
	@mkpkg $(mkFlags) scotch
	@mkpkg $(mkFlags) p4est
	@mkpkg $(mkFlags) suitesparse
	@mkpkg $(mkFlags) mumps
	@mkpkg $(mkFlags) superlu
	@mkpkg $(mkFlags) hypre
	@mkpkg $(mkFlags) eigen
	@mkpkg $(mkFlags) lis
	@mkpkg $(mkFlags) cgal
	@mkpkg $(mkFlags) scipy
	@mkpkg $(mkFlags) hdf5
	@mkpkg $(mkFlags) netcdf
	@mkpkg $(mkFlags) matio
	@mkpkg $(mkFlags) petsc
	@mkpkg $(mkFlags) trilinos
	@mkpkg $(mkFlags) octave
	@mkpkg $(mkFlags) R
	@mkpkg $(mkFlags) dealii
	@mkpkg $(mkFlags) fenics
