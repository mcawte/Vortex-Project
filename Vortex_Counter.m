% Vortex Counter
% This needs to calculate the phase around each lattice point. If the phase
% winds by 2pi, there is a vortex there.

 clear all
 close
 clc
 
 Stirred_Vortices_84 = load('Data/Stirred_Vortices_84');
 
 PSI = Stirred_Vortices_84.PSI;
 
 PhaseofPSI = angle(PSI);
 phase_old = PhaseofPSI;
 
 
 [X,Y] = size(PSI);
 
Grid = zeros(X,Y);

 
 TotalWind = 2*pi;
%  
%  for ii = 2:X-2  
%    for jj = 2:Y-2
%        Wind = (angle(PSI(ii-1,jj-1))) + (angle(PSI(ii-1,jj))) + ...
%            (angle(PSI(ii-1,jj+1))) + (angle(PSI(ii+1,jj+1))) + ...
%            (angle(PSI(ii+1,jj+1))) + (angle(PSI(ii+1,jj))) + ...
%            (angle(PSI(ii+1,jj-1))) + (angle(PSI(ii,jj-1)));
%        
%        if 2*pi < Wind
%         
%            Grid(ii,jj) = 1;   
%        end  
%    end  
%  end

 
 for ii = 1:X-1  
   for jj = 1:Y-1
       
       Sector1 = PhaseofPSI(ii,jj) - PhaseofPSI(ii,jj+1);
       
       
       % must check that difference between each grid point is less than pi
       if abs(Sector1) > pi;
           check = fix(Sector1/(2*pi))*2*pi;
           PhaseofPSI(ii,jj+1) = PhaseofPSI(ii,jj+1) - check;
           %Sector1 = PhaseofPSI(ii,jj) - PhaseofPSI(ii,jj+1)
       end
       
       Sector2 = PhaseofPSI(ii,jj+1) - PhaseofPSI(ii+1,jj+1);
     
       
         if abs(Sector2) > pi;
           check = fix(Sector2/(2*pi));
           PhaseofPSI(ii+1,jj+1) = PhaseofPSI(ii+1,jj+1) - check*2*pi;
           %Sector2 = PhaseofPSI(ii,jj+1) - PhaseofPSI(ii+1,jj+1);
         end
       
           Sector3 = PhaseofPSI(ii+1,jj+1) - PhaseofPSI(ii+1,jj);
       
         
       if abs(Sector3) > pi;
          check = fix(Sector3/(2*pi));
          PhaseofPSI(ii+1,jj) = PhaseofPSI(ii+1,jj) - check*2*pi;
          %Sector3 = PhaseofPSI(ii+1,jj+1) - PhaseofPSI(ii+1,jj);
       end
       
       Sector4 = PhaseofPSI(ii+1,jj) - PhaseofPSI(ii,jj);
       
         if abs(Sector4) > pi;
          check = fix(Sector4/(2*pi));
          PhaseofPSI(ii,jj) = PhaseofPSI(ii,jj) - check*2*pi;
          %Sector4 = PhaseofPSI(ii+1,jj) - PhaseofPSI(ii,jj);
         end
       
         phase_circulation = Sector4 - Sector1
     
       
       
       
       Grid(ii,jj) = 1;
       
   end  
 end


 figure
 imagesc(X,Y,Grid)
 
 % Do fft
%  
%  DelX = zeros(X-1,Y-1);
%  
%  for aa = 1:X-1
%      DelX(aa,:) = diff(PSI(aa,:));
%  end
%  
%   DelY = zeros(X-1,Y-1);
%  
%  for bb = 1:Y-1
%      DelY(:,bb) = diff(PSI(:,bb));
%  end
%  
%  size(DelX)
%  size(DelY)
%  
%  Result = imag(conj(DelX) * DelY);
%  
% 
% x = linspace(-X/2,X/2 - 1,X-1);
% [X,Y] = meshgrid(x,x);
% 
%  
%  r2 = X.^2 + Y.^2;
% Thomas_Fermi = 20; % This number is an educated guess
% Vtrap = 1/2 * r2 / Thomas_Fermi^2; 
%  
%  size(Result)
%  
%  Notrap = Result./(1 - Vtrap);