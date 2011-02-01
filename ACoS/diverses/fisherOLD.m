function fishereqOLD

% p=zeros(m,n);
% %Dirichlet boundary conditions:
% p(:,1)=1;
% p(:,n)=0;
% p(1,1:ceil(n/4))=1;
% p(1,(ceil(n/4)+1):n)=0;
%explicit Euler
% for i=2:(n-1)
%     for j=2:m
%         p(i,j) = p(i,j-1) + dt*D*((p(i-1,j-1)+p(i+1,j-1)-2*p(i,j-1))./(dx^2) + k*p(i,j-1)*(1-p(i,j-1)));
%     end
% end
