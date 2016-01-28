function PSIn_iTime = Baker_Hausdorff_Oh3_iTime(PSI,ksquareon2,g,V,DeltaT)
% Third order symmetry Baker Hausdorff Method with -iDeltaT

BhatPSI = exp(-(g*abs(PSI).^2 + V -1) * DeltaT/2) .* PSI ;
%Note the -1 here (= -mu) to remove the trivial phase dependence.

phi = exp(-ksquareon2 * DeltaT) .* fft2(BhatPSI);

ABhatPSI = ifft2(phi);

PSIn_iTime = exp(-(g*abs(ABhatPSI).^2 + V -1) * DeltaT/2) .* ABhatPSI ;
%Same here as above 

end


