from sympy import Matrix, Symbol, diff, sin, cos

#
# This code follows the book
#
#    P. C. Matthews, Vector Calculus. Springer Verlag, London, 1998.
#

class CoordinateSystem3D:
    """
    General three-dimensioal coordinate system class.
    """

    @classmethod
    def grad(self, func):
        """
        Calculate the gradient of 'func'.
        """
        return Matrix([diff(func, self.xs[0]) / self.h[0], \
                       diff(func, self.xs[1]) / self.h[1], \
                       diff(func, self.xs[2]) / self.h[2]])

    @classmethod
    def div(self, func):
        """
        Calculate the divergence of 'func'.
        """
        return (diff(func[0] * self.h[1] * self.h[2], self.xs[0]) + \
                diff(func[1] * self.h[2] * self.h[0], self.xs[1]) + \
                diff(func[2] * self.h[0] * self.h[1], self.xs[2])) / \
                (self.h[0] * self.h[1] * self.h[2])

    @classmethod
    def curl(self, func):
        """
        Calculate the curl (rotor) of 'func'.
        """
        curl0 = diff(func[2] * self.h[2], self.xs[1]) - \
                diff(func[1] * self.h[1], self.xs[2])
        curl1 = diff(func[0] * self.h[0], self.xs[2]) - \
                diff(func[2] * self.h[2], self.xs[0])
        curl2 = diff(func[1] * self.h[1], self.xs[0]) - \
                diff(func[0] * self.h[0], self.xs[1])

        mat = Matrix([self.h[0] * curl0, \
                      self.h[1] * curl1, \
                      self.h[2] * curl2])

        return mat / (self.h[0] * self.h[1] * self.h[2])

    @classmethod
    def laplacian(self, func):
        """
        Calculate the Laplacian of 'func'.
        """
        return self.div(self.grad(func))

class CartesianCS(CoordinateSystem3D):
    """
    Cartesian coordinate system.
    """

    # Coordinate symbols.
    xs = [Symbol('x', real=True), \
          Symbol('y', real=True), \
          Symbol('z', real=True)]
    x, y, z = xs

    # Basis vectors.
    e = [Matrix([1, 0, 0]), \
         Matrix([0, 1, 0]),
         Matrix([0, 0, 1])]

    # Scale factors.
    h = [1, 1, 1]

class CylindricalCS(CoordinateSystem3D):
    """
    Cylindrical coordinate system.
    """

    # Coordinate symbols.
    xs = [Symbol('r', real=True), \
          Symbol('\\phi', real=True), \
          Symbol('z', real=True)]
    r, phi, z = xs

    # Basis vectors.
    e = [Matrix([cos(phi), \
                 sin(phi), \
                 0]), \
         Matrix([-sin(phi), \
                 cos(phi), \
                 0]),
         Matrix([0, 0, 1])]

    # Scale factors.
    h = [1, r, 1]

class SphericalCS(CoordinateSystem3D):
    """
    Spherical coordinate system.
    """

    # Coordinate symbols.
    xs = [Symbol('r', real=True), \
          Symbol('\\phi', real=True), \
          Symbol('\\theta', real=True)]
    r, phi, theta = xs

    # Basis vectors.
    e = [Matrix([sin(theta) * cos(phi), \
                 sin(theta) * sin(phi), \
                 cos(theta)]), \
         Matrix([cos(theta) * cos(phi), \
                 cos(theta) * sin(phi), \
                 -sin(theta)]),
         Matrix([-sin(phi), \
                 cos(phi), \
                 0])]

    # Scale factors.
    h = [1, r, r * sin(theta)]

class EarthCS(CoordinateSystem3D):
    """
    Earth coordinate system.
    """

    # Coordinate symbols.
    xs = [Symbol('r', real=True), \
          Symbol('\\phi', real=True), \
          Symbol('\\theta', real=True)]

    r, phi, theta = xs

    # Basis vectors.
    e = [Matrix([cos(theta) * cos(phi), \
                 cos(theta) * sin(phi), \
                 sin(theta)]), \
         Matrix([sin(theta) * cos(phi), \
                 sin(theta) * sin(phi), \
                 -cos(theta)]),
         Matrix([-sin(phi), \
                 cos(phi), \
                 0])]

    # Scale factors.
    h = [1, r, r * cos(theta)]

def vprod(x, y):
    """
    Vector product of vectors x and y.
    """
    prod1 = x[1] * y[2] - x[2] * y[1]
    prod2 = x[2] * y[0] - x[0] * y[2]
    prod3 = x[0] * y[1] - x[1] * y[0]

    return Matrix([prod1, prod2, prod3])
