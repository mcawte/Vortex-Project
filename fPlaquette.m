function [Vortex_Grid] = fPlaquette(PSI)

% Plaquette Vortex Counter
% This method calculates the phase jumps around each grid square. Upon
% completion, it sums the number of phase jumps to determine if there is a
% vortex there and it's sign.

 
 PhaseofPSI = angle(PSI);
 
 [X,Y] = size(PSI);
 
 Vortex_Grid = zeros(X,Y);


 
 for ii = 1:X-1  
   for jj = 1:Y-1
       
       Alpha1 = PhaseofPSI(ii,jj);
       Beta1 = PhaseofPSI(ii,jj+1);
       m = 0;
       
       if Beta1 - Alpha1 > pi;
          m = m -1;
       elseif Beta1 - Alpha1 < -pi;
          m = m + 1;
       end
       
       Alpha2 = PhaseofPSI(ii,jj+1);
       Beta2 = PhaseofPSI(ii+1,jj+1);
       
         if Beta2 - Alpha2 > pi;
          m = m -1;
       elseif Beta2 - Alpha2 < -pi;
          m = m + 1;
       end
       
       
       Alpha3 = PhaseofPSI(ii+1,jj+1);
       Beta3 = PhaseofPSI(ii+1,jj);
       
         if Beta3 - Alpha3 > pi;
          m = m -1;
       elseif Beta3 - Alpha3 < -pi;
          m = m + 1;
       end
       
       
       Alpha4 = PhaseofPSI(ii+1,jj);
       Beta4 = PhaseofPSI(ii,jj);
       
         if Beta4 - Alpha4 > pi;
          m = m -1;
       elseif Beta4 - Alpha4 < -pi;
          m = m + 1;
         end
       
       Vortex_Grid(ii,jj) = m;
       
   end  
 end
end

