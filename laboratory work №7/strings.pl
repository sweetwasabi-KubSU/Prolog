% чтение строки и преобразование её в список ASCII кодов символов
read_string(10,L,L,N,N):-!.	% 10 - enter
read_string(X,L,CurL,N,CurN):-	NewN is CurN+1,append(CurL,[X],NewL),
				get0(Y),read_string(Y,L,NewL,N,NewN).
read_string(L,N):-	nl,write("input string: "),
			get0(X),read_string(X,L,[],N,0).

% вывод строки через список ASCII кодов символов
write_string([]):-!.
write_string([H|T]):-	put(H),
			write_string(T).

% вывод строки через список списков ASCII кодов символов
write_strings([]):-!.
write_strings([H|T]):-	write_string(H),nl,
			write_strings(T).

% task 7.1 - вывести строку три раза через запятую,
% показать количество символов в ней 
predicate1:-	read_string(L,N),nl,

		writeln("output string (three times): "),
		write_string(L),write(", "),
		write_string(L),write(", "),
		write_string(L),nl,nl,

		write("string length: "),writeln(N),nl.

% task 7.2 - найти количество слов в строке
predicate2:-	read_string(L,_),
		count_words(L,Count),
		write("number of words: "),
		writeln(Count),nl.

% считает количество слов в строке
count_words([],Count,Count):-!.
count_words(L,Count,CurCount):-	skip_spaces(L,CurL),
				get_word(CurL,NewL,Word),
				Word \= [],
				NewCount is CurCount+1,
				count_words(NewL,Count,NewCount),!.
count_words(_,Count,Count).
count_words(L,Count):-count_words(L,Count,0).

% убирает пробелы в начале строки
skip_spaces([32|T],NewL):-skip_spaces(T,NewL),!.
skip_spaces(L,L).

% вычленяет слово в начале строки
get_word([],[],[]):-!.
get_word(L,NewL,Word):-get_word(L,NewL,Word,[]).

get_word([],[],Word,Word).
get_word([32|T],T,Word,Word):-!.
get_word([H|T],NewL,Word,CurWord):-	append(CurWord,[H],NewWord),
					get_word(T,NewL,Word,NewWord).

% task 7.3 - определить самое встречаемое слово
predicate3:-	read_string(L,_),

		get_words(L,Words,_),
		unique_list(Words,UniqueW),

		count_reps(UniqueW,Counts,Words),
		max_list_down(Counts,MaxC),

		list_el_numb(Counts,MaxC,Index),
		list_el_numb(UniqueW,MaxW,Index),

		nl,writeln("*if the frequency of occurrence is repeated,*"),
		writeln("*the first word is output*"),

		nl,write("the most common word: "),write_string(MaxW),nl,
		write("frequency of occurrance: "),writeln(MaxC),nl.

% собирает список из слов
get_words([],Words,Words,C,C):-!.
get_words(L,Words,CurWords,C,CurC):-	skip_spaces(L,CurL),
					get_word(CurL,NewL,Word),
					Word \=[],
					NewC is CurC+1,
					append(CurWords,[Word],NewWords),
					get_words(NewL,Words,NewWords,C,NewC),!.
get_words(_,Words,Words,C,C).
get_words(L,Words,Count):-get_words(L,Words,[],Count,0).

% считает количество вхождений элементов из одного списка в другой список
count_reps([],[],_):-!.
count_reps([Word|T],Counts,Words):-	count_reps(T,CurCounts,Words),
					number_times(Words,Count,Word),
					append([Count],CurCounts,Counts).

% task 7.4 - вывести первые три символа и последние три символа, 
% если длина строки больше 5, иначе - вывести первый символ
% столько раз, какова длина строки
predicate4:-	read_string(L,Length),
		write("string length: "),write(Length),nl,

		(Length>5 -> Index is Length-3,

		build_list(L,CurL1,4),
		build_list_after(L,CurL2,Index),

		nl,write("first three characters: "),write_string(CurL1),
		nl,write("last three characters: "),write_string(CurL2),nl,nl;

		L \= [],
		list_el_numb(L,First,1),
		build_reps(Length,First,RepsL),

		nl,writeln("repeated first character,"),
		write("number of reps is equal to the length: "),
		write_string(RepsL),nl,nl).

% создает список, состоящий из одного элемента заданное количество раз
build_reps(0,_,L,L):-!.
build_reps(N,X,L,CurL):-	CurN is N-1,
				append(CurL,[X],NewL),
				build_reps(CurN,X,L,NewL).
build_reps(N,X,L):-build_reps(N,X,L,[]).

% task 7.5 - показать номера символов, совпадающих с последним символом строки
predicate5:-	read_string(L,Length),

		list_el_numb(L,X,Length),
		list_matches(L,Matches,X),

		write("matches: "),
		writeln(Matches),nl.

% собирает список индексов элементов, совпадающих с заданным
list_matches([],[],0,_):-!.
list_matches([H|T],Matches,Index,H):-	list_matches(T,CurMatches,CurIndex,H),
					Index is CurIndex+1,
					append(CurMatches,[Index],Matches),!.
list_matches([_|T],Matches,Index,X):-	list_matches(T,Matches,CurIndex,X),
					Index is CurIndex+1.
list_matches(List,Matches,X):-	reverse(List,InvList),
				list_matches(InvList,Matches,_,X).

% task 7.6 - показать третий, шестой, девятый и так далее символы
predicate6:-	read_string(L,_),
		string_seq(L,ResL,3),
		
		write("sequence: "),
		write_string(ResL),nl,nl.

% собирает в список элементы, чьи индексы делятся на заданное число
string_seq([],[],_,0):-!.
string_seq([H|T],ResL,X,I):-	string_seq(T,CurResL,X,CurI),
				I is CurI+1,(0 is I mod X ->
				append(CurResL,[H],ResL);ResL=CurResL).
string_seq(List,ResL,X):-	reverse(List,InvList),
				string_seq(InvList,ResL,X,_).

% task 7.7 - определите общее количество символов '+' и '-' в cтроке
% + количество символов, после которых следует цифра ноль
predicate7:-	read_string(L,_),

		number_times(L,CountP,43),	% 43 - '+'
		number_times(L,CountM,45),	% 45 - '-'
		CountPM is CountP+CountM,

		string_next(L,48,CountN),	% 48 - '0'

		nl,write("total quantity of '+' and '-': "),
		writeln(CountPM),

		write("number of characters followed by '0': "),
		writeln(CountN),nl.

% считает количество элементов, после которых следует заданный
string_next([],_,0):-!.
string_next([_|[]],_,0):-!.
string_next([_,H2|T],H2,Count):-	string_next([H2|T],H2,CurCount),
					Count is CurCount+1,!.
string_next([_|T],X,Count):-	string_next(T,X,Count).

% task 7.8 - определить, какой символ в строке встречается раньше 'x' или 'w'
% если какого-то из символов нет, вывести сообщение об этом
predicate8:-	read_string(L,_),

		X=119,W=120,

		(list_el_numb(L,X,I1),
		list_el_numb(L,W,I2) ->

		(I1<I2 -> S=X;S=W),
		write("success: "),put(S),writeln(" occurs earlier!"),nl;
		
		writeln("error: one of characters wasn't found!"),nl).

% task 7.9 - две строки: вывести большую по длине строку
% столько раз, на сколько символов отличаются строки
predicate9:-	read_string(L1,Length1),
		write("length: "),writeln(Length1),

		read_string(L2,Length2),
		write("length: "),writeln(Length2),

		(Length1>Length2 ->
		Reps is Length1-Length2,L=L1;
		Reps is Length2-Length1,L=L2),

		nl,write("quantity of reps: "),writeln(Reps),
		nl,write_reps(L,Reps),nl.

% выводит строку заданное количество раз
write_reps(_,0):-!.
write_reps(L,X):-	CurX is X-1,
			write_string(L),nl,
			write_reps(L,CurX).
			
% task 7.10 -  если строка начинается на 'abc', то
% заменить на 'www', иначе - добавить в конец строки 'zzz'
predicate10:-	read_string(L,_),

		(check_string(L,[97,98,99],[1,2,3]) ->
		
		build_list_after(L,CurL,3),
		append([119,119,119],CurL,ResL);

		append(L,[122,122,122],ResL)),

		write("output modified string: "),
		write_string(ResL),nl,nl.

% проверяет, находятся ли заданные элементы по заданным индексам
check_string(_,[],[]).
check_string(L,[Elem|T1],[Ind|T2]):-	list_el_numb(L,Elem,Ind),
					check_string(L,T1,T2),!.
check_string(_,_,_):-fail.

% task 7.11 - если длина строки больше 10, то оставить в строке
% только первые 6 символов, иначе - дополнить символами 'o' до длины 12
predicate11:-	read_string(L,Length),

		(Length>10 -> build_list(L,ResL,7);
		Count is 12-Length,build_reps(Count,111,Reps),
		append(L,Reps,ResL)),

		write("output modified string: "),
		write_string(ResL),nl,nl.

% task 7.12 - разделить строку на фрагменты по три подряд идущих символа:
% в каждом фрагменте средний символ заменить на случайный символ,
% не совпадающий ни с одним из символов этого фрагмента
% показать фрагменты, упорядоченные по алфавиту
% *главное условие: длина строки должна делиться на три*
predicate12:-	read_string(L,_),

		split_string(L,CurL,3),		% 3 - длина фрагмента
		ch_random_lists(CurL,NewL,2),	% 2 - индекс вставки
		double_sort(NewL,ResL),	
		
		nl,writeln("fragments with three characters:"),
		write_strings(CurL),nl,
		
		writeln("fragments with replaced middle character:"),
		write_strings(NewL),nl,

		writeln("sorted fragments:"),
		write_strings(ResL),nl.

% сортировка списка
sort_list([],L,L):-!.
sort_list(L,ResL,CurResL):-	max_list_down(L,Max),
				append([Max],CurResL,NewResL),
				list_el_numb(L,Max,I),
				list_delete_item(L,CurL,I),
				sort_list(CurL,ResL,NewResL).
sort_list(L,ResL):-sort_list(L,ResL,[]).

% сортировка списков в списке
double_sort([],L,L):-!.
double_sort([H|T],ResL,CurResL):-	sort_list(H,CurH),
					append(CurResL,[CurH],NewResL),
					double_sort(T,ResL,NewResL).
double_sort(L,ResL):-double_sort(L,ResL,[]).

% разделение строки на фрагменты с заданным количеством элементов
% *длина строки должна делиться на заданное число*
split_string([],[],_):-!.
split_string(L,ResL,Count):-	list_length(L,Length),
				Length>=Count,
				CurCount is Count+1,
				build_list(L,FragL,CurCount),
				build_list_after(L,CurL,Count),
				split_string(CurL,CurResL,Count),
				append([FragL],CurResL,ResL),!.
split_string(_,_,_):-fail.

% генерация кода символа, не совпадающего ни с одним элементом списка,
% *диапазон - маленькие буквы латинского алфавита [97,122]*
character_random(_,_,123):-	!,fail.
character_random(L,R,CurR):-	not(member(L,CurR)),
				R=CurR,!.
character_random(L,R,CurR):-	NewR is CurR+1,
				character_random(L,R,NewR).				
character_random(L,R):-character_random(L,R,97).

% замена в списках списка символа на заданной позиции
% другим рандомным символом, не совпадающим ни с одним
% из элементов списка
ch_random_lists([],L,L,_):-!.
ch_random_lists([H|T],ResL,CurResL,I):-	character_random(H,R),
					replace_character(H,CurH,R,I),
					append(CurResL,[CurH],NewResL),
					ch_random_lists(T,ResL,NewResL,I).
ch_random_lists(L,ResL,I):-ch_random_lists(L,ResL,[],I). 

% замена символа на заданной позиции
replace_character(L,ResL,X,I):-	list_delete_item(L,CurL,I),
				insert_list(CurL,ResL,X,I).

% замена местами двух символов по индексам
replace_characters(L,ResL,I1,I2):-	list_el_numb(L,X1,I1),
					list_el_numb(L,X2,I2),
					
					replace_character(L,CurL,X1,I2),
					replace_character(CurL,ResL,X2,I1).
% вставить элемент на заданный индекс
insert_list(L,ResL,X,Ind):-	build_list(L,L1,Ind),

				CurInd is Ind-1,
				build_list_after(L,L2,CurInd),

				append(L1,[X],CurL1),
				append(CurL1,L2,ResL).

% task 7.13 - заменить каждый четный символ
% на 'a': если символ не равен 'a' или 'b',
% на 'c': во всех остальных случаях
predicate13:-	read_string(L,_),
		replace_even(L,ResL),

		write("output modified string: "),
		write_string(ResL),nl,nl.

% выполняет поставленную в task 7.13 задачу
replace_even([],L,L,_):-!.
replace_even([H|T],CurL,ResL,I):-	CurI is I+1,
					1 is CurI mod 2,
					append(CurL,[H],NewL),
					replace_even(T,NewL,ResL,CurI),!.
replace_even([H|T],CurL,ResL,I):-	CurI is I+1,
					H \= 97,H \= 98,
					append(CurL,[97],NewL),
					replace_even(T,NewL,ResL,CurI),!.
replace_even([_|T],CurL,ResL,I):-	CurI is I+1,
					append(CurL,[99],NewL),
					replace_even(T,NewL,ResL,CurI).
replace_even(L,ResL):-replace_even(L,[],ResL,0).

% task 7.14 - найти количество цифр в строке
predicate14:-	read_string(L,_),
		count_digits(L,Count),

		write("number of digits: "),
		write(Count),nl,nl.

% считает количество цифр в строке
count_digits([],0):-!.
count_digits([H|T],Count):-	count_digits(T,CurCount),
				(H>=48,H=<57 ->
				Count is CurCount+1;
				Count=CurCount).