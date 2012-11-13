global P r b

P = 10;
r = 28;
b = 8/3;
time = [0, 250];
u0 = ones(3, 1);

options = odeset('RelTol', 1e-8);
[t,u] = ode45('lorenz_rhs',time, u0);

x = u(:, 1);
y = u(:, 2);
z = u(:, 3);

subplot(221)
plot(x,y,'-');
xlabel('x(t)');
ylabel('y(t)');
title('Phase Plane Portrait for Lorenz attractor -- y(t) vs. x(t)');

subplot(222)
plot(x,z,'-');
xlabel('x(t)');
ylabel('z(t)');
title('Phase Plane Portrait for Lorenz attractor -- z(t) vs. x(t)');

subplot(223)
plot(y,z,'-');
xlabel('y(t)');
ylabel('z(t)');
title('Phase Plane Portrait for Lorenz attractor -- z(t) vs. y(t)');

figure
plot3(x,y,z,'-')
xlabel('x(t)');
ylabel('y(t)');
zlabel('z(t)');
title('3D phase portrait of Lorenz Attractor');