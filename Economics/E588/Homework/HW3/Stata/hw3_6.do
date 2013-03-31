use "C:\Users\ryneb\Dropbox\school\Winter 2013\Econ 588\HW\3\S&P500.dta", clear
rename x y

*a.  investigate the distributional characteristics of the return data
sum y,detail

*b
reg y
predict e, resid
*b (1) (a)
gen t = _n
tset t
estat dwatson

*b (1) (b)
gen lag1 = e[_n-1]
reg e lag1

*b (2)
runtest e


*b (3)
estat archlm, lags(1)
estat archlm, lags(14) 

*c
arch y, arch(1)
arch y, arch(14)
