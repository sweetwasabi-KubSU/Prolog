% проверяет, содержится ли в списке элемент
% *находит все вхождения элемента*
in_list([X|_],X).
in_list([_|T],X):-in_list(T,X).

% проверяет, находится ли элемент B справа от A в списке
% *находит все вхождения данной комбинации*
right_next(_,_,[_]):-!,fail.
right_next(A,B,[A|[B|_]]).
right_next(A,B,[_|List]):-right_next(A,B,List).

% проверяет, находится ли элемент B слева от A в списке
% *находит все вхождения данной комбинации*
left_next(_,_,[_]):-!,fail.
left_next(A,B,[B|[A|_]]).
left_next(A,B,[_|List]):-left_next(A,B,List).

% проверяет, находится ли B справа/слева от A
% *находит все вхождения данных комбинаций*
next_to(A,B,List):-right_next(A,B,List).
next_to(A,B,List):-left_next(A,B,List).

% находит элемент по номеру/номер по элементу
item_by_number([H|_],Num,Num,H):-!.
item_by_number([_|T],Num,CurNum,Item):-	NewNum is CurNum+1,
					item_by_number(T,Num,NewNum,Item).
item_by_number(List,Num,Item):-	item_by_number(List,Num,1,Item).

% выводит список
write_list([]):-!.
write_list([H|T]):-	write(H),nl,
			write_list(T).
