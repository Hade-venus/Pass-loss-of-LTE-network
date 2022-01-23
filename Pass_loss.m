clear all;
clf,clc;
fc=1.5e9;
d0=100;
sigma=3;
distance=[1:2:31].^2;
Gt=[1 1 0.5 ];
Gr=[1 0.5 0.5 ];
Exp=[2 3 6];
for k=1:3
    y_Free(k,:)=PL_free(fc,distance,Gt(k),Gr(k));
    y_logdist(k,:)=PL_logdist_or_norm(fc,distance,d0,Exp(k));
    y_lognorm(k,:)=PL_logdist_or_norm(fc,distance,d0,Exp(1),sigma);
end
subplot(131)
semilogx(distance,y_Free(1,:),'k-o',distance,y_Free(2,:),'k-^',distance,y_Free(3,:),'k-s')
grid on,axis([1 1000 40 110])
title(['Free PL-loss model','MHz'])
xlabel('Distance[m]'),ylabel('Pass loss[dB]')
legend('G_t=1,G_r=1','G_t=1,G_r=0.5','G_t=0.5,G_r=0.5','Best')
subplot(132)
semilogx(distance,y_logdist(1,:),'k-o',distance,y_logdist(2,:),'k-^',distance,y_logdist(3,:),'k-s')
grid on,axis([1 1000 40 110])
title(['Log_distance Pass-loss model','MHz'])
xlabel('Distance[m]'),ylabel('Pass loss[dB]')
legend('n=2','n=3','n=6','Best')

subplot(133)
semilogx(distance,y_lognorm(1,:),'k-o',distance,y_lognorm(2,:),'k-^',distance,y_lognorm(3,:),'k-s')
grid on,axis([1 1000 40 110])
title(['Log_norm Pass-loss model','MHz'])
xlabel('Distance[m]'),ylabel('Pass loss[dB]')
legend('path1','path2','path3','Best')

function PL=PL_free(fc,dist,Gt,Gr)
lamda=3e8/fc;
tem=lamda./(4*pi*dist);
if nargin>2, tem=tem*sqrt(Gt);

 end
if nargin>3, tem=tem*sqrt(Gr);
 end
PL=-20*log10(tem);
end

function PL=PL_logdist_or_norm(fc,d,d0,n,sigma)
lamda=3e8/fc;

PL=-20*log10(lamda/(4*pi*d0))+10*n*log10(d/d0);
if nargin>4, PL=PL+sigma*randn(size(d));
 end
end