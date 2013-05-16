from __future__ import division
from sympy import Matrix, pi, sqrt, trim, log
from sympy.mpmath import mp
from veccalc import *

# Cartesian.
cs = CartesianCS

q = 1.602176487e-19
Phi = 1 / (4 * pi) * q / sqrt(cs.x**2 + cs.y**2 + cs.z**2)
E = Matrix([1 / (4 * pi) * q * cs.x / (cs.x**2 + cs.y**2 + cs.z**2)**(3/2), \
            1 / (4 * pi) * q * cs.y / (cs.x**2 + cs.y**2 + cs.z**2)**(3/2),
            1 / (4 * pi) * q * cs.z / (cs.x**2 + cs.y**2 + cs.z**2)**(3/2)])

assert trim(E[0]) == trim(-cs.grad(Phi)[0])
assert cs.curl(E) == Matrix([0, 0, 0])
# FIXME this is really 0. How to simplify the expression using sympy?
assert cs.div(E).evalf(subs={cs.x: 1, cs.y: 2, cs.z: 3}) < mp.eps

assert cs.grad(cs.x ** 2 + cs.y ** 2) == Matrix([2 * cs.x, 2 * cs.y, 0])

assert cs.laplacian(cs.x ** 2 - cs.y ** 2) == 0

# Cylindrical.
cs = CylindricalCS

i = 2
B = Matrix([0, i / (2 * pi * cs.r), 0])
assert cs.curl(B) == Matrix([0, 0, 0])
assert cs.div(B) == 0

B = Matrix([0, i / (2 * pi) * cs.r, 0])
assert cs.curl(B) == Matrix([0, 0, i / pi])
assert cs.div(B) == 0

assert cs.laplacian(log(cs.r)) == 0

# Spherical.
for cs in [SphericalCS, EarthCS]:
    q = 1.602176487e-19
    Phi = 1 / (4 * pi) * q / cs.r
    E = Matrix([1 / (4 * pi) * q / cs.r**2, 0, 0])

    assert E == -cs.grad(Phi)
    assert cs.curl(E) == Matrix([0, 0, 0])
    assert cs.div(E) == 0

    Phi = -1 / (4 * pi) * q * cs.r ** 2 / 2
    E = Matrix([1 / (4 * pi) * q * cs.r, 0, 0])

    assert E == -cs.grad(Phi)
    assert cs.curl(E) == Matrix([0, 0, 0])
    assert cs.div(E) == q / (4 / 3 * pi)

    assert cs.laplacian(1 / cs.r) == 0

cs = CartesianCS

# Vector product.
assert vprod(cs.e[0], cs.e[1]) == cs.e[2]
assert vprod(cs.e[1], cs.e[0]) == -cs.e[2]
assert vprod(cs.e[2], cs.e[0]) == cs.e[1]
