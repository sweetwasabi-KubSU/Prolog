men(X):-man(X),write(X),nl.
women(X):-woman(X),write(X),nl.

children(X):-parent(X,Y),write(Y),nl.