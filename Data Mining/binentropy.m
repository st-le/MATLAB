function [ Hb ] = binentropy( p )
%BINENTROPY Summary of this function goes here
%   Detailed explanation goes here
    Hb = -(p*log2(p) + (1-p)*log2(1-p));

end
