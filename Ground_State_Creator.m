% 2D GPE Ground State Creator. This evolves the ground state density with 
% no phase space imprinting.
 clear all
 close
 clc
 mkdir ./Data;

% Real space configuration

Points = 10;
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

% Order Parameter configuration


density = 2 - V;
g = 1;
PSI = real(sqrt(density)); 
InitialNatoms = sum(sum(abs(PSI.^2))).*DeltaX.^2;


% Loop to solve dynamics and plot the solution

for ii = 1:Steps;
 
% The third oder Baker Hausdorff with -iTime is called   
 PSI = Baker_Hausdorff_Oh3_iTime(PSI,k,g,V,DeltaT);
 
% PSI is renormalized to keep the right number density in order to get 
% the right ground state.
  
Natoms = sum(sum(abs(PSI.^2))).*DeltaX.^2;
PSI = (sqrt(InitialNatoms)/sqrt(Natoms)) .* PSI;

% Save and Plotting code
 if floor(ii/1000) == ii/1000
     save(['./Data/' num2str(ii/1000) '.mat'],'PSI')

    subplot(131)
    imagesc(x,x,abs(PSI).^2);
    set(gca,'ydir','normal')
    title('Density')
    subplot(132)
    imagesc(x,x,angle(PSI))
    title('Phase')
    set(gca,'ydir','normal')
    drawnow
    pause(0.01);

 end


end



