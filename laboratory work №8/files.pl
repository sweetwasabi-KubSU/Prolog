% task 8.0 - вспомогательные предикаты

% чтение одной строки и запись в список
read_string(-1,A,A,N,N,1):-!.		% конец файла
read_string(10,A,A,N,N,0):-!.		% 10 - enter
read_string(X,L,CurL,N,CurN,Flag):-	NewN is CurN+1,
					append(CurL,[X],NewL),
					get0(Y),
					read_string(Y,L,NewL,N,NewN,Flag).
read_string(L,N,Flag):-	get0(X),
			read_string(X,L,[],N,0,Flag).

% чтение всех строк и запись в список
read_list_string(L,L,1):-!.
read_list_string(L,CurL,0):-	read_string(Line,_,Flag),
				append(CurL,[Line],NewL),
				read_list_string(L,NewL,Flag).
read_list_string(L):-	read_string(Line,_,Flag),
			read_list_string(L,[Line],Flag).

% чтение всех строк + длин и запись в списки 
read_list_string(L,L,Lengths,Lengths,1):-!.
read_list_string(L,CurL,Lengths,CurLengths,0):-	read_string(Line,Length,Flag),
						append(CurL,[Line],NewL),
						append(CurLengths,[Length],NewLengths),
						read_list_string(L,NewL,Lengths,NewLengths,Flag).
read_list_string(L,Lengths):-	read_string(Line,Length,Flag),
				read_list_string(L,[Line],Lengths,[Length],Flag).

% вывод списка списков
write_list_string([]):-!.
write_list_string([H|T]):-	write_string(H),nl,
				write_list_string(T).

% открытие файла на чтение
see_file:-see('C:/Users/prolog/input.txt').	% seen - закрытие

% открытие файла на запись
tell_file:-tell('C:/Users/prolog/output.txt').	% told - закрытие

% task 8.1 - решить пять задач

% task 8.1.1 (1/5) - прочитать из файла строки и вывести длину наибольшей строки
file_predicate_1_1:-	see_file,
			read_list_string(_,Lengths),
			seen,

			max_list_down(Lengths,Max),
			write("max string length: "),
			writeln(Max),nl.		

% task 8.1.2 (2/5) - определить, сколько в файле строк, не содержащих пробелы
file_predicate_1_2:-	see_file,
			read_list_string(L,_),
			seen,

			count_not_member(L,Count,32),
			write("number of strings without spaces: "),
			writeln(Count),nl.

% считает количество таких списков, в которых не содержится заданный элемент
count_not_member([],0,_):-!.
count_not_member([H|T],Count,X):-	not(member(H,X)),
					count_not_member(T,CurCount,X),
					Count is CurCount+1,!.	
count_not_member([_|T],Count,X):-	count_not_member(T,Count,X).

% task 8.1.3 (3/5) - найти и вывести на экран только те строки,
% в которых букв A больше, чем в среднем на строку
file_predicate_1_3:-	see_file,
			read_list_string(L,_),
			seen,

			counts_list(L,Counts,65),	% 65 - A
			arithmetic_mean(Counts,AM),
			nl,write("arithmetic mean: "),writeln(AM),

			writeln("strings, where 'A' occurs more than average:"),
			nl,double_list_output(L,Counts,AM),nl.

% cоздает список с количеством вхождений элемента в списки
counts_list([],[],_):-!.
counts_list([H|T],Counts,X):-	counts_list(T,CurCounts,X),
				number_times(H,HCount,X),
				append([HCount],CurCounts,Counts).

% считает среднее арифмитическое списка с округлением до целых
arithmetic_mean(L,AM):-	sum_list_up(L,Sum),
			list_length(L,Length),
			AM is Sum div Length.

% вывод тех элементов из первого списка, где значения второго списка больше заданного
% *предполагается, что оба списка одинаковой длины и как-то между собой сопоставлены*
double_list_output([],[],_):-!.
double_list_output([L|T1],[H|T2],X):-	H>X,write_string(L),nl,
					double_list_output(T1,T2,X),!.
double_list_output([_|T1],[_|T2],X):-	double_list_output(T1,T2,X).

% task 8.1.4 (4/5) - вывести самое частое слово
file_predicate_1_4:-	see_file,
			read_list_string(L,_),
			seen,
			
			most_common_word(L,MaxW,MaxC),

			nl,writeln("*if the frequency of occurrence is repeated,*"),
			writeln("*the first word is output*"),

			nl,write("the most common word: "),write_string(MaxW),nl,
			write("frequency of occurrance: "),writeln(MaxC),nl.

% определяет самое встречаемое слово в списках и частота встречаемости
most_common_word(L,MaxW,MaxC):-	all_get_words(L,Words),
				unique_list(Words,UniqueW),

				count_reps(UniqueW,Counts,Words),
				max_list_down(Counts,MaxC),

				list_el_numb(Counts,MaxC,Index),
				list_el_numb(UniqueW,MaxW,Index).	

% собирает список слов из всех списков
all_get_words([],[]):-!.
all_get_words([L|T],Words):-	all_get_words(T,CurWords),
				get_words(L,LWords,_),
				append(LWords,CurWords,Words).

% task 8.1.5 (5/5, ?) - вывести в отдельный файл строки,
% состоящие из слов, не повторяющихся в исходном файле
file_predicate_1_5:-	see_file,
			read_list_string(L,_),
			seen,

			all_get_words(L,Words),

			nl,writeln("strings with non-repeating words:"),
			nl,no_reps_output(Words,L),nl.

% вывод списков, состоящих из слов, не повторяющихся в заданном списке
no_reps_output(_,[]):-!.
no_reps_output(AllWords,[L|T]):-	L \= [],
					get_words(L,Words,_),
					unique_list(Words,UniqueW),
					count_reps(UniqueW,Counts,AllWords),
					contains_only(Counts,[1]),
					write_string(L),nl,
					no_reps_output(AllWords,T),!.
no_reps_output(AllWords,[_|T]):-	no_reps_output(AllWords,T).