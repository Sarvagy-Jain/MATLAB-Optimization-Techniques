clc
clear all
format short

A = [2 3 -1 4;1 -2 6 7]
C = [2 3 4 7]
B = [8;-3]

n=size(A,2);
m=size(A,1);

if(n>m)
  nCm=nchoosek(n,m) 
  p=nchoosek(1:n,m)
  sol=[]
  for i=1:nCm
     y=zeros(n,1);
     A1=A(:,p(i,:));
     x=inv(A1)*B;
     if all(x>=0 & x~=inf)
        y(p(i,:))=x;
        l = sol;
        sol=[sol y];
     end
  end
else('No of const greater than no. of variable')
end 
z=C*sol
[obj ind]=max(z);
