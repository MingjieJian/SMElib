#! /bin/bash

UNAME="$(uname -s)"

if [[ "$UNAME" == "Darwin" ]]; then
    # ---------- macOS ----------
    BREW_PREFIX="$(brew --prefix)"
    export PATH="$BREW_PREFIX/opt/libtool/bin:$BREW_PREFIX/bin:$PATH"
    export ACLOCAL_PATH="$BREW_PREFIX/share/aclocal"

    GCC_MAJOR="$(brew list --versions gcc | awk '{print $2}' | cut -d. -f1)"
    export CC="gcc-${GCC_MAJOR}"
    export CXX="g++-${GCC_MAJOR}"
    export FC="gfortran-${GCC_MAJOR}"

    export CPPFLAGS="-I${BREW_PREFIX}/opt/gcc/include"
    export LDFLAGS="-L${BREW_PREFIX}/opt/gcc/lib/gcc/${GCC_MAJOR} \
                    -Wl,-install_name,@rpath/libsme.dylib \
                    -Wl,-rpath,@loader_path"

    echo "[setenv] macOS detected  ➜  GCC $GCC_MAJOR, install_name=@rpath/libsme.dylib"
elif [[ "$UNAME" == "Linux" ]]; then
    # ---------- Linux: do nothing ----------
    true
else
    echo "Unknown platform: $UNAME" >&2
    exit 1
fi

autoreconf --verbose --install --symlink

./configure --prefix=$PWD

make install

mkdir lib_flat
rsync -aL lib/ lib_flat/
rm -r lib
mv lib_flat lib

if [[ "$UNAME" == "Darwin" ]]; then
    # ---------- macOS ----------
    cp -nf "$BREW_PREFIX/opt/gcc/lib/gcc/$GCC_MAJOR/libstdc++.6.dylib" lib/
    cp -nf "$BREW_PREFIX/opt/gcc/lib/gcc/$GCC_MAJOR/libgfortran.5.dylib" lib/
elif [[ "$UNAME" == "Linux" ]]; then
    # ---------- Linux ----------
    cp -nf "$(gcc -print-file-name=libgfortran.so)" lib/
fi