clc
clear all
M = 1000;
C=[-2 0 -1 0 0 -M -M 0];
%x1 x2 x3 s1 s1 a1 a2
a=[1 1 -1 -1 0 1 0; 1 -2 4 0 -1 0 1];
b=[5; 8];
A=[a b];

var={'x1','x2','x3','s1','s2','a1','a2','sol'};
bv=[6 7];
zjcj=C(bv)*A-C;
simplex_table=[A;zjcj];
array2table(simplex_table,'VariableNames',var)

%% TRUE 
RUN=true; 
while RUN
    if any(zjcj(1:end-1)<0)
        fprintf('The current BFS is not optimal\n');
        zc=zjcj(1:end-1);
        [EV,PC] = min(zc);
        if all(A(:,PC)<0)
            error('LPP is Unbounded')
        else
            column = A(:,PC);
            sol = A(:,end);
            for i = 1:size(A,1)
                if column(i) > 0
                    ratio(i) = sol(i)/column(i);
                else
                    ratio(i) = inf;
                end
            end
            [LV,PR] = min(ratio);
        end
        bv(PR)=PC;
        PK = A(PR,PC);
        A(PR,:) = A(PR,:)/PK;
        % ROW OPERATIONS
        for i=1:size(A,1)
            if i ~= PR
                A(i,:) = A(i,:) - A(i,PC)*A(PR,:);
            end
        end
        zjcj=C(bv)*A-C;
        next_table=[A;zjcj];
        array2table(next_table,'VariableNames',var)
    else
        fprintf('Optimal Value is %f \n',zjcj(end))
        RUN = false;
    end
end
        



