## Problem 3.10
import sympy as sym

y, z, d, lamb, pi, e0 = sym.symbols('y, z, d, lamb, pi, e0 ')

expr = lamb / (4 * pi * e0) * sym.log((y**2 + (z + d) **2) / (y**2 + (z-d)**2))

print('\\ve_0 * dv/dz: ')
sym.pprint(-e0 * expr.diff(z))
print(sym.latex(-e0 * expr.diff(z)))

print('\n\n\n\n \\ve_0 * dv/dz at z=0: ')
sym.pprint(-e0 * expr.diff(z).subs({z:0}))
print(sym.latex(-e0 * expr.diff(z).subs({z:0})))

## Problem 3.14
import sympy as sym
x, y, V_0, a, epsilon_0 = sym.symbols('x, y, V_0, a, epsilon_0')
pi, sin, sinh, atan = (sym.pi, sym.sin, sym.sinh, sym.atan)

V_xy = 2 * V_0 / pi * atan(sin(pi*y/a) / sinh(pi*x/a))
sigma = -epsilon_0 * V_xy.diff(x)
print(sym.latex(sym.trigsimp(sym.simplify(sigma))))
print(sym.latex(sym.trigsimp(sym.simplify(sigma).subs({x:0}))))
