help:
	@echo "The current available targets are:"
	@echo "  gcc48_glibc gcc49_glibc gcc51_glibc"
	@echo "    The GNU toolchain based on GCC, GlibC and Binutils."

gcc48_glibc:
	cd gcc+glibc; bash PKGBUILD 4.8

gcc49_glibc:
	cd gcc+glibc; bash PKGBUILD 4.9

gcc51_glibc:
	cd gcc+glibc; bash PKGBUILD 5.1

clean:
	find . -mindepth 2 -maxdepth 2 -type d -exec rm -rf {} \;

distclean: clean
	rm -rfv */*.tar.bz2 */*.tar.gz */*.tar.xz
