cent_list = [];
forward_list = [];
c_err =[];
f_err = [];
hvals = [];

its = 0;
h = 1;
func = inline('exp(x)', 'x');
while h > 1e-20
	cent_el = (func(1 + h) - func(1 - h)) / (2 * h);
	forward_el = (func(1 + h) - func(1))/h;
	cent_list = [cent_list cent_el];
	forward_list = [forward_list forward_el];
	c_err = [c_err abs(cent_el / exp(1) - 1)];
	f_err = [f_err abs(forward_el / exp(1) - 1)];
	hvals = [hvals h];
	h = h / 2;
end

loglog(hvals, c_err, hvals, f_err);
xlabel('h');
ylabel('errors');
legend('Centered Errors' ,'Forward Errors');

