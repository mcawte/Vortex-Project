% Times plotting

Grid_128 = load('Data/Times_Grid_128');
Grid_256 = load('Data/Times_Grid_256');
Grid_512 = load('Data/Times_Grid_512');

xx = [128,256,512];

y128 = Grid_128.Counting_Time;
y256 = Grid_256.Counting_Time;
y512 = Grid_512.Counting_Time;

Plaquette_time = [y128(1),y256(1),y512(1)];
Nordic_time = [y128(2),y256(2),y512(2)];
Otago_time = [y128(3),y256(3),y512(3)];

plot(log2(xx),Plaquette_time,'r',log2(xx),Nordic_time,'b',log2(xx),Otago_time,'g')
legend('Plaquette','Nordic','Otago')