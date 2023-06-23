clc 
clear all
A = [1 2 -3 ; 1 2 3 ; 2 1 1]
B = [4;5;6]
C = [1 2 -1]

ineqs = [0 1 1];
s = eye(size(A,1))
index = find(ineqs>0)

s(index,:)= -s(index,:)
mat=[A s B]