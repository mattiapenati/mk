SHELL=/bin/bash

help:
	@echo "Help:"
	@echo "  clean    remove the downloaded files and eventualy the logs"
	@echo "  install  install all the gcc-glibc toolchains combinations"

install:
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) --options="4.9"
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) --options="5"
	@"${mkPrefix}"/bin/mkpkg $(mkFlags) --options="6"

clean:
	@rm -vf *.{tar.{bz2,gz,xz},zip,tgz}
	@rm -vf *.log
