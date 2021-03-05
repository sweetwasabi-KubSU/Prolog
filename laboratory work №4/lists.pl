% task 4.1 - чтение и вывод списка

% аналог append
appendList([],X,X).
appendList([H|T1],X,[H|T2]):-appendList(T1,X,T2).

% чтение списка

% размер поступает как аргумент
readList(N,L):-	writeln("set the list: "),readList(N,0,[],L).

% размер вводится самостоятельно
readList(L):-	write("set the list size: "),read(N),
		writeln("set the list: "),readList(N,0,[],L).

readList(N,N,CurList,CurList):-!.
readList(N,CurN,CurList,L):-	NewN is CurN+1,read(Y),
				appendList(CurList,[Y],NewList),
				readList(N,NewN,NewList,L).
% вывод списка
writeList([]):-!.
writeList([H|T]):-writeln(H),writeList(T).

% task 4.2 - сумма элементов списка (через рекурсию вниз)
% *если Sum - инициализирована, то проверить, правильно ли*
sum_list_down([],CurSum,CurSum):-!.
sum_list_down([H|T],CurSum,Sum):-	NewSum is CurSum+H,
					sum_list_down(T,NewSum,Sum).
sum_list_down(List,Sum):-	readList(List),
				sum_list_down(List,0,Sum).

% task 4.3 - сумма элементов списка (через рекурсию вверх)
% *если Sum - инициализирована, то проверить, правильно ли*
sum_list_up([],0):-!.
sum_list_up([H|T],Sum):-	sum_list_up(T,CurSum),
				Sum is CurSum+H.