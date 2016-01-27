function PSI = Baker_Hausdorff_Oh3_2D(PSI,k,g,V,DeltaT)
% Third order symmetry Baker Hausdorff Method for 2D GPE

% This goes like N/2 D N/2

%This function splits up the time evolution of PSI. The time evolution
%equation is i hbar dPSI/dt = L PSI, where L = Dhat + Nhat. This method is
%a 3rd order method, and so it operates Nhat/2 on PSI first, then Dhat on
%the result, then Nhat/2 on PSI again for the final result.

% First Nhat/2 is operated on PSI.
PSI = exp(-1i*(g*2*abs(PSI).^2 + V -2) * DeltaT/2) .* PSI ;

%Note the -1 here (= -mu) to remove the trivial phase dependence.

% Next Dhat is operated on the result. This is happens in k-space so it
% needs to be fourier transformed back to real space.
PSI = ifft2(exp( -1i .* k.^2 * DeltaT) .* fft2(PSI));

% Now Nhat/2 is applied again.

PSI = exp(-1i*(g*2*abs(PSI).^2 + V -2) * DeltaT/2) .* PSI;

end


