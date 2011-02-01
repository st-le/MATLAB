function [g] = gamma
%Berechnung der Eulerschen Konstante Gamma mit Hilfe von (1.34) und (1.35)
%Wir lassen wieder n = 2^i gegen unendlich laufen,
%indem wir h = 1/n = 2^(-i) gegen 0 gehen lassen

T(1,1)=1;
i=1;

while (i <= 1 || abs((T(i,i)-T(i-1,i-1))/T(i,i)) > 1.0e-14)
    i=i+1;
    T(i,1)=0;
%Partialsumme berechnen        
        for j=2^i:-1:1
            T(i,1)=T(i,1)+1/j;
        end
%ln(n) von Partialsumme abziehen [log(n)=log(2^i)=i*log(2)]
        T(i,1)=T(i,1)-i*log(2); 
%Aitken-Neville Extrapolation gem‰ﬂ (1.35)    
        for j=2:i
            T(i,j)=(2^(-j+1)*T(i-1,j-1)-T(i,j-1))/(2^(-j+1)-1);
        end
end
g = T(i,i);
