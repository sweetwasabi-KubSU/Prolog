gender(joffrey_baratheon,1).
gender(stannis_baratheon,1).
gender(gendry,1).
gender(tommen_baratheon,1).
gender(robert_baratheon,1).
gender(ramsay_bolton,1).
gender(theon_greyjoy,1).
gender(yara_greyjoy,2).
gender(tyrion_lannister,1).
gender(cersei_lannister,2).
gender(jaime_lannister,1).
gender(tywin_lannister,1).
gender(jon_snow,1).
gender(sansa_stark,2).
gender(arya_stark,2).
gender(bran_stark,1).
gender(catelyn_stark,2).
gender(robb_stark,1).
gender(ned_stark,1).
gender(daenerys_targaryen,2).

house(joffrey_baratheon,2).
house(stannis_baratheon,2).
house(gendry,2).
house(tommen_baratheon,2).
house(robert_baratheon,2).
house(ramsay_bolton,3).
house(theon_greyjoy,5).
house(yara_greyjoy,5).
house(tyrion_lannister,6).
house(cersei_lannister,6).
house(jaime_lannister,6).
house(tywin_lannister,6).
house(jon_snow,7).
house(sansa_stark,7).
house(arya_stark,7).
house(bran_star,7).
house(catelyn_stark,7).
house(robb_stark,7).
house(ned_stark,7).
house(daenerys_targaryen,8).

existence(joffrey_baratheon,2).
existence(stannis_baratheon,2).
existence(gendry,1).
existence(tommen_baratheon,2).
existence(robert_baratheon,2).
existence(ramsay_bolton,2).
existence(theon_greyjoy,2).
existence(yara_greyjoy,1).
existence(tyrion_lannister,1).
existence(cersei_lannister,2).
existence(jaime_lannister,2).
existence(tywin_lannister,2).
existence(jon_snow,1).
existence(sansa_stark,1).
existence(arya_stark,1).
existence(bran_stark,1).
existence(catelyn_stark,2).
existence(robb_stark,2).
existence(ned_stark,2).
existence(daenerys_targaryen,2).

fight(joffrey_baratheon,1).
fight(stannis_baratheon,4).
fight(gendry,3).
fight(tommen_baratheon,1).
fight(robert_baratheon,1).
fight(ramsay_bolton,6).
fight(theon_greyjoy,7).
fight(yara_greyjoy,5).
fight(tyrion_lannister,5).
fight(cersei_lannister,1).
fight(jaime_lannister,2).
fight(tywin_lannister,6).
fight(jon_snow,5).
fight(sansa_stark,6).
fight(arya_stark,8).
fight(bran_stark,1).
fight(catelyn_stark,6).
fight(robb_stark,6).
fight(ned_stark,6).
fight(daenerys_targaryen,4).

season(joffrey_baratheon,4).
season(stannis_baratheon,5).
season(gendry,8).
season(tommen_baratheon,6).
season(robert_baratheon,1).
season(ramsay_bolton,6).
season(theon_greyjoy,8).
season(yara_greyjoy,8).
season(tyrion_lannister,8).
season(cersei_lannister,8).
season(jaime_lannister,8).
season(tywin_lannister,5).
season(jon_snow,8).
season(sansa_stark,8).
season(arya_stark,8).
season(bran_stark,8).
season(catelyn_stark,3).
season(robb_stark,3).
season(ned_stark,1).
season(daenerys_targaryen,8).

question1(X1):-	write("Is the character male or female?"),nl,nl,
		write("1. male"),nl,
		write("2. female"),nl,nl,
		read(X1),nl.

question2(X2):-	write("Which house does the character belong to/serve?"),nl,nl,
		write("1. House Arryn"),nl,
		write("2. House Baratheon"),nl,
		write("3. House Bolton"),nl,
		write("4. House Frey"),nl,
		write("5. House Greyjoy"),nl,
		write("6. House Lannister"),nl,
		write("7. House Stark"),nl,
		write("8. House Targaryen"),nl,
		write("9. Beyond the Wall"),nl,nl,
		read(X2),nl.

question3(X3):-	write("Did the character survive or die?"),nl,nl,
		write("1. survived"),nl,
		write("2. died"),nl,nl,
		read(X3),nl.

question4(X4):-	write("In the fight for the throne, the character..."),nl,nl,
		write("1. was the Lord of the Seven Kingdoms"),nl,
		write("2. helped the Lord of the Seven Kingdoms"),nl,
		write("3. was the heir who didn't rule"),nl,
		write("4. claimed the Iron throne of the Seven Kingdoms"),nl,
		write("5. helped to get the Iron throne of the Seven Kingdoms"),nl,
		write("6. owned part of the land (lord/lady)"),nl,
		write("7. helped the owner of the land"),nl,
		write("8. was neutral"),nl,nl,
		read(X4),nl.

question5(X5):-	write("In what season does the character last appear?"),nl,nl,
		write("1. in the first"),nl,
		write("2. in the second"),nl,
		write("3. in the third"),nl,
		write("4. in the fourth"),nl,
		write("5. in the fifth"),nl,
		write("6. in the sixth"),nl,
		write("7. in the seventh"),nl,
		write("8. in the eighth"),nl,nl,
		read(X5),nl.

game_of_thrones:-	nl,write("Well... Let the games begin!"),nl,nl,
			question1(X1),question2(X2),question3(X3),question4(X4),question5(X5),
		  	gender(X,X1),house(X,X2),existence(X,X3),fight(X,X4),season(X,X5),
		  	write("Now there will be magic: your character is "),write(X),write("!"),nl.