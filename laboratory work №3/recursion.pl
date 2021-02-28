% task 3.1 - Z максимальное из чисел X и Y
max(X,Y,Z):-X>=Y,Z is X,!.
max(_,Y,Y).

% task 3.2 - Z максимальное из чисел X, Y и U
max(X,Y,U,Z):-X>=Y,X>=U,Z is X,!.
max(_,Y,U,Z):-Y>=U,Z is Y,!.
max(_,_,U,U).

% task 3.3 - факториал (через рекурсию вверх)
% fact(1,1):-!.
% fact(N,X):-	CurN is N-1,fact(CurN,CurX),
%		X is CurX*N.

% task 3.4 - факториал (через рекурсию вниз)
extraFact(1,CurX,CurX):-!.
extraFact(N,CurX,X):-	NewX is CurX*N,CurN is N-1,
			extraFact(CurN,NewX,X).
fact(N,X):-extraFact(N,1,X).

% task 3.5 - фибоначчи (через рекурсию вверх)
% fib(1,1):-!.
% fib(2,1):-!.
% fib(N,X):-	PrevX is N-2,fib(PrevX,X1),
%		NextX is N-1,fib(NextX,X2),
%		X is X1+X2.

% task 3.6 - фибоначчи (через рекурсию вниз)
extraFib(1,_,NextX,NextX):-!.
extraFib(2,_,NextX,NextX):-!.
extraFib(N,PrevX,NextX,X):-	CurX is PrevX+NextX,CurN is N-1,
				extraFib(CurN,NextX,CurX,X).
fib(N,X):-extraFib(N,1,1,X).

% task 3.7 - сумма цифр числа (через рекурсию вверх)
% sumDigits(0,0):-!.
% sumDigits(N,X):-	CurN is N div 10,sumDigits(CurN,CurX),
%			X is CurX + N mod 10.

% task 3.8 - сумма цифр числа (через рекурсию вниз)
extraSumDigits(0,CurX,CurX):-!.
extraSumDigits(N,CurX,X):-	NewX is CurX + N mod 10,CurN is N div 10,
				extraSumDigits(CurN,NewX,X).
sumDigits(N,X):-extraSumDigits(N,0,X).

% task 3.9.9 - минимальная цифра числа (через рекурсию вверх)
% minDigit(N,X):-	CurX is N mod 10,CurN is N div 10,
%			(CurN=:=0 -> MinX is CurX;minDigit(CurN,MinX)),
%			(CurX<MinX -> X=CurX;X=MinX).

% task 3.10.9 - минимальная цифра числа (через рекурсию вниз)
extraMinDigit(N,MinX,X):-	CurX is N mod 10,CurN is N div 10,
				(CurX<MinX -> NewMinX is CurX;NewMinX is MinX),
				(CurN=:=0 -> X=NewMinX;extraMinDigit(CurN,NewMinX,X)).
minDigit(N,X):-	extraMinDigit(N,N,X).

% task 3.11.9 - произведение цифр числа, не делящихся на 5 (через рекурсию вверх)
% примечание:	не покрывает случай, когда число состоит только из комбинации пятёрок и нулей,
% 		сответственно для данного случая ответ не ноль (правильный), а единица
% multDigits(0,0):-!.	% частный случай при вводе нуля
% multDigits(N,X):-	CurX is N mod 10,CurN is N div 10,
%			(CurN=:=0 -> MultX=1;multDigits(CurN,MultX)),
%			Reminder is CurX mod 5,(Reminder=:=0 -> X is MultX;X is CurX*MultX).

% task 3.11.9 - произведение цифр числа, не делящихся на 5 (через рекурсию вниз)
% 		*сохраняется предыдущее примечение*
extraMultDigits(N,MultX,X):-	CurX is N mod 10,CurN is N div 10,Reminder is CurX mod 5,
				(Reminder=:=0 -> NewMultX is MultX;NewMultX is CurX*MultX),
				(CurN=:=0 -> X is NewMultX;extraMultDigits(CurN,NewMultX,X)).
multDigits(N,X):-(N=:=0 -> X is 0;extraMultDigits(N,1,X)).

% task 3.12 - количество цифр числа, меньших 3 (через рекурсию вверх)
numberOfDigits(N,X):-	CurX is N mod 10,CurN is N div 10,
			(CurN=:=0 -> NewCurX=0;numberOfDigits(CurN,NewCurX)),
			(CurX<3 -> X is NewCurX+1;X=NewCurX).

% task 3.*12 - НОД двух чисел (алгоритм евклида через вычитание и рекурсию вниз)
numbersGCD(A,0,A):-!.
numbersGCD(A,B,X):-	(A>B -> Min is B,Reminder is A-B;Min is A,Reminder is B-A),
			numbersGCD(Min,Reminder,X).

% task 3.*12 - проверка числа на простоту (через рекурсию вниз)
extraPrimeNumber(N,X):-	(X>N div 2 -> !;Reminder is N mod X,
			(Reminder=:=0 -> fail;CurX is X+1,extraPrimeNumber(N,CurX))).
primeNumber(N):-((N=:=0;N=:=1) -> fail;extraPrimeNumber(N,2)).
