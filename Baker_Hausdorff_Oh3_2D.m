function PSI = Baker_Hausdorff_Oh3_2D(PSI,ksquareon2,g,V,DeltaT)
% Third order Baker Hausdorff Method for 2D GPE

% This goes like N/2 > D > N/2 > PSI

% This function splits up the time evolution of PSI. The time evolution
% equation is i hbar dPSI/dt = L PSI, where L = Dhat + Nhat. The Dhat part
% corresponds to the -hbar^2/2m del^2 term and the Nhat part to the g * 
% |PSI|^2 terms. 

% This method is a 3rd order method, and so it operates Nhat/2 on PSI first,
% then Dhat on the result, then Nhat/2 on PSI again for the final result.

% The form of this equation is i dPSI/dt = (-1/2 grad^2 + V + ...
% |PSI|^2 - 1 ) PSI. The k^2 for the fourier grad^2 is passed to this
% function having already been squared and divided by 2, to save doing the
% same operation over and over.

% First Nhat/2 is operated on PSI.
PSI = exp(-1i*(g*abs(PSI).^2 + V -1) * DeltaT/2) .* PSI ;

%Note the -1 here (= -mu) to remove the trivial phase dependence.

% Next Dhat is operated on the result. This is happens in k-space so it
% needs to be fourier transformed back to real space.
PSI = ifft2(exp( -1i .* ksquareon2 * DeltaT) .* fft2(PSI));

% Now Nhat/2 is applied again and the result is returned.

PSI = exp(-1i*(g*abs(PSI).^2 + V -1) * DeltaT/2) .* PSI;

end


