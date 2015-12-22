SHELL=/bin/bash
mkFlags?=

help:
	@echo "Help:"
	@echo "  clean    remove the downloaded files and eventualy the logs"

clean:
	@rm -vf */*.{tar.{bz2,gz,xz},zip,tgz}
	@find . -name \*.log -exec rm -v '{}' \;
