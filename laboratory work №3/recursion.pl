% task 3.1
max(X,Y,Z):-X>=Y,Z is X,!.
max(_,Y,Y).

% task 3.2
max(X,Y,U,Z):-X>=Y,X>=U,Z is X,!.
max(_,Y,U,Z):-Y>=U,Z is Y,!.
max(_,_,U,U).

% task 3.3
% fact(1,1):-!.
% fact(N,X):-CurN is N-1,fact(CurN,CurX),X is CurX*N.

% task 3.4
extraFact(1,CurX,CurX):-!.
extraFact(N,CurX,X):-NewX is CurX*N,CurN is N-1,extraFact(CurN,NewX,X).
fact(N,X):-extraFact(N,1,X).

% task 3.5
fib(1,1):-!.
fib(2,1):-!.
fib(N,X):-PrevX is N-2,fib(PrevX,X1),NextX is N-1,fib(NextX,X2),X is X1+X2.