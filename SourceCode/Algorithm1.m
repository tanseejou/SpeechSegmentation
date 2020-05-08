 function [S,N] = Algorithm1(Y,Thres,win)
%Simple segmentation algorithm
%Input : Y - the signal to be segmented
%        Thres  - the  threshold value as deciding factor to select point            
%        win - window size for energy analysis         

N = round(length(Y)/win); % number of framed
st = 1;
for n= 1:N-1
e = Energy(Y(st:win+st),win);
x(n) = e;
st = (st+win);   
end
 
S =[ ];
ind=1;
for m=1: N-2
   if (x(m)< Thres) & (x(m+1)>Thres)
       S(ind) = m;
       ind=ind+1;
   end 
end
S = S*win;  % segmentation points. convert back to sample unit
N = length(S);     % number of segmentation points
end

