import numpy as np
import cython

cimport cython
cimport numpy as np

DTYPE = np.float

ctypedef np.float_t DTYPE_t



@cython.boundscheck(False)
def monteCarlo(unsigned int sims, unsigned int pers):
    """
    Cython implementation of a monteCarlo simulation
    """
    cdef np.ndarray[DTYPE_t, ndim=2] marco2, marco3, y2, y3
    cdef np.ndarray[DTYPE_t, ndim=1] g2, g3, epsilon

    marco2 = np.array([[0.9, 0.1],
                       [0.5, 0.5]], dtype=DTYPE).cumsum(1)

    marco3 = np.array([[0.5, 0.45, 0.05],
                       [0.05, 0.85, 0.10],
                       [0.25, 0.25, 0.5]]).cumsum(1)

    y2 = np.zeros([sims, pers], dtype=DTYPE)
    y3 = np.zeros([sims, pers], dtype=DTYPE)
    g2 = np.array([0.01, -0.03], dtype=DTYPE)
    g3 = np.array([0.02, 0.01, -0.03], dtype=DTYPE)

    cdef float sigma = 0.02
    cdef unsigned int sim, t
    cdef unsigned int s2, s3

    cdef DTYPE_t rand_num
    for sim in xrange(sims):

        epsilon = np.random.normal(0, sigma, pers)
        s2 = 0
        s3 = 0

        for t in xrange(1, pers):
            rand_num = np.random.rand()
            y2[sim, t] = g2[s2] + y2[sim, t - 1] + epsilon[t]
            y3[sim, t] = g3[s3] + y3[sim, t - 1] + epsilon[t]
            s2 = <unsigned int> np.where(marco2[<unsigned int> s2, :] > rand_num)[0][0]
            s3 = <unsigned int> np.where(marco3[<unsigned int> s3, :] > rand_num)[0][0]

    return [y2, y3]
