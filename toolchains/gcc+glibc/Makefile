default:

gcc48:
	bash install.sh 4.8

gcc49:
	bash install.sh 4.9

gcc51:
	bash install.sh 5.1

all: gcc48 gcc49 gcc51

clean:
	find . -mindepth 1 -maxdepth 1 -type d -exec rm -rf {} \;

distclean: clean
	rm -rfv *.tar.bz2 *.tar.gz *.tar.xz
