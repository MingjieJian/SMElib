AUTOMAKE_OPTIONS = foreign

ACLOCAL_AMFLAGS = -I m4

CXXLD = $(F77)

lib_LTLIBRARIES = libsme.la
libsme_la_SOURCES = \
	src/sme/platform.h \
	src/sme/sme_synth_faster.h \
	src/sme/sme_synth_faster.cpp \
	src/eos/eos.f \
	src/eos/eos_eqns.f \
	src/eos/eos_math_special.f \
	src/eos/kp_q_spln.f \
	src/sme/hlinop.f \
	src/sme/hlinprof.f
libsme_la_LDFLAGS = -fPIC -version-info 5:22:0 -shared -no-undefined
libsme_la_CPPFLAGS = -fPIC -shared -O3
libsme_la_FFLAGS = -fPIC -shared -O3
libsme_la_LIBADD = -lc -lm -lstdc++ -lgfortran

if MACOS
	libsme_la_LDFLAGS += -Wl,-rpath,@loader_path -Wl,-install_name,@rpath/libsme.5.dylib
endif

dist_pkgdata_DATA = src/data/bpo_self.grid.INTEL \
	src/data/Fe1_Bautista2017.dat.INTEL \
	src/data/Fe1_Zatsarinny2019.dat.INTEL \
	src/data/NH_Stancil2018.dat.INTEL \
	src/data/stehle_long.dat.INTEL \
	src/data/vcsbalmer.dat

BUILT_SOURCES = src/sme/platform.h old_link $(top_srcdir)/.version

CLEANFILES = src/sme/platform.h

EXTRA_DIST = $(top_srcdir)/.version



PLATFORM = @TARGET@
MACHINE = @TARGET_CPU@
BITS = 64
SHL_EXT = "$(PLATFORM).$(MACHINE).$(BITS)"

DATA_DIR = @datadir@/libsme/

src/sme/platform.h:
	echo '#define PLATFORM "$(PLATFORM)"' > src/sme/platform.h
	echo '#define DATA_DIR "$(DATA_DIR)"' >> src/sme/platform.h

old_link: libsme.la
	$(MKDIR_P) $(@OUTPUT_DIR@) && cd $(@OUTPUT_DIR@) && $(LN_S) -f libsme@EXTENSION@ sme_synth.so.$(SHL_EXT)

flib_name:
	echo libgfortran*@EXTENSION@

flib_source:
	$(F77) --print-file-name=libgfortran@EXTENSION@

flib_target:
	echo $(@OUTPUT_DIR@)/libgfortran@EXTENSION@

$(top_srcdir)/.version:
	echo '$(VERSION)' > $@-t
	mv $@-t $@
dist-hook:
	echo '$(VERSION)' > $(distdir)/.tarball-version

if MACOS
	install-data-hook:
		install_name_tool -id @rpath/libsme.5.dylib $(DESTDIR)$(libdir)/libsme.5.dylib
endif