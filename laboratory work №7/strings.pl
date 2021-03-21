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

% создает список, состоящий из одного элементааданное количество раз
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

% task 7.8 - определить, какой символ в строку встречается раньше 'x' или 'w'
% если какого-то из символов нет, вывести сообщение об этом
predicate8:-	read_string(L,_),

		X=119,W=120,

		(list_el_numb(L,X,I1),
		list_el_numb(L,W,I2) ->

		(I1<I2 -> S=X;S=W),
		write("success: "),put(S),writeln(" occurs earlier!"),nl;
		
		writeln("error: one of characters wasn't found!"),nl).	
