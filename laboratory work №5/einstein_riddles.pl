% task 5.1 - кто пьёт воду? кто держит зебру?

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
		write_list(Houses),nl,
		
		nl,writeln("***ANSWERS***"),nl,
		write(WHO1),writeln(" drinks water"),
		write(WHO2),writeln(" holds zebra"),nl.

% task 5.2 - какой цвет волос у каждого из друзей?

predicate2:-	Friends=[[belokurov,_],[ryzhov,_],[chernov,_]],

		in_list(Friends,[_,dark]),
		in_list(Friends,[_,blonde]),
		in_list(Friends,[_,red]),
		not(in_list(Friends,[belokurov,dark])),
		not(in_list(Friends,[belokurov,blonde])),
		not(in_list(Friends,[ryzhov,red])),
		not(in_list(Friends,[chernov,dark])),

		nl,writeln("***FRIENDS***"),nl,
		write_list(Friends),nl.