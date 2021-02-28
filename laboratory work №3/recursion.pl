% task 3.1 - Z максимальное из чисел X и Y
max(X,Y,Z):-X>=Y,Z is X,!.
max(_,Y,Y).

% task 3.2 - Z максимальное из чисел X, Y и U
max(X,Y,U,Z):-X>=Y,X>=U,Z is X,!.
max(_,Y,U,Z):-Y>=U,Z is Y,!.
max(_,_,U,U).

% task 3.3 - факториал через рекурсию вверх
% fact(1,1):-!.
% fact(N,X):-	CurN is N-1,fact(CurN,CurX),
%		X is CurX*N.

% task 3.4 - факториал через рекурсию вниз
extraFact(1,CurX,CurX):-!.
extraFact(N,CurX,X):-	NewX is CurX*N,CurN is N-1,
			extraFact(CurN,NewX,X).
fact(N,X):-extraFact(N,1,X).

% task 3.5 - фибоначчи через рекурсию вверх
% fib(1,1):-!.
% fib(2,1):-!.
% fib(N,X):-	PrevX is N-2,fib(PrevX,X1),
%		NextX is N-1,fib(NextX,X2),
%		X is X1+X2.

% task 3.6 - фибоначчи через рекурсию вниз
extraFib(1,_,NextX,NextX):-!.
extraFib(2,_,NextX,NextX):-!.
extraFib(N,PrevX,NextX,X):-	CurX is PrevX+NextX,CurN is N-1,
				extraFib(CurN,NextX,CurX,X).
fib(N,X):-extraFib(N,1,1,X).

% task 3.7 - сумма цифр числа через рекурсию вверх
% sumDigits(0,0):-!.
% sumDigits(N,X):-	CurN is N div 10,sumDigits(CurN,CurX),
%			X is CurX + N mod 10.

% task 3.8 - сумма цифр числа через рекурсию вниз
extraSumDigits(0,CurX,CurX):-!.
extraSumDigits(N,CurX,X):-	NewX is CurX + N mod 10,CurN is N div 10,
				extraSumDigits(CurN,NewX,X).
sumDigits(N,X):-extraSumDigits(N,0,X).

% task 3.9.9 - минимальная цифра числа через рекурсию вверх
minDigit(N,X):-	CurX is N mod 10,CurN is N div 10,
		(CurN=:=0-> MinX is CurX;minDigit(CurN,MinX)),
		(CurX<MinX -> X=CurX;X=MinX).