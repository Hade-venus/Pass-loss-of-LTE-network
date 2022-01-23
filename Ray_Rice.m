clear;
clf;
N=2e5;
level=30;
K_dB=[-40 15];
Rayleigh_ch=zeros(1,N);
Rician_ch=zeros(2,N);
gss=['k-s';'b-o';'r-^'];
Rayleigh_ch=Ray_model(N);
[temp,x]=hist(abs(Rayleigh_ch(1,:)),level);
plot(x,temp,gss(1,:)),hold on

for i=1:length(K_dB)
    Rician_ch(i,:)=Ric_model(K_dB(i),N)
    [temp,x]=hist(abs(Rician_ch(i,:)),level);
    plot(x,temp,gss(i+1,:))
end
xlabel('x'),ylabel('Occurance')
legend('Rayleigh','Rician,K=-40dB','Rician,K=15dB')

% rayleigh channel midel

function H=Ray_model(L)
%input is the channel number output is the vector of channel
H=(randn(1,L)+j*randn(1,L))/sqrt(2);

end

function H=Ric_model(K_dB,L)
%input is the channel number output is the vector of channel

K=10^(K_dB/10);
H=sqrt(K/(K+1))+sqrt(1/(K+1))*Ray_model(L);

end