import numpy as np
import matplotlib.pyplot as plt


def e2_16(s, a, b, rho):
    """
    Electric field as a function of distance from center of coaxial
    cable as described in problem 2.16

    Parameters
    ----------
    s : array_like, dtype=float
        A numpy array of s values interpreted as linear distances from
        the center of the coaxial cable

    a, b, rho : float
        The constants a, b, and rho that appear in expression for E

    Returns
    -------
    e : array_like, dtype=float, shape=s.shape
        The value of the magnitude of the electric field at each point
        in s

    """
    if s < a:
        return rho * s / (2 * eps0)

    elif a < s < b:
        return rho * a ** 2 / (2 * eps0 * s)

    else:
        return 0

a = 1.
b = 2.
rho = 1.
eps0 = 8.8542e-12

e2_16 = np.vectorize(e2_16)
s = np.linspace(.01, 2.5, 150)
e = e2_16(s, a, b, rho)
plt.xticks([0, a, b], ['0', 'a', 'b'])
plt.plot(s, e)
plt.title('E as a function of radial distance (s) for coaxial cable')
plt.xlabel('s')
plt.ylabel(r'$|E|$')
plt.savefig('./E2_16.eps', format='eps', dpi=1000)
plt.show()

