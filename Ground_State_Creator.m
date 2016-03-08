% 2D GPE Ground State Creator. This evolves the ground state density with 
% no phase space imprinting. The initial guess for the ground state wave
% function is the Thomas Fermi approximation. This posits that the Kinetic 
% energy term in the GPE is much less than the Potential energy term, so 
% it throws it away. This is a good approximation, but it is incorrect.

% Thomas Fermi starts with [KE + PE]PSI = mu PSI. We are left with PE PSI =
% mu PSI, where PE = V + g|PSI|^2. Getting rid of PSI on both sides leaves
% V + g|PSI|^2 = mu. Rearranging gives PSI = sqrt((mu-V)/g).

% This routine starts with that guess, and then evolves it with t = -i*t so
% that all the modes that make up PSI decay, but the ground state decays 
% the slowest. At each step, the number density is restored so that the 
% entire wavefunction does not disappear. What is left is only the ground
% state mode.

% Each time this ground state is passed to the stationary GPE, the GPE
% will return the same state times an eigenvalue. 

 clear all
 close
 clc
 mkdir ./Data/512;

% Real space configuration

Points = 512;
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
Kx = fftshift(Kx);
Ky = fftshift(Ky);

% Stirring configuration

GaussianHalfWidth = 1;
Vstir = (3*exp(-((X -8).^2 +(Y).^2)/ GaussianHalfWidth^2));

V = Vtrap + Vstir;


% Order Parameter configuration


density = 2 - V;
g = 1;
PSI = real(sqrt(density)); 
InitialNatoms = sum(sum(abs(PSI.^2))).*DeltaX.^2;



Energy = zeros(1,Steps);

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


% Save the ground state

save(['./Data/512/One_Stir8.mat'],'PSI')




