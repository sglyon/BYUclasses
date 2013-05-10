from distutils.core import setup, Extension
import numpy

cheby = Extension('_chebyfit', ['chebyfit.c'],
                  include_dirs=[numpy.get_include()])

transformations = Extension('_transformations', ['transformations.c'],
                            include_dirs=[numpy.get_include()])


setup(name='_transformations', ext_modules=[cheby, transformations])
