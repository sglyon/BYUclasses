x=0:.01:5;
f = zeros(size(x));

for i=1:length(x)
    if x(i) <1
        f(i) = exp(x(i));
    else
        f(i) = exp(1) * cos(x(i) - 1);
    end
end

plot(x,f, 'y.')
xlabel('f(x)')
ylabel('y')
