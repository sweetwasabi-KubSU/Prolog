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

% выводит строку через список ASCII кодов символов
write_string([]):-!.
write_string([H|T]):-	put(H),
			write_string(T).

% открывает файл на запись
tell_file:-tell('C:/Users/prolog/output.txt').	% told - закрытие

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
% булеан множества => 2^A (A - мощность)
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