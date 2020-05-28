close all
clear all
object = input('Name of the object? ', 's');
file = strcat('../test/v',object,'.kep');
test = load(file);
t     = test(:,1); 
a     = test(:,2); 
e     = test(:,3); 
i     = test(:,4); 
Omnod = test(:,5); 
omeg  = test(:,7); 

file = strcat('~/Work/Software/mercury/exec/kepOut/',object,'.aei');
test = load(file);
tm     = test(:,1); 
am     = test(:,2); 
em     = test(:,3); 
im     = test(:,4); 
Omnodm = test(:,5); 
omegm  = test(:,6); 


figure(1)
subplot(211)
hold on
plot(t,a)
plot(tm,am)
subplot(212)
hold on
plot(t,e)
plot(tm,em)
legend('orbit9','mercury')

figure(2)
subplot(311)
hold on
plot(t,i)
plot(tm,im)
subplot(312)
hold on
plot(t,Omnod)
plot(tm,Omnodm)
subplot(313)
hold on
plot(t,omeg)
plot(tm,omegm)
legend('orbit9','mercury')
