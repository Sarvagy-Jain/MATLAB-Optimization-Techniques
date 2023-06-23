clc
clear all
cost = [-2,0,-1,0,0,0];
a=[-1,-1,1,1,0;-1,2,-4,0,1];
b=[-5;-8];
BV=[4,5];
A=[a b];
var ={'x1','x2','x3','s1','s2','sol'};
zjcj=cost(BV)*A-cost;
simplex=[zjcj;A]
array2table(simplex , 'VariableNames',{'x1','x2','x3','s1','s2','sol'})

RUN=true;
while RUN
    sol=A(:,end);
    if any(sol<0)
        fprintf('current bfs is not feasible');
        [leaving_value pvt_row]=min(sol)
        for i=1:size(A,2)-1
            if any(pvt_row,i)<0
                ratio(i)=abs(zjcj(i)/A(pvt_row,i))
            else
                ratio(i)=inf;
            end
        end
    [leaving_value pvt_col]=max(-ratio)
    BV(pvt_row)=pvt_col
    end
    if any(zjcj(1:end-1)<0)
        fprintf('Solution is not optimal')
        zc = zjcj(1:end-1)
        [Enter_var, pivot_col] = min(zc)
        if all(A(:,pivot_col)<0)
            error('LPP is unbounded')
        else
            sol = A(:,end)
            column = A(:,pivot_col)
            for i=1:size(A,1)
                if column(i)>0
                    ratio(i) = sol(i)/column(i)
                else
                    ratio(i) = inf
                end
            end
            [Leaving_var, pivot_row] = min(ratio)
        end
        
        %updating basic variable
        bv(pivot_row) = pivot_col
        
        %Row operations
        pivot_key = A(pivot_row,pivot_col)
        A(pivot_row,:) = A(pivot_row,:)/pivot_key
        
        for i = 1:size(A,1)
            if i~=pivot_row
                A(i,:) = A(i,:) - A(i,pivot_col).*A(pivot_row,:)
            end
        end
        
        %finding optimal value
        zjcj = c(bv)*A-c
        simplex=[A;zjcj]
        array2table(simplex,'VariableNames',{'x1','x2','x3','s1','s2','sol'})
    else
        RUN = false;
    end
end
  


    
    
    
    
    
    
    
    
    
    
    
    
    
