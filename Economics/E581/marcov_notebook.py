# -*- coding: utf-8 -*-
# <nbformat>3.0</nbformat>

# <markdowncell>

# # Spencer Lyon
#
# ## Econ 581 homework 6: Recursive models and Markov processes
#
# ### 1
#
# We are given the following
#
# * $Y_t = A K_t ^{\theta}$
# * $K_{t+1} = I_t$
# * $C_t = Y_t - I_t$
# * $u(C) = ln(c)$
#
# We can now write the Bellman equation
#
# $$V(K) = \max_{K} ln(AK^{\theta} - K') + \beta  V(K')$$
#
# The *first order condition* is $u'(c) = \beta * V'(K')$
#
# >(if you substitute $K' = I = Y - C$ you get a neagive sign on the $V'$ term.
#    Then set equal to zero and solve for $u'(c)$)
#
# The *envelope condition* is $V'(k) = u'(c) A \theta K^{\theta - 1}$
#
# This makes the *Euler Equation* become $u'(c) = \beta u'(c) A
#                                         \theta K^{\theta - 1}$
#
# With log utility $u'(c) = \frac{1}{c}$
#
# The simplified *Euler equation* is $$\frac{C'}{C} =
#                                      \theta \beta A K'^{\theta - 1}$$
#
#





# <codecell>


