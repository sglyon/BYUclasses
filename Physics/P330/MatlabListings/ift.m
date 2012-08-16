% function to calculate the inverse Fourier Transform of Sw
function f = ift(Sw,dw)

    f = fftshift(fft(ifftshift(Sw)))*dw/sqrt(2*pi);

return
