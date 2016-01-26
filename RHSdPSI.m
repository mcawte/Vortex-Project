function [ dPSI_dt ] = RHSdPSI(PSI,k,g)



BhatPSI = g*(abs(PSI).^2) .* PSI ; 

AhatPSI = 1/2 * ifft2(k.^2 .* fft2(PSI)); 

dPSI_dt = -1i*(AhatPSI + BhatPSI);


end

