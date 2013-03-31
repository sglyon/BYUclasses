* load the data
use "C:\Users\lyon4\Documents\Econ 588\Homework\HW3\Stata\Problem 10", clear

*** part a (note I saved x, y to data set)
* gen y = log(cost)
* gen x = log(output)

reg y x

*** part b 
xtset firm 
reg y x d1 d2 d3 d4 d5 d6, noconstant
* Chow test
test d1=d2=d3=d4=d5=d6=0

*(fixed effects estimator - within groups)
xtreg y x, fe
estimates store fixed

*** Part c (between groups estimator)
xtreg y x, be

*** part d (regular effects)
xtreg y x, re
estimates
estimates store random

*** Hausman test fixed vs random
hausman fixed random
