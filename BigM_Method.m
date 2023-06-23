clc
M = 1000;
vars = ['a1','a2','s2','s3','A1','A2','sol'];
a = [3 1 0 0 1 0;4 3 -1 0 0 1;1 2 0 1 0 0];
b = [3;6;3];
A = [a b];
Cost = [-2 -1 0 0 -M -M 0];
s = eye(size(A,1));
Bv = [];
Idy = eye(size(A,1));
for i=1:size(A,2)
    for j=1:size(Idy,2)
        if A(:,i)== Idy(:,j)
            Bv = [Bv i];
        end  
    end
end
BV = Bv
%% To calculate Z-Row(Zj-Cj) 
ZjCj=Cost(BV)*A-Cost;

%To print the table
ZCj=[ZjCj; A];
%SimpTable=array2table(ZCj,'VariableNames',{'x_1','x_2','s_1','A_1','s_2','Sol'}) %make table

%% Simplex Table Starts
Run=true;
while Run
if any(ZjCj(1:end-1)<0) %To check any negative value is there
    disp('Old Basic Variable (BV)=')
    disp(BV)
    %Variable
    
    ZC=ZjCj(1:end-1);
    [EnterCol, Pvt_Col]=min(ZC);
    fprintf('The most negative element in Z-Row is %d Corresponding to Column %d \n', EnterCol, Pvt_Col)
    fprintf('Entering Variable is %d \n', Pvt_Col)
    
    %To find the leaving variable
    sol=A(:,end);
    Column=A(:,Pvt_Col);
    if all(Column<=0)
        error('LPP has unbounded solution. All entries <= 0 in column %d', Pvt_Col)
    else

    % To check minimum ratio is with positive entering column entries
        for i=1:size(Column,1)
            if Column(i)>0
        ratio(i)=sol(i)./Column(i);
            else
                ratio(i)=inf;
            end
        end
        %To finding minimum ratio
        [MinRatio, Pvt_Row]=min(ratio);
        fprintf('Minimum ratio corresponding to pivot row is %d \n', Pvt_Row)
        fprintf('Leaving Variable is %d \n', BV(Pvt_Row))
    end
    BV(Pvt_Row)=Pvt_Col;
    disp('New Basic Variables (BV) =')
    disp(BV)

    %Pivot Key
    Pvt_Key=A(Pvt_Row,Pvt_Col);

    %Update Table for next iteration
    A(Pvt_Row,:)=A(Pvt_Row,:)./Pvt_Key;

    for i=1:size(A,1)
        if i~=Pvt_Row
            A(i,:)=A(i,:)-A(i,Pvt_Col).*A(Pvt_Row,:);
        end
    end
    ZjCj=ZjCj-ZjCj(Pvt_Col).*A(Pvt_Row,:);
    %To print the updated table
        ZCj=[ZjCj;A];
        SimpTable=array2table(ZCj,'VariableNames',{'a1','a2','s2','s3','A1','A2','sol'})
        
        BFS=zeros(1,size(A,2));
        BFS(BV)=A(:,end);
        BFS(end)=sum(BFS.*Cost);
        CurrentBFS=array2table(BFS,'VariableNames',{'a1','a2','s2','s3','A1','A2','sol'})
    else
        Run=false;
        fprintf('The current BFS is optimal and Optimality is reached \n')
    end
end