 % Nordic Vortex Counter
 clear all
 %close
 %clc
 
 Stirred_Vortices_84 = load('Data/Stirred_Vortices_84');
 
 PSI = Stirred_Vortices_84.PSI;
 
 PhaseofPSI = angle(PSI);
 
 [X,Y] = size(PSI);
 
 tic
 
r2 = X.^2 + Y.^2;
Thomas_Fermi = 20; % This number is an educated guess
Vtrap = 1/2 * r2 / Thomas_Fermi^2; 

Points = 300;
Range = 150;
DeltaX = Range/Points;

dk = (2*pi)/Range;
kmax = (2*pi)/(DeltaX);
k = (-kmax/2:dk:kmax/2 -dk);
[Kx,Ky] = meshgrid(k,k);
k = sqrt(Kx.^2 + Ky.^2);
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

Nordic_Time = toc
%Nordic_cpu = cputime

 figure
 imagesc(X,Y,Vortex_Grid)
 set(gca,'ydir','normal')
 
