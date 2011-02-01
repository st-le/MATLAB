function s10ex1_2
%solution of fisher's equation for t = [0,20,40,60,80,100]
t = [0:20:100];
for i=1:6
    [p x] = fishereq(0.01,1,(1/160)^2,t(i));
    P(i,:) = p;
end
hold all;
plot(x,P(1,:),'b',x,P(2,:),'g',x,P(3,:),'m',x,P(4,:),'c',x,P(5,:),'y',x,P(6,:),'k');