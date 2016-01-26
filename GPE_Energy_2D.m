function Energy = GPE_Energy_2D(PSI,k,g,V,DeltaT)

% This function returns the energy of the 2D gpe solution.


Energy = abs(conj(PSI) .* ifft2(k.^2 .* fft2(PSI)) ...
    + V .* abs(PSI).^2 g.*abs(PSI).^4;

%BhatPSI = exp(-(g*2*abs(PSI).^2 + V -2) * DeltaT/2) .* PSI ;

% mu needs to be removed.

%Note the -1 here (= -mu) to remove the trivial phase dependence.

end


