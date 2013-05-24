import sympy as sym

y, z, d, lamb, pi, e0 = sym.symbols('y, z, d, lamb, pi, e0 ')

expr = lamb / (4 * pi * e0) * sym.log((y**2 + (z + d) **2) / (y**2 + (z-d)**2))

print('\\ve_0 * dv/dz: ')
sym.pprint(-e0 * expr.diff(z))
print(sym.latex(-e0 * expr.diff(z)))

print('\n\n\n\n \\ve_0 * dv/dz at z=0: ')
sym.pprint(-e0 * expr.diff(z).subs({z:0}))
print(sym.latex(-e0 * expr.diff(z).subs({z:0})))
