function x = gauss(A,b)
%solving the system Ax = b with standard gauss
n = length(b);
A = [A,b];  
%Elimination scheme
for i = 1:n-1 
   for k = i+1:n
      faktor = A(k,i)/A(i,i);
      A(k,:) = A(k,:)-faktor*A(i,:);
   end
end
U=A(:,1:n); b = A(:,n+1);

%backward substitution
n = length(b);
for k = n:-1:1
   s = b(k);
   for i = k+1:n
      s = s-U(k,i)*x(i);
   end
   x(k) = s/U(k,k);
end
x = x(:);