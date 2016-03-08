% Make a movie
close all
clear all
clc

PSI = zeros(512,512,100);

Points = 512;
Range = 150;
DeltaX = Range/Points;
x = linspace(-Range/2,Range/2 - DeltaX,Points);
[X,Y] = meshgrid(x,x);


% Potential configuration

r2 = X.^2 + Y.^2;
Thomas_Fermi = 20; % This number is an educated guess
Vtrap = 1/2 * r2 / Thomas_Fermi^2; 


dk = (2*pi)/Range;
kmax = (2*pi)/(DeltaX);
k = (-kmax/2:dk:kmax/2 -dk);
[Kx,Ky] = meshgrid(k,k);
Kx = fftshift(Kx);
Ky = fftshift(Ky);

for ii = 1:100;
   FileName = sprintf('Data/%d.mat', ii);
   Data = load(FileName);
   PSI(:,:,ii) = Data.PSI;
   
end

Vortex_Grid = zeros(512,512,100);

for ii = 1:100;
   Vortex_Grid(:,:,ii) = fPlaquette(PSI(:,:,ii));  
end

for ii = 1:100;


     
% Natoms = sum(abs(Solutions(ii,:)).^2)*DeltaX;
% plot(x,(abs(Solutions(ii,:))))
% title(['Probability Density, N = ' num2str(Natoms) ]);
% xlabel('x axis');
% ylabel('Amplitude')
% drawnow;
% pause(0.001)
% % pause
subplot(131)
imagesc(x,x,abs(PSI(:,:,ii)).^2);
set(gca,'ydir','normal')
title('Density')
subplot(132)
imagesc(x,x,angle(PSI(:,:,ii)))
title('Phase')
set(gca,'ydir','normal')

subplot(133)
imagesc(x,x,Vortex_Grid(:,:,ii));
set(gca,'ydir','normal')
title('Density')


drawnow
pause(0.01);



 end