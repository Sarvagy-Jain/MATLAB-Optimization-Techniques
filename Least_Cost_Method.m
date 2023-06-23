clc 
clear all 

c = [6 4 1 5;8 9 2 7;4 3 6 4]
a = [14;16;5]
b = [6 10 15 4]


m = size(c,1)
n = size(c,2)
z=0;
if sum(a) == sum(b)
fprintf('TP is balances')
else
fprintf('TP is unbalanced')

if sum(a) < sum(b)
    c(end+1,:) = zeros(1,length(b));
    a(end+1) = sum(b) - sum(a);
else
    c(:,end+1) = zeros(length(a),1)
    b(end+1) = sum(a) - sum(b)
end
end

x = zeros(m,n)

ic = c


for i =1:size(c,1)
    for j =1:size(c,2)
        cpq = min(c(:))
        
      if cpq == inf
          break
      end
       
      [rowind colind] = find(cpq == c)
      x11 = min(a(rowind),b(colind))
      [val ind] = max(x11)
      p = rowind(ind)
      q = colind(ind)
      x(p,q)  = min( a(p),b(q))
      if min( a(p) , b(q)) == a(p)
          b(q)= b(q) - a(p)
          a (p) = a(p) - x(p,q)
          c(p,:)  = inf
      else
          a(p) = a(p) - b(q)
          b(q) = b(q) - x(p,q)
          c(:,q) = inf
      end
    end
end

% for i = 1:size(c,1)
%     for j=1:size(c,2)
%             z =z + ic(i,j)*x(i,j)
%     end
% end

z = sum(sum(ic.*x))
array2table(x)
fprintf('Total Cost id = %f \n',z)