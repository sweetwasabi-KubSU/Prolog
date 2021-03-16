% task 5.1 - кто пьёт воду? кто держит зебру?
% дом - страна - напиток - животное - сигареты
predicate1:-	Houses=[_,_,_,_,_],

		in_list(Houses,[red,english,_,_,_]),
		in_list(Houses,[_,spanish,_,dog,_]),
		in_list(Houses,[green,_,coffee,_,_]),
		in_list(Houses,[_,ukrain,tea,_,_]),
		right_next([green,_,_,_,_],[white,_,_,_,_],Houses),
		in_list(Houses,[_,_,_,snail,old_gold]),
		in_list(Houses,[yellow,_,_,_,kool]),
		item_by_number(Houses,3,[_,_,milk,_,_]),
		item_by_number(Houses,1,[_,norway,_,_,_]),
		next_to([_,_,_,_,chester],[_,_,_,fox,_],Houses),
		next_to([_,_,_,_,kool],[_,_,_,horse,_],Houses),
		in_list(Houses,[_,_,orange,_,lucky_strike]),
		in_list(Houses,[_,japan,_,_,parlament]),
		next_to([_,norway,_,_,_],[blue,_,_,_,_],Houses),

		in_list(Houses,[_,WHO1,water,_,_]),
		in_list(Houses,[_,WHO2,_,zebra,_]),
		
		nl,writeln("***HOUSES***"),nl,
		writeln("*house,country,drink,animal,cigarettes*"),nl,
		write_list(Houses),nl,
		
		nl,writeln("***ANSWERS***"),nl,
		write(WHO1),writeln(" drinks water"),
		write(WHO2),writeln(" holds zebra"),nl.

% task 5.2 - какой цвет волос у каждого из друзей?
% фамилия - волосы
predicate2:-	Friends=[_,_,_],
		
		% чтобы избежать перестановки одного и того же варианта
		item_by_number(Friends,1,[belokurov,_]),
		item_by_number(Friends,2,[ryzhov,_]),
		item_by_number(Friends,3,[chernov,_]),
		
		in_list(Friends,[_,dark]),
		in_list(Friends,[_,blonde]),
		in_list(Friends,[_,red]),

		not(in_list(Friends,[belokurov,dark])),

		not(in_list(Friends,[belokurov,blonde])),
		not(in_list(Friends,[ryzhov,red])),
		not(in_list(Friends,[chernov,dark])),

		nl,writeln("***FRIENDS***"),nl,
		writeln("*surname,hair*"),nl,
		write_list(Friends),nl.

% task 5.3 - oпределить цвета платья и туфель на каждой из подруг
% имя - платье - туфли
predicate3:-	Friends=[_,_,_],

		item_by_number(Friends,1,[anya,_,_]),
		item_by_number(Friends,2,[valya,_,_]),
		item_by_number(Friends,3,[natasha,_,_]),

		in_list(Friends,[_,white,_]),
		in_list(Friends,[_,green,_]),
		in_list(Friends,[_,blue,_]),

		in_list(Friends,[_,_,white]),
		in_list(Friends,[_,_,green]),
		in_list(Friends,[_,_,blue]),

		in_list(Friends,[anya,A,A]),
		not(in_list(Friends,[valya,B,B])),
		not(in_list(Friends,[natasha,C,C])),

		not(in_list(Friends,[valya,white,_])),
		not(in_list(Friends,[valya,_,white])),

		in_list(Friends,[natasha,_,green]),

		nl,writeln("***FRIENDS***"),nl,
		writeln("*name,dress,shoes*"),nl,
		write_list(Friends),nl.

% task 5.4 - назвать фамилии слесаря, токаря и сварщика
% фамилия - профессия - братья/cёстры
predicate4:-	Friends=[_,_,_],
		
		in_list(Friends,[borisov,_,_]),
		in_list(Friends,[ivanov,_,_]),
		in_list(Friends,[semenov,_,_]),
		
		% locksmith	слесарь
		% turner	токарь
		% welder	сварщик

		in_list(Friends,[_,locksmith,_]),
		in_list(Friends,[_,turner,_]),
		in_list(Friends,[_,welder,_]),

		% "no"		нет братьев/сестёр
		% "yes" 	есть братья/сёстры
		% "unknown"	неизвестно

		in_list(Friends,[_,_,"no"]),
		in_list(Friends,[_,_,"yes"]),
		in_list(Friends,[_,_,"unknown"]),

		in_list(Friends,[_,locksmith,"no"]),
		in_list(Friends,[borisov,_,"yes"]),
		in_list(Friends,[semenov,_,"unknown"]),

		% позиция - старшинство
		item_by_number(Friends,1,[_,locksmith,_]),

		not(in_list(Friends,[semenov,turner,_])),
		right_next([_,turner,_],[semenov,_,_],Friends),

		nl,writeln("***FRIENDS***"),nl,
		writeln("*surname,profession,siblings*"),nl,
		write_list(Friends),nl.