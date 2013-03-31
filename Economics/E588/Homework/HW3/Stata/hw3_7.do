use "C:\Users\ryneb\Dropbox\school\Winter 2013\Econ 588\HW\3\MROZ.DTA", clear

*a (1)
reg lwage educ exper expersq
est store regone
*a (2)
ivregress 2sls lwage exper expersq (educ = fatheduc)
est store regtwo
*a (3)
ivregress 2sls lwage exper expersq (educ = motheduc fatheduc)
est store regthree

*b TODO
*compare the results of (1), (2), and (3).  comment on relative merits of each.  
*Which estimates would you feel most comfortable with and why?

*c 
*compare results from (1) and (3) using a Hausman test
hausman regthree regone


*d
*	(1) calculate the OLS residuals obtained from regressing education on 
*	experience, experience^2, mother’s education, and father’s education;
reg educ exper expersq motheduc fatheduc
predict e, res

* 	(2) include these residuals as a potential regressor in the equation
*	of interest (the log wage equation)
*TODO

*	(3) perform a test of the statistical significance
*	of the corresponding coefficient
*TODO

*	Perform this test and compare the results with those
*	obtained from the Hausman Test

