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
fact(1,CurX,CurX):-!.
fact(N,CurX,X):-	NewX is CurX*N,CurN is N-1,
			fact(CurN,NewX,X).
fact(N,X):-fact(N,1,X).

% task 3.5 - фибоначчи (через рекурсию вверх)
% fib(1,1):-!.
% fib(2,1):-!.
% fib(N,X):-	PrevX is N-2,fib(PrevX,X1),
%		NextX is N-1,fib(NextX,X2),
%		X is X1+X2.

% task 3.6 - фибоначчи (через рекурсию вниз)
fib(1,_,NextX,NextX):-!.
fib(2,_,NextX,NextX):-!.
fib(N,PrevX,NextX,X):-	CurX is PrevX+NextX,CurN is N-1,
			fib(CurN,NextX,CurX,X).
fib(N,X):-fib(N,1,1,X).

% task 3.7 - сумма цифр числа (через рекурсию вверх)
% sumDigits(0,0):-!.
% sumDigits(N,X):-	CurN is N div 10,sumDigits(CurN,CurX),
%			X is CurX + N mod 10.

% task 3.8 - сумма цифр числа (через рекурсию вниз)
sumDigits(0,CurX,CurX):-!.
sumDigits(N,CurX,X):-	NewX is CurX + N mod 10,CurN is N div 10,
			sumDigits(CurN,NewX,X).
sumDigits(N,X):-sumDigits(N,0,X).

% task 3.9.9 - минимальная цифра числа (через рекурсию вверх)
minDigit(N,X):-	CurX is N mod 10,CurN is N div 10,
		(CurN=:=0 -> MinX is CurX;minDigit(CurN,MinX)),
		(CurX<MinX -> X=CurX;X=MinX).

% task 3.10.9 - минимальная цифра числа (через рекурсию вниз)
% minDigit(N,MinX,X):-	CurX is N mod 10,CurN is N div 10,
%			(CurX<MinX -> NewMinX is CurX;NewMinX is MinX),
%			(CurN=:=0 -> X=NewMinX;minDigit(CurN,NewMinX,X)).
% minDigit(N,X):-minDigit(N,N,X).

% task 3.11.9 - произведение цифр числа, не делящихся на 5 (через рекурсию вверх)
% примечание:	не покрывает случай, когда число состоит только из комбинации пятёрок и нулей,
% 		сответственно для данного случая ответ не ноль (правильный), а единица
% multDigits(0,0):-!.	% частный случай при вводе нуля
% multDigits(N,X):-	CurX is N mod 10,CurN is N div 10,
%			(CurN=:=0 -> MultX=1;multDigits(CurN,MultX)),
%			Reminder is CurX mod 5,(Reminder=:=0 -> X is MultX;X is CurX*MultX).

% task 3.11.9 - произведение цифр числа, не делящихся на 5 (через рекурсию вниз)
% 		*сохраняется предыдущее примечение*
multDigits(N,MultX,X):-	CurX is N mod 10,CurN is N div 10,Reminder is CurX mod 5,
			(Reminder=:=0 -> NewMultX is MultX;NewMultX is CurX*MultX),
			(CurN=:=0 -> X is NewMultX;multDigits(CurN,NewMultX,X)).
multDigits(N,X):-(N=:=0 -> X is 0;multDigits(N,1,X)).

% task 3.12 - количество цифр числа, меньших 3 (через рекурсию вверх)
numberOfDigits(N,X):-	CurX is N mod 10,CurN is N div 10,
			(CurN=:=0 -> NewCurX=0;numberOfDigits(CurN,NewCurX)),
			(CurX<3 -> X is NewCurX+1;X=NewCurX).

% task 3.*12 - НОД двух чисел (алгоритм евклида через вычитание и рекурсию вниз)
extraNumbersGCD(A,0,A):-!.
extraNumbersGCD(A,B,X):-	(A>B -> Min is B,Reminder is A-B;Min is A,Reminder is B-A),
				extraNumbersGCD(Min,Reminder,X).
numbersGCD(A,B,X):-((A \= 0,B \= 0) -> extraNumbersGCD(A,B,X)).

% task 3.*12 - проверка числа на простоту (через рекурсию вниз)
primeNumber(N,X):-	(X>N div 2 -> !;Reminder is N mod X,
			(Reminder=:=0 -> fail;CurX is X+1,primeNumber(N,CurX))).
primeNumber(N):-((N=:=0;N=:=1) -> fail;primeNumber(N,2)).

% task 3.*12 - количество делителей числа (через рекурсию вверх)
numDivs(_,1,1):-!.
numDivs(N,D,X):-	CurD is D-1,numDivs(N,CurD,CurX),
			Reminder is N mod D,
			(Reminder=:=0 -> X is CurX+1;X is CurX).
numDivs(N,X):-(N=:=0 -> X=0;numDivs(N,N,X)).

% task 3.13 -	*итерационная последовательность (гипотеза коллатца)*
%		найти стартовый номер, менее одного миллиона с самой длинной цепочкой
% 		*less than 10^6 is 837799, which has 524 steps*

% рекурсия вниз
extraCollatz(1,0):-!.
extraCollatz(N,X):-	(0 is N mod 2 -> CurN is N div 2;CurN is N*3+1),
			extraCollatz(CurN,CurX),X is CurX+1.
% рекурсия вверх
collatzIterating(1,1,2):-!.
collatzIterating(N,MaxN,MaxX):-	CurN is N-1,collatzIterating(CurN,NewN,NewX),extraCollatz(CurN,CurX),
				(CurX>NewX -> MaxX=CurX,MaxN=CurN;MaxX=NewX,MaxN=NewN).

collatz(Number,Length):-collatzIterating(1000000,Number,Length).

% task 3.14.9 -	максимальный простой делитель числа (через рекурсию вниз)
% primeDiv(_,0,_):-write("Number has no prime divisors!"),!.
% primeDiv(N,CurX,X):-	(0 is N mod CurX,primeNumber(CurX) -> X=CurX;
%			NewX is CurX-1,primeDiv(N,NewX,X)).
% primeDiv(N,X):-(primeNumber(N) -> X=N;CurX is N div 2, primeDiv(N,CurX,X)).

% task 3.14.9 -	максимальный простой делитель числа (через рекурсию вверх)
% *+ условие, что числа не могут быть отрицательными*
primeDiv(_,1,2):-!.
primeDiv(N,CurX,X):-	NextX is CurX-1,primeDiv(N,NextX,NewX),
			(0 is N mod CurX,primeNumber(CurX) -> X=CurX;X=NewX).
primeDiv(N,X):-	((N=:=0;N=:=1;N<0) -> write("Number has no prime (and posivive) divisors!");
		primeDiv(N,N,X)).

% task 3.15.9 - НОД максимального нечетного непростого делителя числа
%		и прозведения цифр данного числа

% 1) для определения нечётного числа
oddNum(N):-Reminder is N mod 2,Reminder=\=0.

% 2) для определения непростого числа
notPrimeNum(N):-not(primeNumber(N)).

% 3) для поиска максимального нечётного непростого делителя (через рекурсию вверх)
% *будем считать, что максимальный делитель нуля - он сам*
maxDiv(_,1,1):-!.
maxDiv(N,CurX,X):-	NewX is CurX-1,maxDiv(N,NewX,Max),
			(0 is N mod CurX,oddNum(CurX),notPrimeNum(CurX) -> X=CurX;X=Max).
maxDiv(N,X):-(N=:=0 -> X=0;maxDiv(N,N,X)).

% 4) для подсчёта произведения цифр числа (через рекурсию вверх)
extraMultDigs(0,1):-!.
extraMultDigs(N,X):-	CurX is N mod 10,CurN is N div 10,
			extraMultDigs(CurN,NewX),X is CurX*NewX.
multDigs(N,X):-(N=:=0 -> X=0;extraMultDigs(N,X)).

% 5) НОД максимального нечетного непростого делителя числа и прозведения цифр данного числа
predicate15(N,X):-	maxDiv(N,A),multDigs(N,B),
			numbersGCD(A,B,X),
			write("A = "),writeln(A),
			write("B = "),writeln(B).

% task 3.16.9 - наибольшее количество пифагоровых троек для p < 1000
% *this task isn't done yet*

% final test task - две максимально отдалённые цифры числа, 
% которые между собой взаимно-просты между собой,
% но не взаимно-просты с пред. минимумом

% *одна из цифр и пред. минимум могут совпадать*
% *можно убрать, но так теряется часть решений*

% удачные примеры: 84679, 8867497
% просто примеры: 469, 269, 368

extra_predicate(N):-	enum_digits(N,A,B),
			previous_min_digit(N,Min),

			numbersGCD(A,B,Y),Y=:=1,
			numbersGCD(A,Min,X1),X1 \= 1,
			numbersGCD(B,Min,X2),X2 \= 1,

			nl,write("A = "),writeln(A),
			write("B = "),writeln(B),
			write("NOD = "),writeln(Y),

			nl,write("A = "),writeln(A),
			write("pMin = "),writeln(Min),
			write("NOD = "),writeln(X1),

			nl,write("B = "),writeln(B),
			write("pMin = "),writeln(Min),
			write("NOD = "),writeln(X2),nl,!.

% перебор двух цифр числа (начиная с самых отдалённых друг от друга цифр)
enum_digits(N,_,_):-	CurN is N div 10,
			CurN=:=0,!,fail.
enum_digits(N,A,B):-	A is N mod 10,
			CurN is N div 10,
			reverse_number(CurN,RevN),
			enum_digit(RevN,B).
enum_digits(N,A,B):-	CurN is N div 10,
			enum_digits(CurN,A,B).	

% перебор одной цифры числа
enum_digit(0,_):-	!,fail.
enum_digit(N,A):-	A is N mod 10.
enum_digit(N,A):-	CurN is N div 10,
			enum_digit(CurN,A).

% переворачивает число (12345 -> 54321)
% *не учитывает случай с нулями на конце (100 -> 1)*
% *в данном контексте задачи это не влияет на результат*
reverse_number(0,1,0):-!.
reverse_number(N,Tens,X):-	CurN is N div 10,
				reverse_number(CurN,CurTens,CurX),
				NewX is (N mod 10)*CurTens,
				Tens is CurTens*10,
				X is CurX+NewX.
reverse_number(N,X):-reverse_number(N,_,X).

% убирает из числа все вхождения заданной цифры
% *если число состояло только из этой цифры, то false*
remove_digit(0,0,_,_):-!.
remove_digit(A,B,Tens,Y):-	CurA is A div 10,X is A mod 10,
				(X \= Y -> CurTens is Tens*10;CurTens=Tens),
				remove_digit(CurA,CurB,CurTens,Y),
				(X \= Y -> B is CurB+X*Tens;B=CurB).
remove_digit(A,B,Y):-	remove_digit(A,B,1,Y),
			B \= 0.

% находит пред. минимальную цифру числа
previous_min_digit(N,Min):-	minDigit(N,CurMin),
				count_digit(N,CurMin,Count),
				(Count > 1 -> Min is CurMin;
				remove_digit(N,CurN,CurMin),
				minDigit(CurN,Min)).

% считает количество вхождений цифры в число (рекурсия вверх)
count_digit(0,_,0):-!.
count_digit(N,X,Count):-	CurN is N div 10,
				CurX is N mod 10,
				count_digit(CurN,X,CurCount),
				(X=:=CurX -> Count is CurCount+1;Count=CurCount).