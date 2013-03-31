* load the data
use "C:\Users\lyon4\Documents\Econ 588\Homework\HW3\Stata\Problem 9", clear

* Do the commands from the homework explanation
reg y d1 d2 d3

xtgls y x, i(code)

xtgls y x d1 d2 d2, i(code)

xtreg y x, fe i(code)

xtreg y x, be i(code)

xtreg y x, re i(code)

