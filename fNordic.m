function [ Corrected_Grid ] = fNordic(PSI,Vtrap, Kx, Ky)

 
 %PhaseofPSI = angle(PSI);
 
 %[X,Y] = size(PSI);
 

 
% 
% Kx = fftshift(Kx);
% Ky = fftshift(Ky);


% Perhaps use fourier diff


% real space version, doesn't work correctly, Try append on first
% % column/row to last for x and y to get matrices the right dimensions
% 
% PSIx = cat(2,PSI,PSI(:,1));
% PSIy = cat(1,PSI,PSI(1,:));
% 
% dx_conjPSI= diff(conj(PSIx),1,2);
% 
% dy_PSI = diff(PSIy,1,1);
% 
% Vortex_Grid = imag(dx_conjPSI * dy_PSI);
%  
% Corrected_Grid = Vortex_Grid/(1-Vtrap);

dx_conjPSI= diff(conj(PSI),1,2);
dx_conjPSI= dx_conjPSI(1:end-1,:);
dy_PSI = diff(PSI,1,1);
dy_PSI = dy_PSI(:,1:end-1);

Corrected_Grid = imag(dx_conjPSI .* dy_PSI);
%  
% Corrected_Grid = Vortex_Grid/(1-Vtrap);




% dx_conjPSI = ifft2(-1i.*Kx.*(fft2(conj(PSI))));
% 
% dy_PSI = ifft2(1i.*Ky.*(fft2(PSI)));
% 
% Corrected_Grid = imag(dx_conjPSI * dy_PSI);
  
% This is used in the Nordic paper, but it gives a bad result. Investigate.
%Corrected_Grid = Vortex_Grid/(1-Vtrap);




end

