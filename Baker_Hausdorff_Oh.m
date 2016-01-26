% Second order method to solve soliton

function PSIn = Baker_Hausdorff_Oh(PSI,k,g,DeltaT) 

BhatPSI = exp(-i*2*g*abs(PSI).^2 * DeltaT) .* PSI ;

phi = exp( -i .* k.^2 * DeltaT) .* fft(BhatPSI);

PSIn = ifft(phi);

end



