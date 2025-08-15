from os.path import join, dirname, abspath
from distutils.core import setup, Extension
import numpy as np

libdir = abspath(join(dirname(__file__), "../lib"))
include_dirs = np.get_include()
include_dirs += [libdir]

module = Extension(
    "_smelib",
    sources=["_smelib.cpp"],
    language="c++",
    include_dirs=include_dirs,
    libraries=["sme"],
    library_dirs=[libdir],
)

setup(ext_modules=[module])

