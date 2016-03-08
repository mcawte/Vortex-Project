% Plot Vortices

TruePSI = load('Data/512/100.mat');

PSI = TruePSI.PSI;

Vortex_Grid_Nordic = fNordic(PSI, Kx, Ky, Vtrap);
Noisey_Vortex_Grid_Nordic = fNordic(NoiseyPSI, Kx, Ky, Vtrap);

subplot(121)
imagesc(x,x,Vortex_Grid_Nordic);
set(gca,'ydir','normal')
title('Field Formulation Pure PSI')
axis square
subplot(122)
imagesc(x,x,Noisey_Vortex_Grid_Nordic)
title('Field Formulation Noisey PSI')
set(gca,'ydir','normal')
axis square
% subplot(133)
% imagesc(x,x,Vortex_Grid_Plaquette)
% title('Plaquette')
% set(gca,'ydir','normal')
% axis square


