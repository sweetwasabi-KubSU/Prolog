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
% если Sum - инициализирована, то проверить, правильно ли
sum_list_down([],CurSum,CurSum):-!.
sum_list_down([H|T],CurSum,Sum):-	NewSum is CurSum+H,
					sum_list_down(T,NewSum,Sum).
sum_list_down(List,Sum):-	readList(List),
				sum_list_down(List,0,Sum).

% task 4.3 - сумма элементов списка (через рекурсию вверх),
% если Sum - инициализирована, то проверить, правильно ли
sum_list_up([],0):-!.
sum_list_up([H|T],Sum):-	sum_list_up(T,CurSum),
				Sum is CurSum+H.

% task 4.4 - если дан Elem - запись в Num номер первого вхождения
% если дан Num - запись в Elem значения по этому номеру
% если даны Elem и Num - проверить, правильно ли
list_el_numb([],_,_,_):-fail,!.
list_el_numb([H|_],H,CurNum,CurNum):-!.
list_el_numb([_|T],Elem,CurNum,Num):-	NewNum is CurNum+1,
					list_el_numb(T,Elem,NewNum,Num).
list_el_numb(List,Elem,Num):-list_el_numb(List,Elem,1,Num).

% task 4.*4 - чтение списка, чтение элемента
% найти номер первого вхождения элемента в список
predicate4:-	readList(List),
		write("set the item: "),read(Item),
		(list_el_numb(List,Item,Number) ->
		write("first item number: "),write(Number);
		write("sorry: item isn't in the list!")).

% task 4.5 - чтение списка, чтение номера 
% найти по номеру элемент в списке
predicate5:-	readList(List),
		write("set the number: "),read(Number),
		(list_el_numb(List,Item,Number) ->
		write("item by number: "),write(Item);
		write("sorry: item with this number isn't in the list!")).