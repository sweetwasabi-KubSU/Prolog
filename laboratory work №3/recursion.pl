% task 3.1
max(X,Y,Z):-X>=Y,Z is X,!.
max(_,Y,Y).

% task 3.2
max(X,Y,U,Z):-X>=Y,X>=U,Z is X,!.
max(_,Y,U,Z):-Y>=U,Z is Y,!.
max(_,_,U,U).

% task 3.3
fact(1,1):-!.
fact(N,X):-CurN is N-1,fact(CurN,CurX),X is CurX*N.