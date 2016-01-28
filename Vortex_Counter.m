% Vortex Counter
% This needs to calculate the phase around each lattice point. If the phase
% winds by 2pi, there is a vortex there.

 clear all
 close
 clc
 
 Stirred_Vortices_84 = load('Data/Stirred_Vortices_84');
 
 PSI = Stirred_Vortices_84.PSI;
 
 [X,Y] = size(PSI);
 
Grid = zeros(X,Y);

 
 TotalWind = 2*pi;
 
 for ii = 2:X-2
    
   for jj = 2:Y-2
      
       Wind = (imag(PSI(ii-1,jj-1))) + (imag(PSI(ii-1,jj))) + ...
           (imag(PSI(ii-1,jj+1))) + (imag(PSI(ii+1,jj+1))) + ...
           (imag(PSI(ii+1,jj+1))) + (imag(PSI(ii+1,jj))) + ...
           (imag(PSI(ii+1,jj-1))) + (imag(PSI(ii,jj-1)));
       
       if 2*pi < Wind
        
           Grid(ii,jj) = 1;
           
       end
       
       
   end
     
     
 end

 figure
 imagesc(X,Y,Grid)