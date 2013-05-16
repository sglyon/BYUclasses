from __future__ import division
import numpy as np
import sympy as sym
from veccalc import CartesianCS


def my_xyzvec(vec):
    msg = '\\xyzvec{'
    msg += sym.latex(vec[0])
    msg += '}{'
    msg += sym.latex(vec[1])
    msg += '}{'
    msg += sym.latex(vec[2])
    msg += '}'
    return msg


def prob1_25(part=1):
    cs = CartesianCS
    x, y, z = sym.symbols('x, y, z')
    A = sym.Matrix([cs.x, 2*cs.y, 3*cs.z])
    B = sym.Matrix([3 * cs.y, -2 * cs.x, 0])

    print('\\item \\curl{A} = $%s$' % my_xyzvec(cs.curl(A)))
    print('\\item \\curl{B} = $%s$' % my_xyzvec(cs.curl(B)))
    print('\\item \\diver{A} = $%s$' % sym.latex(cs.div(A)))
    print('\\item \\diver{B} = $%s$' % sym.latex(cs.div(B)))


    if part == 1:
        lhs = cs.div(A.cross(B))
        print('lhs = %s' % sym.latex(lhs))
        t1 = B.dot(cs.curl(A))
        print('B dot (curl(A): %s' %sym.latex(t1))
        t2 = A.dot(cs.curl(B))
        print('A dot (curl(B): %s' % sym.latex(t2))
        rhs = t1 - t2
        print('B dot curl(A) - A dot curl(B): %s' % sym.latex(rhs))

    if part == 2:
        lhs = cs.grad(A.dot(B))
        print('lhs = %s' % sym.latex(lhs))
        t1 = B.dot(cs.curl(A))
        print('B dot (curl(A): %s' %sym.latex(t1))
        t2 = A.dot(cs.curl(B))
        print('A dot (curl(B): %s' % sym.latex(t2))
        rhs = t1 - t2
        print('B dot curl(A) - A dot curl(B): %s' % sym.latex(rhs))







# Mathematica code to generate plots in problem 1.32 description


# g1 = Graphics3D[{Arrow[{p1a, p2a}], Arrow[{p2a, p3a}],
#     Arrow[{p3a, p4a}], {PointSize[Large], Pink, Point[{1, 1, 1}]}},
#    Ticks -> Automatic, Axes -> True];
# g2 = Graphics3D[{Arrow[{p1b, p2b}], Arrow[{p2b, p3b}],
#     Arrow[{p3b, p4b}], {PointSize[Large], Pink, Point[{1, 1, 1}]}},
#    Ticks -> Automatic, Axes -> True];
# g3 = ParametricPlot3D[{u, u, u^2}, {u, 0, 1}, PlotStyle -> Thick];
# grid = GraphicsGrid[{{g1, g2, g3}}, ImageSize -> {1000, 300}]
# Export["/Users/spencerlyon2/School/BYU/byuclasses/Physics/P441/Homework/HW2/paths.png", grid]

