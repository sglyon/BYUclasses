% Put the code solving the equation above. The code below assumes
% that you have evenly spaced time steps with the following variables
% te -> time array
% xe -> angle theta
% wp -> the pumping frequency
% A -> the pumping amplitude
% l1 -> the main swing length
% l2 -> the head-to-middle and middle-to-foot length

tau = te(2) - te(1);
L = l1 + l2;

for istep=1:length(te)

    % Position of swing relative to the pivot
    xswing = l1 * sin(xe(istep));
    yswing = -l1 * cos(xe(istep));

    % position of head/legs with respect to swing
    phi = A + A * sin(wp * te(istep));
    xpers = l2 * sin(phi);
    ypers = l2 * cos(phi);

    % Plot the swing and the swinger
    plot([0, xswing],[L, L + yswing],...
         [xswing + xpers, xswing - xpers], [L + yswing - ypers, L + yswing + ypers])

    % Make the x and y dimensions scale equally
    axis([-L/2 L/2 0 L])
    axis square

    % We'd like the plots frames to show at intervals of tau so the movie
    % matches the physical time scale.  However, the calculations
    % and plotting take some time, so we decrease the pause a bit.
    % Depending on the speed of your computer, you may need to adjust
    % this offset some.
    pause(tau - 0.01)
end