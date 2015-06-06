#!/bin/bash
# install.sh <version>
# Build the toolchain based on GCC and GlibC it needs approximately 110Mb of
# disk space for the temporary files and 200Mb for the installation.

. ../../mk/config
. ../../mk/core

set +h

# Dectect the selected version
# =============================================================================
# For compatibility reasons with must limit the version of some packages.
V=$1
case $V in
  4.8)
    GccVersion=4.8.4
    IslVersion=0.11.1
    Cloog=yes
    ;;
  4.9)
    GccVersion=4.9.2
    IslVersion=0.12.2
    Cloog=yes
    ;;
  5.1)
    GccVersion=5.1.0
    IslVersion=0.14.1
    Cloog=no
    ;;
  *)
    echo "Unsupported version '$V'"
    exit 1
    ;;
esac

M4Version=1.4.17
M4Dir=m4-$M4Version
M4Archive=$M4Dir.tar.xz
M4Url=http://ftp.gnu.org/gnu/m4/$M4Archive

BisonVersion=3.0.4
BisonDir=bison-$BisonVersion
BisonArchive=$BisonDir.tar.xz
BisonUrl=http://ftp.gnu.org/gnu/bison/$BisonArchive

TexinfoVersion=5.2
TexinfoDir=texinfo-$TexinfoVersion
TexinfoArchive=$TexinfoDir.tar.xz
TexinfoUrl=http://ftp.gnu.org/gnu/texinfo/$TexinfoArchive

GmpVersion=6.0.0
GmpDir=gmp-$GmpVersion
GmpArchive=${GmpDir}a.tar.bz2
GmpUrl=https://gmplib.org/download/gmp/$GmpArchive

MpfrVersion=3.1.2
MpfrDir=mpfr-$MpfrVersion
MpfrArchive=$MpfrDir.tar.bz2
MpfrUrl=http://www.mpfr.org/mpfr-current/$MpfrArchive

MpcVersion=1.0.3
MpcDir=mpc-$MpcVersion
MpcArchive=$MpcDir.tar.gz
MpcUrl=http://ftp.gnu.org/gnu/mpc/$MpcArchive

IslDir=isl-$IslVersion
IslArchive=$IslDir.tar.bz2
IslUrl=http://isl.gforge.inria.fr/$IslArchive

CloogVersion=0.18.1
CloogDir=cloog-$CloogVersion
CloogArchive=$CloogDir.tar.gz
CloogUrl=http://www.bastoul.net/cloog/pages/download/$CloogArchive

LibelfVersion=0.8.13
LibelfDir=libelf-$LibelfVersion
LibelfArchive=$LibelfDir.tar.gz
LibelfUrl=http://www.mr511.de/software/$LibelfArchive

LinuxVersion=$(uname -r)
case $LinuxVersion in
  2.*)
    Linux=2.6.32
    LinuxVersion=2.6.32.66
    LinuxUrl=https://www.kernel.org/pub/linux/kernel/v2.6/longterm/v2.6.32/
    ;;
  *)
    echo "Unsupported version of kernel"
    exit 1
    ;;
esac
LinuxDir=linux-$LinuxVersion
LinuxArchive=$LinuxDir.tar.xz
LinuxUrl=$LinuxUrl/$LinuxArchive

BinutilsVersion=2.25
BinutilsDir=binutils-$BinutilsVersion
BinutilsArchive=$BinutilsDir.tar.bz2
BinutilsUrl=http://ftp.gnu.org/gnu/binutils/$BinutilsArchive

GccDir=gcc-$GccVersion
GccArchive=$GccDir.tar.bz2
GccUrl=http://ftp.gnu.org/gnu/gcc/gcc-$GccVersion/$GccArchive

GlibcVersion=2.21
GlibcDir=glibc-$GlibcVersion
GlibcArchive=$GlibcDir.tar.xz
GlibcUrl=http://ftp.gnu.org/gnu/glibc/$GlibcArchive

# Create the directories hyerarchy
# =============================================================================
install -dv $PREFIX/lmod/modules/toolchains/gcc+glibc
Module=$PREFIX/lmod/modules/toolchains/gcc+glibc/$V.lua
ToolchainPrefix=$PREFIX/toolchains/gcc+glibc/$V/prefix
ToolchainBase=$PREFIX/toolchains/gcc+glibc/$V/base
ToolchainPkgs=$PREFIX/toolchains/gcc+glibc/$V/pkgs
ToolchainModules=$PREFIX/toolchains/gcc+glibc/$V/modules
Buildtools=$(mktmpdir)

rm -rf $ToolchainPrefix
install -dv $ToolchainPrefix $ToolchainBase $ToolchainPkgs $ToolchainModules

export PATH=$ToolchainPrefix/bin:$Buildtools/bin:/usr/bin:/bin

# Download and prepare
# =============================================================================
download $M4Url
extract $M4Archive

download $BisonUrl
extract $BisonArchive

download $TexinfoUrl
extract $TexinfoArchive

download $GmpUrl
extract $GmpArchive

download $MpfrUrl
extract $MpfrArchive

download $MpcUrl
extract $MpcArchive

download $IslUrl
extract $IslArchive

[[ "$Cloog" == "yes" ]] && download $CloogUrl \
                        && extract $CloogArchive

download $LibelfUrl
extract $LibelfArchive

download $LinuxUrl
extract $LinuxArchive
make -C $LinuxDir mrproper

download $BinutilsUrl
extract $BinutilsArchive
pushd $BinutilsDir
  # (2.25) https://sourceware.org/bugzilla/show_bug.cgi?id=16992
  [[ -e binutils-$BinutilsVersion.patch ]] && patch -p1 -i ../binutils-$BinutilsVersion.patch
popd

download $GccUrl
extract $GccArchive
# Link the 3rd party librariries
[[ -d $GmpDir ]] && ln -sv ../$GmpDir $GccDir/gmp
[[ -d $MpfrDir ]] && ln -sv ../$MpfrDir $GccDir/mpfr
[[ -d $MpcDir ]] && ln -sv ../$MpcDir $GccDir/mpc
[[ -d $IslDir ]] && ln -sv ../$IslDir $GccDir/isl
[[ -d $CloogDir ]] && ln -sv ../$CloogDir $GccDir/cloog
[[ -d $LibelfDir ]] && ln -sv ../$LibelfDir $GccDir/libelf
# see gcc-4.8.3-pure64_specs-1.patch in LFS
if [[ $ARCH == "x86_64" ]]; then
  # installs x86_64 libraries in PREFIX/lib
  sed -i '/m64=/s/lib64/lib/' $GccDir/gcc/config/i386/t-linux64
  # point to the correct linker
  sed -i "s:/lib64:$ToolchainPrefix/lib:g" $GccDir/gcc/config/i386/linux64.h
  # set the correct prefixes
  echo "
#define STANDARD_STARTFILE_PREFIX_1 \"$ToolchainPrefix/lib\"
#define STANDARD_STARTFILE_PREFIX_2 \"$ToolchainBase/lib\"
" >> $GccDir/gcc/config/i386/linux64.h
fi
# apply the patch
pushd $GccDir
  # (4.8) https://gcc.gnu.org/ml/gcc-patches/2013-12/msg01552.html
  [[ -e gcc-$GccVersion.patch ]] && patch -p0 -i ../gcc-$GccVersion.patch
popd

download $GlibcUrl
extract $GlibcArchive

# M4 (old versions of M4 are buggy, it is used by bison)
# =============================================================================
pushd $M4Dir
  ./configure --prefix=$Buildtools || exit 1
  make || exit 1
  make install || exit 1
popd
rm -rf $M4Dir

# Bison (used by gold in binutils)
# =============================================================================
pushd $BisonDir
  ./configure --prefix=$Buildtools || exit 1
  make || exit 1
  make install || exit 1
popd
rm -rf $BisonDir

# TexInfo (used to build the documentation)
# =============================================================================
pushd $TexinfoDir
  ./configure --prefix=$Buildtools || exit 1
  make || exit 1
  make install || exit 1
popd
rm -rf $TexinfoDir

# Binutils (host to target)
# =============================================================================
# Build a first version of binutils (using the old linker, gold disabled).

mkdir binutils-build
pushd binutils-build
  # AR="..."
  #   Some systems (RedHat) don't install the $BUILD-* binutils.
  # --build=$BUILD
  # --host=$BUILD
  # --target=$TARGET
  #   Build Binutils that runs on $BUILD and creates files for $TARGET.
  # --prefix=$Buildtools
  #   Install binutils programs in $Buildtools directory.
  # --with-sysroot=$ToolchainPrefix
  #   Tells to the build system to look in $ToolchainPrefix directory for the
  #   target libraries.
  # --with-lib-path=$ToolchainPrefix/lib
  #   Specifies which library path the linker should be configured to use.
  # --disable-nls
  #   Disables internationalization.
  # --disable-multilib
  #   This option disables the building of a multilib capable Binutils.
  # --enable-ld
  #   Enable the stanard linker.
  # --disable-gold
  #   Disable the gold linker.
  AR=$(which ar) \
  ../$BinutilsDir/configure  --build=$BUILD \
                             --host=$BUILD \
                             --target=$TARGET \
                             --prefix=$Buildtools \
                             --with-lib-path=$ToolchainPrefix/lib \
                             --disable-nls \
                             --disable-multilib \
                             --enable-ld \
                             --disable-gold || exit 1
  make || exit 1
  make install || exit 1
popd
rm -rf binutils-build

# Gcc (pass 1 - C compiler)
# =============================================================================
mkdir gcc-build
pushd gcc-build
  # --build=$BUILD
  # --host=$BUILD
  # --target=$TARGET
  #   Build GCC that runs on $BUILD and creates files for $TARGET.
  # --prefix=$Buildtools
  #   Install GCC programs in $Buildtools directory.
  # --with-native-system-header-dir=$ToolchainPrefix/include
  #   Ensures that gcc will find system headers correctly.
  # --disable-nls
  #   Disables internationalization.
  # --disable-multilib
  #   This option disables the building of a multilib capable Binutils.
  # --disable-shared
  #   Disables the shared library build.
  # --with-newlib
  #   Prevents the compiling of any code that requires libc support.
  # --without-headers
  #   This switch prevents GCC from looking for standard headers compatible
  #   with the target system
  # --disable-threads
  # --disable-decimal-float
  # --disable-libatomic
  # --disable-libcilkrts
  # --disable-libgomp
  # --disable-libitm
  # --disable-libmudflap
  # --disable-libquadmath
  # --disable-libsanitizer
  # --disable-libssp
  # --disable-libvtv
  # --disable-libstdc__-v3
  #   Disable support for unused libraries for the bootstrap.
  # --enable-languages=c,c++
  #   This option ensures that only the C and C++ compilers are built.
  ../$GccDir/configure --build=$BUILD \
                       --host=$BUILD \
                       --target=$TARGET \
                       --prefix=$Buildtools \
                       --with-native-system-header-dir=$ToolchainPrefix/include \
                       --disable-nls \
                       --disable-multilib \
                       --disable-shared \
                       --with-newlib \
                       --without-headers \
                       --disable-threads \
                       --disable-decimal-float \
                       --disable-libatomic \
                       --disable-libcilkrts \
                       --disable-libgomp \
                       --disable-libitm \
                       --disable-libmudflap \
                       --disable-libquadmath \
                       --disable-libsanitizer \
                       --disable-libssp \
                       --disable-libvtv \
                       --disable-libstdc__-v3 \
                       --enable-languages=c,c++ || exit 1
  make || exit 1
  make install || exit 1
popd
rm -rf gcc-build

# Linux headers (Linux API headers, used by the glibc)
# =============================================================================
pushd $LinuxDir
  make INSTALL_HDR_PATH=$ToolchainPrefix headers_install
popd
rm -rf $LinuxDir


# Glibc
# =============================================================================
mkdir glibc-build
pushd glibc-build
  # --build=$BUILD
  # --host=$TARGET
  # --with-binutils=$Buildtools/bin
  #   This combination enables the cross compilation, using the tools
  #   contained in $Buildtools.
  # --prefix=$ToolchainPrefix
  #   Install GLibc in $ToolchainPrefix directory.
  # --with-headers=$ToolchainPrefix/include
  # --enable-kernel=$Linux
  #   Compiles the GLibc using the headers just installed.
  # --enable-add-ons
  #   Compiles the extensions.
  # --disable-profile
  #   This builds the libraries without profiling information.
  # --enable-obsolete-rpc
  #   This installs NIS and RPC related headers that are not installed by
  #   default. They are required to build other libraries.
  # libc_cv_ssp=no
  #   Seems to be required to bootstrap a cross compiler.
  #   https://sourceware.org/ml/libc-alpha/2012-09/msg00093.html
  # libc_cv_forced_unwind=yes
  #   Seems to be required to bootstrap a cross compiler.
  ../$GlibcDir/configure --build=$BUILD \
                         --host=$TARGET \
                         --with-binutils=$Buildtools/bin \
                         --prefix=$ToolchainPrefix \
                         --with-headers=$ToolchainPrefix/include \
                         --enable-kernel=$Linux \
                         --enable-add-ons \
                         --disable-profile \
                         --enable-obsolete-rpc \
                         libc_cv_ssp=no \
                         libc_cv_forced_unwind=yes || exit 1
  make || exit 1
  make install || exit 1
popd
rm -rf glibc-build
rm -rf $GlibcDir

# Libstdc++ (used by gold)
# =============================================================================
mkdir gcc-build
pushd gcc-build
  # CC="..." CXX="..."
  #   Use the just installed compilers with the new libraries.
  # --build=$BUILD
  # --host=$TARGET
  #   This combination enables the cross compilation.
  # --prefix=$ToolchainPrefix
  #   Install stdc++-v3 in $ToolchainPrefix directory.
  # --with-gxx-include-dir=$Buildtools/$TARGET/include/c++/$GccVersion
  #   This is the location where the standard include files are searched by
  #   the C++ compiler.
  # --disable-nls
  #   Disables internationalization.
  # --disable-multilib
  #   Avoids 32 libraries.
  # --disable-libstdcxx-pch
  #   This switch prevents the installation of precompiled include files.
  CC="$TARGET-gcc -isystem $ToolchainPrefix/include -B$ToolchainPrefix/lib" \
  CXX="$TARGET-g++ -isystem $ToolchainPrefix/include -B$ToolchainPrefix/lib" \
  ../$GccDir/libstdc++-v3/configure --build=$BUILD \
                                    --host=$TARGET \
                                    --prefix=$ToolchainPrefix \
                                    --with-gxx-include-dir=$Buildtools/$TARGET/include/c++/$GccVersion \
                                    --disable-nls \
                                    --disable-multilib \
                                    --disable-libstdcxx-pch || exit 1
  make || exit 1
  make install || exit 1
popd
rm -rf gcc-build

# Binutils (native)
# =============================================================================
mkdir binutils-build
pushd binutils-build
  # CC="..." CXX="..." AR="..." RANLIB="..."
  #   Use the just installed compilers with the new libraries.
  # --build=$BUILD
  # --host=$TARGET
  #   This combination enables the cross compilation.
  # --prefix=$ToolchainPrefix
  #   Install binutils programs in $ToolchainPrefix directory.
  # --disable-multilib
  #   This option disables the building of a multilib capable Binutils.
  # --enable-ld
  # --enable-gold
  #   Enables both the standard and Google linker.
  CC="$TARGET-gcc -isystem $ToolchainPrefix/include -B$ToolchainPrefix/lib" \
  CXX="$TARGET-g++ -isystem $ToolchainPrefix/include -B$ToolchainPrefix/lib" \
  AR="$TARGET-ar" \
  RANLIB="$TARGET-ranlib" \
  ../$BinutilsDir/configure --build=$BUILD \
                            --host=$TARGET \
                            --with-pkgversion=$PKGVERSION \
                            --prefix=$ToolchainPrefix \
                            --with-lib-path="$ToolchainPrefix/lib:$ToolchainBase/lib" \
                            --disable-multilib \
                            --enable-ld \
                            --enable-gold \
                            --enable-plugins \
                            --disable-werror || exit 1
  make || exit 1
  make install || exit 1
popd
rm -rf binutils-build
rm -rf $BinutilsDir

# Adjust the linker (to use gold!) and some objects
# =============================================================================
rm -v $ToolchainPrefix/bin/ld
ln -sv ld.bfd $ToolchainPrefix/bin/ld
# ln -sv ld.gold $ToolchainPrefix/bin/ld
# during the GCC compile stage these objects are necessary
ln -sv ../../lib/crt1.o $ToolchainPrefix/$TARGET/lib/crt1.o
ln -sv ../../lib/crti.o $ToolchainPrefix/$TARGET/lib/crti.o
ln -sv ../../lib/crtn.o $ToolchainPrefix/$TARGET/lib/crtn.o

# Gcc (final)
# =============================================================================
mkdir gcc-build
pushd gcc-build
  CC="$TARGET-gcc -isystem $ToolchainPrefix/include -B$ToolchainPrefix/lib" \
  CXX="$TARGET-g++ -isystem $ToolchainPrefix/include -B$ToolchainPrefix/lib" \
  ../$GccDir/configure --build=$TARGET \
                       --prefix=$ToolchainPrefix \
                       --with-local-prefix=$ToolchainBase \
                       --with-pkgversion="$PKGVERSION" \
                       --disable-multilib \
                       --enable-shared \
                       --enable-threads=posix \
                       --enable-__cxa_atexit \
                       --enable-lto \
                       --enable-libgomp \
                       --disable-libstdcxx-pch \
                       --enable-languages=c,c++ \
                       --disable-bootstrap  || exit 1
  make || exit 1
  make install || exit 1
popd
rm -rf gcc-build
rm -rf $GccDir
rm -rf $LibelfDir $CloogDir $IslDir $MpcDir $MpfrDir $GmpDir

# create cc link (used by cmake)
ln -sv gcc $ToolchainPrefix/bin/cc
ln -sv $TARGET-gcc $ToolchainPrefix/bin/$TARGET-cc

# link time optimization
install -v -dm755 $ToolchainPrefix/lib/bfd-plugins
ln -sfv ../../libexec/gcc/$TARGET/$GccVersion/liblto_plugin.so $ToolchainPrefix/lib/bfd-plugins/

# Cleaning
# =============================================================================
rm -rf $Buildtools
rm -v $ToolchainPrefix/$TARGET/lib/crt{1,i,n}.o
strip_unneeded $ToolchainPrefix
compress_manpages $ToolchainPrefix/share/man
clean_empty_dirs $ToolchainPrefix

# Module
# =============================================================================
cat > $Module << EOF
-- -*- lua -*-
help([[
This module load the toolchain based on GCC $V and the GLibC. Moreover it
contains all the base package for the development, for the details about the
software installed see the main documentation.
]])

-- commands and libraries
prepend_path("PATH", "$ToolchainPrefix/bin")
prepend_path("PATH", "$ToolchainBase/bin")

-- documentation
prepend_path("MANPATH", "$ToolchainPrefix/share/man")
prepend_path("MANPATH", "$ToolchainBase/share/man")
prepend_path("INFOPATH", "$ToolchainPrefix/share/info")
prepend_path("INFOPATH", "$ToolchainBase/share/info")

-- configuration
prepend_path("PKG_CONFIG_PATH", "$ToolchainBase/lib/pkgconfig")
prepend_path("ACLOCAL_PATH", "$ToolchainBase/share/aclocal")

-- module
family("toolchain")

prepend_path("MODULEPATH", "$ToolchainModules")

setenv("mkToolchainPrefix", "$ToolchainPrefix")
setenv("mkToolchainBase", "$ToolchainBase")
setenv("mkToolchainModules", "$ToolchainModules")
setenv("mkToolchainPkgs", "$ToolchainPkgs")
EOF
