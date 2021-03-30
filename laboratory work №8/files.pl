% task 8.0 - вспомогательные предикаты

% чтение одной строки и запись в список
read_string(-1,A,A,N,N,1):-!.		% -1 - конец файла
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

% вывод списка строк
write_list_string([]):-!.
write_list_string([H|T]):-	write_string(H),nl,
				write_list_string(T).

% вывод списка cлов
write_words_string([]):-!.
write_words_string([H|T]):-	write_string(H),write(" "),
				write_words_string(T).

% открытие файла на чтение
see_file:-see('C:/Users/prolog/input.txt').	% seen - закрытие

% открытие файла на запись
tell_file:-tell('C:/Users/prolog/output.txt').	% told - закрытие

% task 8.1 - решить пять задач

% task 8.1.1 (1/5) - прочитать из файла строки и вывести длину наибольшей строки
file_predicate_1_1:-	see_file,
			read_list_string(L,Lengths),
			seen,

			max_list_down(Lengths,Max),

			nl,writeln("strings from file:"),
			write_list_string(L),

			nl,write("max string length: "),
			writeln(Max),nl.		

% task 8.1.2 (2/5) - определить, сколько в файле строк, не содержащих пробелы
file_predicate_1_2:-	see_file,
			read_list_string(L,_),
			seen,

			count_not_member(L,Count,32),

			nl,writeln("strings from file:"),
			write_list_string(L),

			nl,write("number of strings without spaces: "),
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

			nl,writeln("strings from file:"),
			write_list_string(L),

			nl,write("arithmetic mean: "),writeln(AM),

			nl,writeln("strings, where 'A' occurs more than average:"),
			double_list_output(L,Counts,AM),nl.

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

			nl,writeln("strings from file:"),
			write_list_string(L),

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
% *запуск от имени администратора*
file_predicate_1_5:-	see_file,
			read_list_string(L,_),
			seen,

			all_get_words(L,Words),

			tell_file,
			no_reps_output(Words,L),
			told,

			nl,writeln("strings with non-repeating words:"),
			no_reps_output(Words,L),

			nl,writeln("*written to file*"),nl.

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

% TASK 8.2: 3, 8, 16

% task 8.2.3 (1/3) - необходимо перемешать слова в строке
% в случайном порядке, слова записаны через пробел

% есть случаи, когда невозможно сделать так, чтобы
% на позиции не находилось исходные слова
% например: "join milk join"
% следовательно, реализован вариант, когда слова
% случайно перемешиваются, но при этом какие-то
% из них могут остаться на исходной позиции, что
% в целом удовлетворяет условию случайного порядка

% можно реализовать вариант, чтобы записывались 
% исходные позиции и полученные рандомные,
% тогда перемешивание будет условно полным

file_predicate_2_3:-	see_file,
			read_string(L,_,_),
			seen,

			get_words(L,Ws,_),
			mix_words(Ws,RandomWs),

			nl,write("original word order: "),
			write_words_string(Ws),

			nl,write("random word order: "),
			write_words_string(RandomWs),nl,nl.

% перемешивает слова списка в случайном порядке
mix_words([],RandomWs,RandomWs,_,_):-!.
mix_words([W|T],RandomWs,CurRandomWs,LengthWs,I):-	CurI is I+1,
							list_length(W,LengthW),
							In is (((LengthW*CurI) mod LengthWs)+1),
							replace_two_words(CurRandomWs,NewRandomWs,CurI,In),
							mix_words(T,RandomWs,NewRandomWs,LengthWs,CurI).

mix_words(Ws,RandomWs):-	list_length(Ws,LengthWs),
				mix_words(Ws,RandomWs,Ws,LengthWs,0).

% ДАЛЕЕ ПЕРЕДЕЛАННЫЕ ПРЕДИКАТЫ ИЗ lists.pl и strings.pl

% меняет местами два слова по индексам
replace_two_words(Ws,ResWs,I1,I2):-	list_el_numb(Ws,W1,I1),
					list_el_numb(Ws,W2,I2),
					
					replace_word(Ws,CurWs,W1,I2),
					replace_word(CurWs,ResWs,W2,I1).

% меняет слово по заданному индексу
replace_word(Ws,ResWs,W,I):-	delete_word(Ws,CurWs,I),

				build_words_before(CurWs,NewWs1,I),
				CurI is I-1,
				build_words_after(CurWs,NewWs2,CurI),

				append(NewWs1,[W],ResWs1),
				append(ResWs1,NewWs2,ResWs).

% удаляет слово по заданному индексу
delete_word([_|T],CurWs,ResWs,I,I):-	append(CurWs,T,ResWs),!.
delete_word([W|T],CurWs,ResWs,I,CurI):-	append(CurWs,[W],NewWs),
					NewI is CurI+1,
					delete_word(T,NewWs,ResWs,I,NewI).
delete_word(Ws,ResWs,I):-delete_word(Ws,[],ResWs,I,1).

% собирает в новый список слова до заданного индекса
build_words_before(_,CurWs,CurWs,1):-!.
build_words_before([W|T],CurWs,ResWs,I):-	append(CurWs,[W],NewWs),
						CurI is I-1,
						build_words_before(T,NewWs,ResWs,CurI).
build_words_before(Ws,ResWs,I):-build_words_before(Ws,[],ResWs,I).

% собирает в новый список слова после заданного индекса
build_words_after([],CurWs,CurWs,_):-!.
build_words_after([W|T],CurWs,ResWs,I):-	CurI is I-1,CurI<0,
						append(CurWs,[W],NewWs),
						build_words_after(T,NewWs,ResWs,CurI),!.
build_words_after([_|T],CurWs,ResWs,I):-	CurI is I-1,
						build_words_after(T,CurWs,ResWs,CurI).
build_words_after(Ws,ResWs,I):-build_words_after(Ws,[],ResWs,I).

% task 8.2.8 (2/3) - посчитать количество слов с четным количеством символов
file_predicate_2_8:-	see_file,
			read_string(L,_,_),
			seen,

			get_words(L,Ws,_),
			count_div_words(Ws,Count,2),

			nl,write("string from file: "),
			write_words_string(Ws),

			nl,write("number of even-length words: "),
			writeln(Count),nl.

% считает количество слов, чья длина делится на заданное число
count_div_words([],0,_):-!.
count_div_words([W|T],Count,X):-	list_length(W,Length),
					0 is Length mod X,
					count_div_words(T,CurCount,X),
					Count is CurCount+1,!.
count_div_words([_|T],Count,X):-	count_div_words(T,Count,X).

% создаёт список из длин слов (не используется)
build_words_length([],[]):-!.
build_words_length([W|T],LengthWs):-	build_words_length(T,CurLengthWs),
					list_length(W,LengthW),
					append([LengthW],CurLengthWs,LengthWs).

% task 8.2.16 (3/3) - дан массив в котором находятся строки "белый", "синий"
% и "красный" в случайном порядке: необходимо упорядочить массив так, 
% чтобы получился российский флаг
% *кодировка input.txt - ANSI*
% *корректно ли условие?*
file_predicate_2_16:-	see_file,
			read_list_string(L,_),
			seen,

			White=[1073,1077,1083,1099,1081],
			Blue=[1089,1080,1085,1080,1081],
			%Red=[1082,1088,1072,1089,1085,1099,1081],

			list_el_numb(L,White,IW),
			replace_two_words(L,CurL,IW,1),

			list_el_numb(CurL,Blue,IB),
			replace_two_words(CurL,ResL,IB,2),

			nl,writeln("strings from file: "),
			write_list_string(L),

			nl,writeln("russian flag from these strings: "),
			write_list_string(ResL),nl.