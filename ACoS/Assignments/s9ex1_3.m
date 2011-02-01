function s9ex1_3
clear; %needed because T might become very large
[T t z]= diffusioneq(501,20,4,45.09648);
y=ceil(length(T(1,:))/4);
iv = (3*y):(length(T(1,:)));
for i=1:501
    a(i)= (max(T(i,iv))-min(T(i,iv)));
end
a
plot(z,a,z,2)