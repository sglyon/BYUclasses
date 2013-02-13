*MLE
*GED
clear
cap prog drop GED
program define GED
version 1.0
args lnf xb s p
quietly replace `lnf'=ln(abs(`p'))-((abs($ML_y1-`xb')/`s')^(abs(`p')))-ln(2*`s')-lngamma((abs(1/`p')))
end

clear
*infile y x using "C:\Documents and Settings\jcook5\Desktop\american.dat"
infile y x using "C:\Documents and Settings\jcook5\Desktop\martin.dat"
ml model lf GED (y=x) (s:)(p:), technique(dfp)
ml search
ml maximize

*Normal
cap prog drop normalpdf
program define normalpdf
version 1.0
args lnf mu sigma
quietly replace `lnf'=ln(normalden($ML_y1,`mu',`sigma'))
end
ml model lf normalpdf (y=x) (sigma:), technique(dfp)
ml search
ml maximize, difficult

*Production Functions
*CES
nl(ly={g}+({M}/{rho})*log({d}*l**{rho}+(l-{d})*k**{rho})) initial(g l M l rho .5 d .5)
