function [ Nordic_Time ] = fNordic(PSI,Kx,Ky,Vtrap)

 tstart = tic
 PhaseofPSI = angle(PSI);
 
 [X,Y] = size(PSI);
 

 

Kx = fftshift(Kx);
Ky = fftshift(Ky);


% Perhaps use fourier diff


% real space version, doesn't work correctly, Try append on first
% column/row to last for x and y to get matrices the right dimensions
% dx_conjPSI= diff(conj(PSI),1,2);
% 
% dy_PSI = diff(PSI,1,1);
% 
% Vortex_Grid = imag(dx_conjPSI .* dy_PSI);
%  
% Corrected_Grid = Vortex_Grid/(1-Vtrap);

dx_conjPSI = ifft2(-1i.*Kx.*(fft2(conj(PSI))));

dy_PSI = ifft2(1i.*Ky.*(fft2(PSI)));

Vortex_Grid = imag(dx_conjPSI .* dy_PSI);
  
Corrected_Grid = Vortex_Grid/(1-Vtrap);

Nordic_Time = toc(tstart)



end

