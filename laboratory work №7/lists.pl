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

% последнее вхождение (через рекурсию вверх)
% reverse (task 4.10)
% list_length (task 4.17)
list_el_numb_last(List,Elem,Num):-	reverse(List,InvList),
					list_el_numb(InvList,Elem,CurNum),
					list_length(List,Length),
					Num is Length-CurNum+1.

% task 4.*4 - чтение списка, чтение элемента
% найти номер первого вхождения элемента в список
% *+ проверка на правильность*
% predicate4:-	readList(List),
%		write("set the item: "),read(Item),
%		(list_el_numb(List,Item,Number) ->
%		write("first item number: "),write(Number);
%		write("sorry: item isn't in the list!")).

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

% task 4.8 - чтение списка, найти минимальный элемент
predicate8:-	readList(List),
		(min_list_up(List,Min) ->
		write("min = "),write(Min)).

% task 4.9 - проверить, есть ли в списке заданный элемент
member([X|_],X):-!.
member([_|T],X):-member(T,X).

% task 4.10 - перевернуть список
reverse([],CurList,CurList):-!.
reverse([H|T],CurList,InvList):-reverse(T,[H|CurList],InvList).
reverse(List,InvList):-reverse(List,[],InvList).

% task 4.11 - проверить, встречаются ли элементы Sublist в List в том же порядке
list_same_order([],_):-!.
list_same_order([H|T1],[H|T2]):-list_same_order(T1,T2),!.	
list_same_order(Sublist,[_|T]):-list_same_order(Sublist,T).

% task 4.12 - удалить элемент с заданным номером
list_delete_item([_|T],CurList,ResList,CurN,CurN):-	appendList(CurList,T,ResList),!.
list_delete_item([H|T],CurList,ResList,CurN,N):-	appendList(CurList,[H],NewList),
							NewN is CurN+1,
							list_delete_item(T,NewList,ResList,NewN,N).
list_delete_item(List,ResList,N):-list_delete_item(List,[],ResList,1,N).

% task 4.13 - удалить все элементы равные данному
list_delete_equal([],CurList,CurList,_):-!.
list_delete_equal([H|T],CurList,ResList,H):-	list_delete_equal(T,CurList,ResList,H),!.
list_delete_equal([H|T],CurList,ResList,X):-	appendList(CurList,[H],NewList),
						list_delete_equal(T,NewList,ResList,X).	
list_delete_equal(List,ResList,X):-list_delete_equal(List,[],ResList,X).

% task 4.14 - проверить, встречаются ли все элементы только один раз
unique([]):-!.
unique([H|T]):-	not(member(T,H)),
		unique(T).

% task 4.15 - убрать повторяющиеся элементы из списка
unique_list([],[]):-!.
unique_list([H|T],ResList):-	list_delete_equal(T,NewList,H),
				unique_list(NewList,CurList),
				appendList([H],CurList,ResList).

% task 4.16 - посчитать сколько раз встречается элемент в списке
number_times([],0,_):-!.
number_times([H|T],X,H):-	number_times(T,CurX,H),
				X is CurX+1,!.
number_times([_|T],X,N):-	number_times(T,X,N).

% task 4.17 - посчитать длину списка
list_length([],0):-!.
list_length([_|T],X):-	list_length(T,CurX),
			X is CurX+1.

% TASK 18.9: 9, 10, 21, 23, 33, 36, 39, 45, 57

% task 4.18.9 (1/9) - найти элементы, расположенные перед последним минимальным
predicate9(ResList):-	readList(List),
			min_list_up(List,Min),
			list_el_numb_last(List,Min,Num),
			build_list(List,ResList,Num).

% собирает в новый список элементы до заданного номера
build_list(_,CurList,CurList,1):-!.
build_list([H|T],CurList,ResList,Num):-	appendList(CurList,[H],NewList),
					CurNum is Num-1,
					build_list(T,NewList,ResList,CurNum).
build_list(List,ResList,Num):-build_list(List,[],ResList,Num).

% task 4.18.10 (2/9) - два массива: найти количество, совпадающих по значению элементов
predicate10(Count):-	readList(L1),
			readList(L2),
			match_by_value(L1,L2,Count).

% считает количество пар элементов, совпадающих по значению (через рекурсию вниз)
match_by_value([],_,CurCount,CurCount):-!.
match_by_value([H|T],L2,CurCount,Count):-	(list_el_numb(L2,H,Num) ->
						list_delete_item(L2,CurL2,Num),NewCount is CurCount+1;
						CurL2=L2,NewCount=CurCount),
						match_by_value(T,CurL2,NewCount,Count).
match_by_value(L1,L2,Count):-match_by_value(L1,L2,0,Count).

% task 4.18.21 (3/9) - найти элементы, расположенные после первого максимального
predicate21(ResList):-	readList(List),
			max_list_down(List,Max),
			list_el_numb(List,Max,Num),
			build_list_after(List,ResList,Num).

% нахождение максимального элемента в списке
max_list_down([],CurMax,CurMax):-!.
max_list_down([H|T],CurMax,Max):-	(H>CurMax -> NewMax=H;NewMax=CurMax),
					max_list_down(T,NewMax,Max).
max_list_down([H|T],Max):-max_list_down(T,H,Max).

% собирает в новый список элементы после заданного номера (через рекурсию вниз)
build_list_after([],CurL,CurL,_):-!.
build_list_after([H|T],CurL,ResL,N):-	NewN is N-1,
					(NewN<0 -> appendList(CurL,[H],NewL);NewL=CurL),
					build_list_after(T,NewL,ResL,NewN).
build_list_after(L,ResL,N):-build_list_after(L,[],ResL,N).

% task 4.18.23 (4/9) - найти два наименьших элемента
% если нужно, чтобы не повторялись, то list_delete_equal(List,CurList,Min1)
predicate23(Min1,Min2):-	readList(List),
				min_list_down(List,Min1),
				list_el_numb(List,Min1,Num),
				list_delete_item(List,CurList,Num),
				min_list_down(CurList,Min2).

% task 4.18.33 (5/9) - проверить, чередуются ли положительные и отрицательные числа
predicate33:-	readList(List),
		alternating(List).

% проверяет, чередуются ли положительные и отрицательные
alternating([],_):-!.
alternating([H|T],1):-	H>0,alternating(T,-1),!.
alternating([H|T],-1):-	H<0,alternating(T,1),!.
alternating([H|T]):-	(H>0 -> F=(-1);F=1),
			alternating(T,F).

% task 4.18.36 (6/9) - найти максимальный нечетный элемент
predicate36(Max):-	readList(List),
			odd_max(List,Max).

% находит максимальный нечётный элемент
odd_max([],CurMax,CurMax):-	1 is CurMax mod 2,!.
odd_max([H|T],CurMax,Max):-	(H>CurMax,1 is H mod 2 -> NewMax=H;NewMax=CurMax),
				odd_max(T,NewMax,Max).
odd_max(List,Max):-	min_list_up(List,CurMax),
			odd_max(List,CurMax,Max).

% task 4.18.39 (7/9) - вывести вначале его элементы с четными индексами, а затем - с нечетными
predicate39:-	readList(List),
		write("even index: "),print_even(List),nl,
		write("odd index: "),print_odd(List).

% печатает элементы с чётным индексом
print_even([],_):-!.
print_even([_|T],1):-	print_even(T,2),!.
print_even([H|T],2):-	write(H),write(" "),
			print_even(T,1),!.
print_even(List):-	print_even(List,1).

% печатает элементы с нечётным индексом
print_odd([],_):-!.
print_odd([H|T],1):-	write(H),write(" "),
			print_odd(T,2),!.
print_odd([_|T],2):-	print_odd(T,1),!.
print_odd(List):-	print_odd(List,1).

% task 4.18.45 (8/9) - найти сумму элементов из интервала (a,b)
predicate45(Sum):-	readList(List),
			write("A = "),read(A),
			write("B = "),read(B),
			build_interval(List,Interval,A,B),
			sum_list_up(Interval,Sum).

% собирает в новый список элементы из заданного интервала
build_interval([],[],_,_,_):-!.
build_interval([H|T],Interval,N,A,B):-	CurN is N+1,build_interval(T,CurInterval,CurN,A,B),
					(CurN>A,CurN<B -> appendList([H],CurInterval,Interval);
					Interval=CurInterval).
build_interval(List,Interval,A,B):-build_interval(List,Interval,0,A,B).

% task 4.18.57 (9/9) - найти количество элементов, бОльших суммы всех предыдущих
% первый элемент не считается, так как до него нет других элементов 
predicate57(Count):-	readList(List),
			more_sum_previous(List,Count).

% считает количество элементов, бОльших суммы всех предыдущих 
more_sum_previous([],_,CurCount,CurCount):-!.
more_sum_previous([H|T],Sum,CurCount,Count):-	(H>Sum -> NewCount is CurCount+1;NewCount=CurCount),
						CurSum is Sum+H,more_sum_previous(T,CurSum,NewCount,Count).
more_sum_previous([H|T],Count):-more_sum_previous(T,H,0,Count).

% task to pass - найти количество элементов,
% расположенных между первым макс. и последним мин.
% найти предшествующий максимум и предшествующий минимум
extra_predicate(Count,PrevMax,PrevMin):-	readList(List),

						max_list_down(List,Max),
						list_el_numb(List,Max,NumMax),

						min_list_down(List,Min),
						list_el_numb_last(List,Min,NumMin),

						(NumMax>NumMin -> Count is NumMax-NumMin-1;
						Count is NumMin-NumMax-1),

						list_delete_item(List,CurList1,NumMax),
						max_list_down(CurList1,PrevMax),

						% можно добавить поиск по номеру нового макс.
						% и его удаление - тогда при крайних случаях
						% программа не позволит совпадать и макс. и мин.

						list_el_numb(CurList1,Min,CurNumMin),
						list_delete_item(CurList1,CurList2,CurNumMin),
						min_list_down(CurList2,PrevMin).