# Problem 4.2
import sympy as sym

r, a, q, z = sym.symbols('r, a, q, z, d')
epsilon_0 = sym.symbols('epsilon_0')
pi = sym.pi

Q = 4*pi*q / (pi*a**3) * sym.integrate(sym.exp(-2*r / a) * r **2 , (r, 0, r))

print sym.latex(sym.factor(Q))

E = 1 / (4*pi*epsilon_0*r**2) * sym.factor(Q)
print sym.latex(E)

expansion = sym.simplify(sym.series(E.subs({r/a: z}), z, n=4).subs({z:r/a}))
print sym.latex(expansion)

