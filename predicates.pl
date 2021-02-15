% task 1.1
men(X):-man(X),write(X),nl.
women(X):-woman(X),write(X),nl.

% task 1.2
children(X):-parent(X,Y),write(Y),nl.

% task 1.3
mother(X,Y):-parent(X,Y),woman(X).
mother(X):-parent(Y,X),woman(Y),write(Y).

% task 1.4
daughter(X,Y):-parent(Y,X),woman(X).
daughter(X):-parent(X,Y),woman(Y),write(Y),fail.

% task 1.5
brother(X,Y):-parent(Z,Y),parent(Z,X),man(Z),man(X),not(X=Y).
brothers(X):-brother(Y,X),write(Y),nl.