# Metadata
AC_INIT([libsme], [6.03], [nikolai.piskunov@physics.uu.se])
AC_CANONICAL_TARGET

# Use Automake
AM_INIT_AUTOMAKE([subdir-objects])
LT_INIT
AC_CONFIG_MACRO_DIRS([m4])

# ── 新增：告诉 libtool 还要处理 Fortran、探测 Fortran 运行库 ──  ### NEW
LT_LANG([Fortran])                 ### NEW
AC_PROG_FC                         ### NEW   (Autoconf ≥2.69)

# 自动把  -L... -lgfortran -lquadmath 写进 LIBS / LDFLAGS          ### NEW
AC_FC_LIBRARY_LDFLAGS              ### NEW   (Autoconf ≥2.70；旧版见下)
# 额外为 macOS 写入 rpath                                             ### NEW
AS_CASE([$host_os],                ### NEW
  [darwin*], [                     ### NEW
    FC_LIBDIR=`$FC -print-file-name=libgfortran.dylib | \             ### NEW
               sed 's:/libgfortran.*::'`                              ### NEW
    LDFLAGS="$LDFLAGS -Wl,-rpath,$FC_LIBDIR"                          ### NEW
  ])                               ### NEW

case $target_os in
    linux-gnu)
    target=linux 
    extension=.so
    outdir=libdir
    ;;
    darwin*)
    target=darwin
    extension=.dylib
    outdir=libdir
    ;;
    win32|mingw32)
    target=win32
    extension=-5.dll
    outdir=bindir
    ;;
    *) 
    target=$target_os
    extension=.so
    outdir=libdir
    ;;
esac

AC_SUBST(TARGET_CPU, $target_cpu)
AC_SUBST(TARGET, $target)
AC_SUBST(EXTENSION, $extension)
AC_SUBST(OUTPUT_DIR, $outdir)

# Find Dependecies
AC_PROG_CXX
AC_PROG_F77

# Create Makefile from Makefile.in
AC_CONFIG_FILES([Makefile])

# Create Output files
AC_OUTPUT
