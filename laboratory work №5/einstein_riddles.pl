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

		in_list(Houses,[_,Who1,water,_,_]),
		in_list(Houses,[_,Who2,_,zebra,_]),

		write_list(Houses),nl,
		write("ANSWER: "),write(Who1),write(" drinks water"),nl,
		write("ANSWER: "),write(Who2),write(" holds zebra").