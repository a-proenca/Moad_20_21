close all;
clear all;
clc;

load ('aat.us.txt');


Ihigh = aat_us(1:(end-1),3);
Ilow = aat_us(1:(end-1),4);
Iopen = aat_us(1:(end-1),2);
Ivolume = aat_us(1:(end-1),6);
%volume normalizado

INvolume = normalize(Ivolume,'norm',1);
%target 
Target = aat_us(2:(end),2);

P=[Ihigh Ilow Iopen INvolume]';

T=Target';

prompt = 'Qual NN pretende TREINAR 1-NEWRB 2-NEWRBE 3-FFNN(trainml) 4-FFNN(trainscg) 5-COMPARAR TODAS';
opcao = input(prompt);

if opcao==1
%NEWRB
%spread
spread = 20;
%max number of neurons
K=150;
%goal
goal=0;
%number of neurons to add between displays
Ki=10;
net= newrb(P,T,goal,spread,K,Ki);

view(net)
Y = sim(net,P);
figure(1);
plot(1:1716,T,1:1716,Y);
legend('Data Set','Trained Network');
xlabel('Dias');
ylabel('Valores das acoes');
pause;

end

if opcao==2

%NEWRBE
%spread
spread = 20;


net=newrbe(P,T,spread);
view(net)
Y = sim(net,P);
figure(1);
plot(1:1716,T,1:1716,Y);
legend('Data Set','Trained Network');
xlabel('Dias');
ylabel('Valores das acoes');

pause;

end

if opcao==3
    
%FFNN
net=feedforwardnet(50, 'trainlm');
net=train(net,P,T);
Y = net(P);
figure (1);
plot(1:1716,T,1:1716,Y);
legend('Data Set','Trained Network');
xlabel('Dias');
ylabel('Valores das acoes');
pause;

end

if opcao==4

%FFNN scg
net=feedforwardnet(50, 'trainscg');
net=train(net,P,T);
Y = net(P);
figure (1);
plot(1:1716,T,1:1716,Y);
legend('Data Set','Trained Network');
xlabel('Dias');
ylabel('Valores das acoes');

pause;
end

if opcao==5
    
%spread
spread = 20;
%max number of neurons
K=150;
%goal
goal=0;
%number of neurons to add between displays
Ki=10;
    
net=feedforwardnet(50, 'trainscg');
net=train(net,P,T);
A = net(P);

net=feedforwardnet(50, 'trainlm');
net=train(net,P,T);
B = net(P);

net= newrb(P,T,goal,spread,K,Ki);

view(net)
C = sim(net,P);

net=newrbe(P,T,spread);
view(net)
D = sim(net,P);
figure(2);
plot(1:1716,T,1:1716,A,1:1716,B,1:1716,C,1:1716,D);
legend('Data Set','SCG', 'LM', 'BR','BRE' );
xlabel('Dias');
ylabel('Valores das acoes');

end