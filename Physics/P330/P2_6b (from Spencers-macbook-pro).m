format shorte
N = 20;
a = zeros(20,1);
a(1) = 1;

for n=1:N-1
    a(n+1) = (n/((n - 1/2) * ( n + 1/2))) * a(n);
end

steps = 1:1:20;
figure
semilogy(steps, a, 'b')
hold on
plot(steps, exp(-steps), 'r')
plot(steps, 1./factorial(steps), 'k')
legend('Recursion', 'Exp(-n)', '1/n!')
hold off

%plot(steps, exp(steps))
%plot(steps, 1/gamma(steps -1))
