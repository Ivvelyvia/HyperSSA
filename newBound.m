function s = newBound(s, Lb, Ub,best1,best2,best3) 

temp = s;
III = temp < Lb;
temp(III)=1/3*rand*(best1(III)+best2(III)+best3(III));
J = temp > Ub;
temp(J)=1/3*rand*(best1(J)+best2(J)+best3(J));
s = temp;
end