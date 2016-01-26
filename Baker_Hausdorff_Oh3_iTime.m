function PSIn_iTime = Baker_Hausdorff_Oh3_iTime(PSI,k,g,V,DeltaT)
% Third order symmetry Baker Hausdorff Method with -iDeltaT

BhatPSI = exp(-(g*2*abs(PSI).^2 + V -2) * DeltaT/2) .* PSI ;
%Note the -1 here (= -mu) to remove the trivial phase dependence.

phi = exp(  -k.^2 * DeltaT) .* fft2(BhatPSI);

ABhatPSI = ifft2(phi);

PSIn_iTime = exp(-(g*2*abs(ABhatPSI).^2 + V -2) * DeltaT/2) .* ABhatPSI ;
%Same here as above 

end


