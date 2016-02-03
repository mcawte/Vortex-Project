% Times plotting

clear 
close all
clc

PSI_128 = load('Data/Stirred_grid_128');
PSI_256 = load('Data/Stirred_grid_256');
PSI_512 = load('Data/Stirred_grid_512');
PSI_1024 = load('Data/Stirred_grid_1024');

PSI = PSI_1024.PSI;

tstart1 = tic;
Plaquette_Vortex_Grid = fPlaquette(PSI);
Plaquette_time = toc(tstart1);

length = size(PSI);
Points = length(1)
Range = 150;
DeltaX = Range/Points;

x = linspace(-Range/2,Range/2 - DeltaX,Points);
[X,Y] = meshgrid(x,x);

dk = (2*pi)/Range;
kmax = (2*pi)/(DeltaX);
k = (-kmax/2:dk:kmax/2 -dk);
[Kx,Ky] = meshgrid(k,k);

r2 = X.^2 + Y.^2;
Thomas_Fermi = 20; % This number is an educated guess
Vtrap = 1/2 * r2 / Thomas_Fermi^2; 

tstart2 = tic;
Nordic_Vortex_Grid = fNordic(PSI,Kx,Ky,Vtrap);
Nordic_time = toc(tstart2);

tstart3 = tic;
Otago_Vortex_Grid = fOtago(PSI);
Otago_time = toc(tstart3);

Counting_Time = [Plaquette_time,Nordic_time,Otago_time]

 save(['./Data/Times_Grid_' num2str(Points) '.mat'],'Counting_Time');
