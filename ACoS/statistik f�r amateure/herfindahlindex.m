function H = herfindahlindex(s)
%s representing the vector of shares
if (sum(s<1) > 0) 
    H = sum((s/sum(s)).^2);
else
    H = sum(s.^2);
end