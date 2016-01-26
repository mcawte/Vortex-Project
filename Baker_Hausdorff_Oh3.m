function PSIn = Baker_Hausdorff_Oh3(PSI,k,g,V,DeltaT)
% Third order symmetry Baker Hausdorff Method

BhatPSI = exp(-1i*(g*2*abs(PSI).^2 + V -2) * DeltaT/2) .* PSI ;
%Note the -1 here (= -mu) to remove the trivial phase dependence.

phi = exp( -1i .* k.^2 * DeltaT) .* fft2(BhatPSI);

ABhatPSI = ifft2(phi);

PSIn = exp(-1i*(g*2*abs(ABhatPSI).^2 + V -2) * DeltaT/2) .* ABhatPSI ;
%Same here as above 

end


