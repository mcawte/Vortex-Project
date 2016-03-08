% Create phase imprinted order parameters to test circulation

 clear all
 close
 clc
 

% Real space configuration

Points = 128;
Range = 150;
DeltaX = Range/Points;
x = linspace(-Range/2,Range/2 - DeltaX,Points);
[X,Y] = meshgrid(x,x);


% Potential configuration

r2 = X.^2 + Y.^2;
Thomas_Fermi = 20; % This number is an educated guess
V = 1/2 * r2 / Thomas_Fermi^2; 

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


% Phase imprinted vortices using pervious ground state density

phase = 1*atan2(Y,X);% -atan2(Y+2,X); % Can make circulation more than 1 
% here by multiplying the atan2 since this is only a phase imprinting. But
% will phase imprinting work with the Nordic method, since it uses density
% information?

density = 2 - V;
g = 1;

PSI = real(sqrt(density)) .*exp(1i*phase);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Energy = zeros(1,Steps);
InitialNatoms = sum(sum(abs(PSI.^2))).*DeltaX.^2;


% evolve ground state to get density right

% The 2D third oder Baker Hausdorff with t set to -i*t is called   
 PSI = Baker_Hausdorff_Oh3_iTime(PSI,ksquareon2,g,V,DeltaT);
 
% PSI is now renormalized to keep the right number density correct so that
% the whole thing does not decay away entirely.
  
Natoms = sum(sum(abs(PSI.^2))).*DeltaX.^2;
PSI = (sqrt(InitialNatoms)/sqrt(Natoms)) .* PSI;

Energy(1,1) = GPE_Energy_2D(PSI,k,g,V,DeltaT);

  
PSI = Baker_Hausdorff_Oh3_iTime(PSI,ksquareon2,g,V,DeltaT); 
Natoms = sum(sum(abs(PSI.^2))).*DeltaX.^2;
PSI = (sqrt(InitialNatoms)/sqrt(Natoms)) .* PSI;

Energy(1,2) = GPE_Energy_2D(PSI,k,g,V,DeltaT);

ii = 2;

while Energy(1,ii-1) - Energy(1,ii) > 0.000001;
    
    ii = ii + 1;
 
% The 2D third oder Baker Hausdorff with t set to -i*t is called   
 PSI = Baker_Hausdorff_Oh3_iTime(PSI,ksquareon2,g,V,DeltaT);
 
% PSI is now renormalized to keep the right number density correct so that
% the whole thing does not decay away entirely.
  
Natoms = sum(sum(abs(PSI.^2))).*DeltaX.^2;
PSI = (sqrt(InitialNatoms)/sqrt(Natoms)) .* PSI;

Energy(1,ii) = GPE_Energy_2D(PSI,k,g,V,DeltaT);
end



%save(['./Data/Ground_state_grid_' num2str(Points) '.mat'],'PSI')

%Vortex_Grid = fNordic(PSI,V, Kx, Ky);
Vortex_Grid = fOtago(PSI);
%Vortex_Grid = fPlaquette(PSI);

subplot(2,2,1)
imagesc(x,x,abs(PSI).^2);
set(gca,'ydir','normal')
title('Density')
subplot(2,2,2)
imagesc(x,x,angle(PSI))
title('Phase')
set(gca,'ydir','normal')
subplot(2,2,[3,4]);
imagesc(x,x,Vortex_Grid);
set(gca,'ydir','normal')
title('Vortices')


    