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

readList(0,_,_,[]):-fail,!.
readList(N,N,CurList,CurList):-!.
readList(N,CurN,CurList,L):-	NewN is CurN+1,read(Y),
				appendList(CurList,[Y],NewList),
				readList(N,NewN,NewList,L).
% вывод списка
writeList([]):-!.
writeList([H|T]):-writeln(H),writeList(T).

% task 4.2 - сумма элементов списка (через рекурсию вниз)
% *+ проверка на правильность заданного значения*
sum_list_down([],CurSum,CurSum):-!.
sum_list_down([H|T],CurSum,Sum):-	NewSum is CurSum+H,
					sum_list_down(T,NewSum,Sum).
sum_list_down(List,Sum):-	readList(List),
				sum_list_down(List,0,Sum).

% task 4.3 - сумма элементов списка (через рекурсию вверх)
% *+ проверка на правильность заданного значения*
sum_list_up([],_):-fail,!.
sum_list_up([H],H):-!.
sum_list_up([H|T],Sum):-	sum_list_up(T,CurSum),
				Sum is CurSum+H.

% task 4.4 - если инициализирован Elem, то Num - номер первого вхождения
% если инициализирован Num, то Elem - элемент с этим номером
% *+ проверка на правильность заданных значений*
list_el_numb([],_,_,_):-fail,!.
list_el_numb([H|_],H,CurNum,CurNum):-!.
list_el_numb([_|T],Elem,CurNum,Num):-	NewNum is CurNum+1,
					list_el_numb(T,Elem,NewNum,Num).
list_el_numb(List,Elem,Num):-list_el_numb(List,Elem,1,Num).

% task 4.*4 - чтение списка, чтение элемента
% найти номер первого вхождения элемента в список
% *+ проверка на правильность*
predicate4:-	readList(List),
		write("set the item: "),read(Item),
		(list_el_numb(List,Item,Number) ->
		write("first item number: "),write(Number);
		write("sorry: item isn't in the list!")).

% task 4.5 - чтение списка, чтение номера элемента
% найти элемент в списке по заданному номеру
% *+ проверка на правильность*
predicate5:-	readList(List),
		write("set the number: "),read(Number),
		(list_el_numb(List,Item,Number) ->
		write("item by number: "),write(Item);
		write("sorry: item with this number isn't in the list!")).

% task 4.6 - найти минимальный элемент списка (через рекурсию вверх)
% *+ проверка на правильность*
min_list_up([],_):-fail,!.
min_list_up([H],H):-!.
min_list_up([H|T],Min):-	min_list_up(T,CurMin),
				(H<CurMin -> Min=H;Min=CurMin).

% task 4.7 - найти минимальный элемент списка (через рекурсию вниз)
% *+ проверка на правильность*
min_list_down([],CurMin,CurMin):-!.
min_list_down([H|T],CurMin,Min):-	(H<CurMin -> NewMin=H;NewMin=CurMin),
					min_list_down(T,NewMin,Min).
min_list_down([H|T],Min):-min_list_down(T,H,Min).