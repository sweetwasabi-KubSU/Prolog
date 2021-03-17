% task 5.1 - кто пьёт воду? кто держит зебру?
% вывод: дом - страна - напиток - животное - сигареты

% верный ответ:	норвежец пьёт воду
%		японец держит зебру

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
% вывод: фамилия - волосы

% верный ответ:	белокуров	рыжие
%		рыжов		брюнет
%		чернов		блондин

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
% вывод: имя - платье - туфли

% верный ответ:	аня	белое платье	белые туфли
% 		валя 	зеленое платье	синие туфли
% 		наташа 	синие платье	зеленые туфли

predicate3:-	Friends=[_,_,_],

		item_by_number(Friends,1,[anya,A,A]),
		item_by_number(Friends,2,[valya,_,_]),
		item_by_number(Friends,3,[natasha,_,green]),

		in_list(Friends,[_,white,_]),
		in_list(Friends,[_,green,_]),
		in_list(Friends,[_,blue,_]),

		in_list(Friends,[_,_,white]),
		in_list(Friends,[_,_,green]),
		in_list(Friends,[_,_,blue]),

		not(in_list(Friends,[valya,B,B])),
		not(in_list(Friends,[natasha,C,C])),

		not(in_list(Friends,[valya,white,_])),
		not(in_list(Friends,[valya,_,white])),

		nl,writeln("***FRIENDS***"),nl,
		writeln("*name,dress,shoes*"),nl,
		write_list(Friends),nl.

% task 5.4 - назвать фамилии слесаря, токаря и сварщика
% вывод: фамилия - профессия - братья/cёстры

% верный ответ:	иванов		слесарь
%		борисов		токарь
%		семёнов 	сварщик

predicate4:-	Friends=[_,_,_],

		% "no"		нет братьев/сестёр
		% "yes" 	есть братья/сёстры
		% "unknown"	неизвестно
		
		in_list(Friends,[borisov,_,"yes"]),
		in_list(Friends,[ivanov,_,_]),
		in_list(Friends,[semenov,_,"unknown"]),
		
		% locksmith	слесарь
		% turner	токарь
		% welder	сварщик

		in_list(Friends,[_,locksmith,"no"]),
		in_list(Friends,[_,turner,_]),
		in_list(Friends,[_,welder,_]),

		not(in_list(Friends,[semenov,turner,_])),

		% позиция - старшинство
		item_by_number(Friends,1,[_,locksmith,_]),
		right_next([_,turner,_],[semenov,_,_],Friends),

		nl,writeln("***FRIENDS***"),nl,
		writeln("*surname,profession,siblings*"),nl,
		write_list(Friends),nl.

% task 5.5 - как распределены жидкости по сосудам?
% вывод: сосуд - жидкость

% верный ответ:	кувшин		молоко
%		бутылка		лимонад
%		банка		квас
%		стакан		вода

% если рассматривать только расположение в ряд (а не в круг),
% то при единственном возможном варианте молоко находится в банке
% *из условия (противоречие): cтакан находится около банки и сосуда с молоком*

% верный ответ в данном контексте:	кувшин		вода
% 					бутылка		лимонад
%					стакан		квас
%					банка		молоко

predicate5:-	Vessels=[_,_,_,_],
		
		% jug	кувшин
		% can	банка

		in_list(Vessels,[bottle,_]),
		in_list(Vessels,[glass,_]),
		in_list(Vessels,[jug,_]),
		in_list(Vessels,[can,_]),

		in_list(Vessels,[_,milk]),
		in_list(Vessels,[_,lemonade]),
		in_list(Vessels,[_,kvass]),
		in_list(Vessels,[_,water]),

		not(in_list(Vessels,[bottle,water])),
		not(in_list(Vessels,[bottle,milk])),

		right_next([jug,_],[_,lemonade],Vessels),
		right_next([_,lemonade],[_,kvass],Vessels),
		
		not(in_list(Vessels,[can,lemonade])),
		not(in_list(Vessels,[can,water])),

		next_to([glass,_],[can,_],Vessels),
		next_to([glass,_],[_,milk],Vessels),

		nl,writeln("***VESSELS***"),nl,
		writeln("*vessel,liquid*"),nl,
		write_list(Vessels),nl.

% task 5.6 -  кто чем занимается?
% вывод: фамилия - профессия - место - связь

% *как описать: "воронов никогда не слышал о левицком"?*

% верный ответ:	воронов		танцор
%		павлов		певец
%		левицкий	писатель
%		сахаров		художник

predicate6:-	Talented=[_,_,_,_],

		item_by_number(Talented,1,[voronov,_,concert,writer]),
		item_by_number(Talented,2,[pavlov,_,_,painter]),
		item_by_number(Talented,3,[levitsky,_,concert,_]),
		item_by_number(Talented,4,[sakharov,_,_,writer]),

		in_list(Talented,[_,dancer,_,_]),
		in_list(Talented,[_,painter,studio,_]),
		in_list(Talented,[_,singer,debut,_]),
		in_list(Talented,[_,writer,_,painter]),

		not(in_list(Talented,[voronov,singer,_,_])),
		not(in_list(Talented,[levitsky,singer,_,_])),

		not(in_list(Talented,[pavlov,writer,_,_])),
		not(in_list(Talented,[pavlov,painter,_,_])),

		not(in_list(Talented,[sakharov,writer,_,_])),
		not(in_list(Talented,[voronov,writer,_,_])),

		nl,writeln("***TALANTED***"),nl,
		writeln("*surname,profession,place,connection*"),nl,
		write_list(Talented),nl.