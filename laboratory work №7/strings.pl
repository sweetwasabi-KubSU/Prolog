% чтение строки и преобразование её в список ASCII кодов символов

read_string(10,L,L,N,N):-!.	% 10 - enter
read_string(X,L,CurL,N,CurN):-	NewN is CurN+1,append(CurL,[X],NewL),
				get0(Y),read_string(Y,L,NewL,N,NewN).
read_string(L,N):-	get0(X),
			read_string(X,L,[],N,0).

% вывод строки через список ASCII кодов символов

write_string([]):-!.
write_string([H|T]):-	put(H),
			write_string(T).

% task 7.1 - вывести строку три раза через запятую,
% показать количество символов в ней 

predicate1:-	nl,write("input string: "),
		read_string(L,N),nl,

		write("output string (three times): "),nl,
		write_string(L),write(", "),
		write_string(L),write(", "),
		write_string(L),nl,nl,

		write("string length: "),writeln(N),nl.

