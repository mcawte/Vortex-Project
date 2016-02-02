% Vortex comparison script


 clear all
 close
 clc

 % put in config info here, pass to ground state creator, get ground state
 % back, pass to vortex stirer. Get stirred order parameter back, pass to
 % counters, get times back, plot graph.
 
% Real space configuration

Points = 128;
Range = 150;
DeltaX = Range/Points;
x = linspace(-Range/2,Range/2 - DeltaX,Points);
[X,Y] = meshgrid(x,x);


% Potential configuration

r2 = X.^2 + Y.^2;
Thomas_Fermi = 20; % This number is an educated guess
Vtrap = 1/2 * r2 / Thomas_Fermi^2; 


% Time step configuration
DeltaT = 0.001;
Time = 100;
Steps = floor(Time/DeltaT);


% K space configuration
dk = (2*pi)/Range;
kmax = (2*pi)/(DeltaX);
k = (-kmax/2:dk:kmax/2 -dk);
[Kx,Ky] = meshgrid(k,k);
k = sqrt(Kx.^2 + Ky.^2);
k = fftshift(k);
ksquareon2 = k.^2 /2;

% Stirring configuration

GaussianHalfWidth = 1;
Vstir = 3*exp(-((X -8).^2 +(Y).^2)/ GaussianHalfWidth^2);

V = Vtrap + Vstir;
velocity = 1;
CurrentTime = 0;


% Order Parameter configuration


density = 2 - V;
g = 1;
PSI = real(sqrt(density)); 
InitialNatoms = sum(sum(abs(PSI.^2))).*DeltaX.^2;

Energy = GPE_Energy_2D(PSI,k,g,V,DeltaT);

[PSI, Energy] = fGround_State_Creator(PSI,ksquareon2,g,V,DeltaT, ...
    InitialNatoms, Points, Energy, DeltaX, k);


% Stir the pot
for ii = 1:Steps;
    
% This uses the third oder Baker Hausdorff    
 PSI = Baker_Hausdorff_Oh3_2D(PSI,ksquareon2,g,V,DeltaT);
 

% Update the stirrer

CurrentTime = CurrentTime + DeltaT;
Vstir = 3*exp(-((X -8*cos((velocity*CurrentTime)/8)).^2 + ...
    (Y - 8*sin((velocity*CurrentTime)/8)).^2)/ GaussianHalfWidth^2);

V = Vtrap + Vstir;
end

save(['./Data/Stirred_grid_' num2str(Points) '.mat'],'PSI');

Plaquette_time = fPlaquette(PSI);
Nordic_time = fNordic(PSI,Kx,Ky,Vtrap);
Otago_time = fOtago(PSI);

Counting_Time = [Plaquette_time,Nordic_time,Otago_time]

save(['./Data/Times_Grid_' num2str(Points) '.mat'],'Counting_Time');




