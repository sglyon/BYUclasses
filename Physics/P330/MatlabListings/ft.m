% function to calculate the Fourier Transform of St
function f = ft(St,dt)

    f = length(St)*fftshift(ifft(ifftshift(St)))*dt/sqrt(2*pi);

return
