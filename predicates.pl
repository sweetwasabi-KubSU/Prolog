% task 1.1
men(X):-man(X),write(X),nl,fail.
women(X):-woman(X),write(X),nl,fail.

% task 1.2
children(X):-parent(X,Y),write(Y),nl,fail.

% task 1.3
mother(X,Y):-parent(X,Y),woman(X).
mother(X):-parent(Y,X),woman(Y),write(Y).

% task 1.4
daughter(X,Y):-parent(Y,X),woman(X).
daughter(X):-parent(X,Y),woman(Y),write(Y).

% task 1.5
brother(X,Y):-parent(Z,Y),parent(Z,X),man(Z),man(X),not(X=Y).
brothers(X):-brother(Y,X),write(Y),nl,fail.

% task 1.6
wife(X,Y):-parent(Y,Z),parent(X,Z),woman(X).
wife(X):-man(X),wife(Y,X),write(Y).

% task 1.7
b_s(X,Y):-parent(Z,X),parent(Z,Y),woman(Z),not(X=Y).
b_s(X):-b_s(X,Y),write(Y),nl,fail.

% task 1.8
grand_pa(X,Y):-parent(Z,Y),parent(X,Z),man(X).
grand_pa(X):-grand_pa(Y,X),write(Y),nl,fail.

% task 1.9
grand_da(X,Y):-parent(Y,Z),parent(Z,X),woman(X).
grand_dats(X):-grand_da(Y,X),write(Y),nl,fail.

% task 1.10
grand_pa_and_son(X,Y):-grand_pa(X,Y),man(Y).
grand_pa_and_son(X,Y):-grand_pa(Y,X),man(X).

% task 1.11
grand_ma_and_da(X,Y):-parent(X,Z),parent(Z,Y),woman(X),woman(Y).
grand_ma_and_da(X,Y):-parent(Y,Z),parent(Z,X),woman(X),woman(Y).
