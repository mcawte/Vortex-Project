% Vortex Counter
% This needs to calculate the phase around each lattice point. If the phase
% winds by 2pi, there is a vortex there.

 clear all
 close
 clc
 
 PSI = load('Data/34');
 
 PSI = PSI.PSI;
 
 [X,Y] = size(PSI)
 
 PSI(1,1)
 PSI(1,2)
 PSI(2,2)
 PSI(2,1)
 
 
 