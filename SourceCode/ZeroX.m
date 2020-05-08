function [ X ] = ZeroX( Y,N,P )
%   Zero crossing function
%   Y is the signal to be calculated
%   N is framed sized
%   P is crossing point/s  default at 0
if nargin==2, 
    P=0;
  f1 = find(Y< 0);
  X = length(f1);  
else
  f2 = find(Y< -1*P);   %-ve   
  f3 = find(Y<  P);      %+ve  
  cross = vertcat(f2,f3);
  % vertcat = concatenate array vertically
  % vertcat(A,B) = concatenates B vertically to the end of 
  % A when A and b have compatible size(length of dimensions
  % match except in the first dimension) 
  f4 = unique(cross);
  %B=unique(A) returns same data as in A, but with no repetitions
  %B is in sorted order
  X = length(f4);
end
 
end
