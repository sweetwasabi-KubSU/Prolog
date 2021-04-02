% task 9.0 - вспомогательные предикаты

% проверяет, есть ли в списке заданный элемент
in_list([X|_],X).
in_list([_|T],X):-in_list(T,X).

% читает строку и преобразовывет её в список ASCII кодов символов
read_string(10,L,L,N,N):-!.	% 10 - enter
read_string(X,L,CurL,N,CurN):-	NewN is CurN+1,append(CurL,[X],NewL),
				get0(Y),read_string(Y,L,NewL,N,NewN).
read_string(L,N):-	nl,write("input string: "),
			get0(X),read_string(X,L,[],N,0).

% читает одну строку и записывает в список *файл*
read_string_file(-1,A,A,N,N,1):-!.		% -1 - конец файла
read_string_file(10,A,A,N,N,0):-!.		% 10 - enter
read_string_file(X,L,CurL,N,CurN,Flag):-	NewN is CurN+1,
						append(CurL,[X],NewL),
						get0(Y),
						read_string_file(Y,L,NewL,N,NewN,Flag).
read_string_file(L,N,Flag):-	get0(X),
				read_string_file(X,L,[],N,0,Flag).

% читает все строки и записывает в список *файл*
read_strings_file(L,L,1):-!.
read_strings_file(L,CurL,0):-	read_string_file(Line,_,Flag),
				append(CurL,[Line],NewL),
				read_strings_file(L,NewL,Flag).
read_strings_file(L):-	read_string_file(Line,_,Flag),
			read_strings_file(L,[Line],Flag).

% убирает последний элемент из списка
remove_last_item([_|[]],[]):-!.
remove_last_item([H|T],ResL):-	remove_last_item(T,CurL),
				append([H],CurL,ResL).

% читает все строки и записывает в список, кроме последнего *файл*
read_and_remove_last(L):-	read_strings_file(CurL),
				remove_last_item(CurL,L).

% выводит строку через список ASCII кодов символов
write_string([]):-!.
write_string([H|T]):-	put(H),
			write_string(T).

% вывод списка строк
write_strings([]):-!.
write_strings([H|T]):-	write_string(H),nl,
			write_strings(T).

% открывает основной файл на чтение
see_file:-see('C:/Users/prolog/output.txt').

% открывает основной файл на запись
tell_file:-tell('C:/Users/prolog/output.txt').

% открывает промежуточный файл на чтение
see_extra_file:-see('C:/Users/prolog/support.txt').

% открывает промежуточный файл на запись
tell_extra_file:-tell('C:/Users/prolog/support.txt').

% task 9.1 - решить шесть задач, результат записывать в файл
% *запуск от имени администратора*

% task 9.1.1 (1/6) - построить все размещения с повторениями по k элементов
% *A(n,k) = n^k*
build_all_k_perms_reps:-	read_string(A,_),

				write("input k: "),
				read(K),nl,

				writeln("output:"),
				not(build_k_perms_reps(A,K)),
			
				tell_file,
				not(build_k_perms_reps(A,K)),
				told,

				nl,writeln("*written to file*").
		
build_k_perms_reps(_,0,Perm):-	write_string(Perm),nl,
				!,fail.
build_k_perms_reps(A,K,Perm):-	in_list(A,X),
				CurK is K-1,
				build_k_perms_reps(A,CurK,[X|Perm]).
build_k_perms_reps(A,K):-build_k_perms_reps(A,K,[]).

% task 9.1.2 (2/6) - построить все перестановки
% *P(m) = m!*
build_all_perms:-	read_string(P,_),

			nl,writeln("output:"),
			not(build_perms(P)),
			
			tell_file,
			not(build_perms(P)),
			told,

			nl,writeln("*written to file*").

build_perms([],Perm):-	write_string(Perm),nl,
			!,fail.
build_perms(P,Perm):-	in_list_exlude(P,X,CurP),
			build_perms(CurP,[X|Perm]).
build_perms(P):-build_perms(P,[]).

% выбирает элемент и сохраняет оставшуюся часть списка
in_list_exlude([X|T],X,T).
in_list_exlude([H|T1],X,[H|T2]):-in_list_exlude(T1,X,T2).

% task 9.1.3 (3/6) - построить все размещения по k элементов
% *A(n,k) = n!/(n - k)!*
build_all_k_perms:-	read_string(A,_),

			write("input k: "),
			read(K),nl,

			writeln("output:"),
			not(build_k_perms(A,K)),

			tell_file,
			not(build_k_perms(A,K)),
			told,

			nl,writeln("*written to file*").
		
build_k_perms(_,0,Perm):-	write_string(Perm),nl,
				!,fail.
build_k_perms(A,K,Perm):-	in_list_exlude(A,X,CurA),
				CurK is K-1,
				build_k_perms(CurA,CurK,[X|Perm]).
build_k_perms(A,K):-build_k_perms(A,K,[]).

% task 9.1.4 (4/6) - построить все подмножества
% *булеан множества => 2^A (A - мощность)*
build_all_subsets:-	read_string(S,_),

			nl,writeln("output:"),
			not(build_subsets(S)),

			tell_file,
			not(build_subsets(S)),
			told,

			nl,writeln("*written to file*").

build_subsets([],[]).
build_subsets([H|SubSet],[H|Set]):-build_subsets(SubSet,Set).
build_subsets(SubSet,[_|Set]):-build_subsets(SubSet,Set).
build_subsets(S):-	build_subsets(SubSet,S),
			write_string(SubSet),
			nl,fail.

% task 9.1.5 (5/6) - построить все сочетания по k элементов
% *С(n,k) = n!/(k!*(n-k)!)*
build_all_k_combs:-	read_string(C,_),

			write("input k: "),
			read(K),

			nl,writeln("output:"),
			not(build_k_combs(C,K)),

			tell_file,
			not(build_k_combs(C,K)),
			told,

			nl,writeln("*written to file*").

build_k_combs([],0,_):-!.
build_k_combs([H|SubSet],K,[H|Set]):-	CurK is K-1,
					build_k_combs(SubSet,CurK,Set).
build_k_combs(SubSet,K,[_|Set]):-	build_k_combs(SubSet,K,Set).
build_k_combs(C,K):-	build_k_combs(Comb,K,C),
			write_string(Comb),
			nl,fail.

% task 9.1.6 (6/6) - построить все сочетания с повторениями *по k элементов*
% *C(n,k) = (n+k-1)!/(k!*(n-1)!)*
build_all_k_combs_reps:-	read_string(C,_),

				write("input k: "),
				read(K),

				nl,writeln("output:"),
				not(build_k_combs_reps(C,K)),

				tell_file,
				not(build_k_combs_reps(C,K)),
				told,

				nl,writeln("*written to file*").

build_k_combs_reps([],0,_):-!.
build_k_combs_reps([H|SubSet],K,[H|Set]):-	CurK is K-1,
						build_k_combs_reps(SubSet,CurK,[H|Set]).
build_k_combs_reps(SubSet,K,[_|Set]):-build_k_combs_reps(SubSet,K,Set).
build_k_combs_reps(C,K):-	build_k_combs_reps(Comb,K,C),
				write_string(Comb),
				nl,fail.

% task 9.3 - дано множество {a,b,c,d,e,f}, построить
% все слова длины 5, в которых ровно две буквы a,
% остальные не повторяются
% *(5!/(5-3)!) * C(5,2) = 600*
comb_predicate_9_2:-	L = [98,99,100,101,102],	% b, c, d, e, f

			tell_extra_file,
			not(build_k_perms(L,3)),
			told,
				
			see_extra_file,
			read_and_remove_last(CurL),
			seen,

			insert_n_times(CurL,NewL,97,2),
			list_length(NewL,Q),

			%nl,writeln("output:"),
			%write_strings(NewL),nl,

			write("quantity: "),
			writeln(Q),

			tell_file,
			write_strings(NewL),
			told,

			nl,writeln("*written to file*").

% выполняет вставку заданного элемента заданное количество раз
insert_n_times(L,L,_,0):-!.
insert_n_times(L,ResL,X,N):-	CurN is N-1,
				insert_n_times(L,CurL,X,CurN),
				all_inserts(CurL,ResL,X).

% из всех возможных перестановок *длины n*
% создает все возможные перестановки с заданным элементом *длины n+1*
% *новым элементом может быть и тот, что уже есть*
all_inserts([],[],_):-!.
all_inserts([W|T],ResL,X):-	all_inserts(T,CurL,X),
				insert_from(W,Ws,X),
				append(CurL,Ws,ResL).

% вставляет элемент на каждую позицию после последнего
% его вхождения (если элемента нет в списке, то с первой) 
% и создаёт список с данными комбинациями
insert_from(_,Ws,Ws,_,I,N):-I>N,!.
insert_from(L,Ws,CurWs,X,I,N):-	insert_list(L,W,X,I),
				append(CurWs,[W],NewWs),
				CurI is I+1,
				insert_from(L,Ws,NewWs,X,CurI,N).
insert_from(L,Ws,X):-	(list_el_numb_last(L,X,CurI) -> I is CurI+1;I=1),
			list_length(L,Length),
			N is Length+1,
			insert_from(L,Ws,[],X,I,N).

% *strings.pl* вставить элемент на заданный индекс
insert_list(L,ResL,X,Ind):-	build_list(L,L1,Ind),

				CurInd is Ind-1,
				build_list_after(L,L2,CurInd),

				append(L1,[X],CurL1),
				append(CurL1,L2,ResL).