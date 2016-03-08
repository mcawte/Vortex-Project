%Soliton test code
 clear all
 close
 clc

% Real space information

Points = 1000;
Range = 40;
DeltaX = Range/Points;
x = linspace(-Range/2,Range/2 - DeltaX,Points);

% Time step information
DeltaT = 0.0001;
Time = 10;
Steps = Time/DeltaT;


% K space information
dk = (2*pi)/Range;
kmax = (2*pi)/(DeltaX);
k = (-kmax/2:dk:kmax/2 -dk);
k = fftshift(k);


% Soliton set up

N = 5;
n = 100;
Kv = 2*pi/Range *n;
PSI = N .* sech(x);% .*exp(i.*Kv.*x); 
g = -1;

% Initialize matrix to store evolution of soliton solutions
Solutions = zeros(Steps,Points);
Energy = zeros(1,Steps);



% Loop to solve dynamics and plot the solution
for ii = 1:Steps;
    
% This uses the first oder Baker Hausdorff    
 PSI = Baker_Hausdorff_Oh(PSI,k,g,DeltaT);

% This uses the third oder Baker Hausdorff    
% PSI = Baker_Hausdorff_Oh3(PSI,k,g,DeltaT);
 
% This uses the First attempt at a Runga Kutta Method
 %PSI = RungaKuttaOne(PSI,k,g,DeltaT);

Solutions(ii,:) = PSI;

Energy_density = abs(conj(PSI) .* ifft(k.^2 .* fft(PSI))) + g.*abs(PSI).^4;
%Energy_density = abs(ifft(1i*k .* fft(PSI))).^2 + g.*abs(PSI).^4;


Energy(ii) = sum(Energy_density);

%Plotting code
if floor(ii/10) == ii/10
Natoms = sum(abs(Solutions(ii,:)).^2)*DeltaX;
plot(x,(abs(Solutions(ii,:))))
title(['Probability Density, N = ' num2str(Natoms), ', Energy = ' num2str(Energy(ii)) ]);
xlabel('x axis');
ylabel('Amplitude')
drawnow;
pause(0.001)
% pause
end


end

Energy_Difference = zeros(1,Steps);

for ii = 1:Steps;
   Energy_Difference(ii) = Energy(ii) - Energy(1);
    
end

figure 
plot(1:Steps,Energy_Difference);
title('Energy at each step minus Energy at first step');
xlabel('Steps');
ylabel('Energy Difference');

