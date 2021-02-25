"Using swish https://swish.swi-prolog.org/,
main. in query"
1.1 ---

animal(kangeroo). animal(antelope). animal(coyote).
animal(dingo). animal(donkey). animal(elephant).
animal(horse). animal(jaguar). animal(aardvark).

vegetable(artichoke). vegetable(cabbage). vegetable(carrot).
vegetable(celery). vegetable(leek). vegetable(lettuce).
vegetable(marrow). vegetable(onion). vegetable(potato).

mineral(anatase). mineral(basalt). mineral(cobolt).
mineral(copper). mineral(galena). mineral(nickel).
mineral(sodium). mineral(silver). mineral(zircon).

 1.2 ---

 animal(kangeroo). animal(antelope). animal(coyote).
 animal(dingo). animal(donkey). animal(elephant).
 animal(horse). animal(jaguar). animal(aardvark).

 vegetable(artichoke). vegetable(cabbage). vegetable(carrot).
 vegetable(celery). vegetable(leek). vegetable(lettuce).
 vegetable(marrow). vegetable(onion). vegetable(potato).

 mineral(anatase). mineral(basalt). mineral(cobalt).
 mineral(copper). mineral(galena). mineral(nickel).
 mineral(sodium). mineral(silver). mineral(zircon).


spell(A,X)
 	:-animal(A),
     atom_chars(A, X).
 spell(A,X)
 	:-vegetable(A),
       atom_chars(A, X).
 spell(A,X)
 	:-mineral(A),
       atom_chars(A, X).

 main
 	:- spell(cobalt,X),write(X).

1.3 ---

animal(kangeroo). animal(antelope). animal(coyote).
animal(dingo). animal(donkey). animal(elephant).
animal(horse). animal(jaguar). animal(aardvark).

vegetable(artichoke). vegetable(cabbage). vegetable(carrot).
vegetable(celery). vegetable(leek). vegetable(lettuce).
vegetable(marrow). vegetable(onion). vegetable(potato).

mineral(anatase). mineral(basalt). mineral(cobalt).
mineral(copper). mineral(galena). mineral(nickel).
mineral(sodium). mineral(silver). mineral(zircon).

spell(A,X)
 	:-	animal(A),
     	atom_chars(A, X).
 spell(A,X)
 	:-vegetable(A),
       atom_chars(A, X).
 spell(A,X)
 	:-mineral(A),
       atom_chars(A, X).

isCorrect(A,Index_first,Index_second,Length)
	:- 	spell(A, X),
    	length(X,L),
    	Length = L,
    	nth0(Index_first,X,F),
    	nth0(Index_second,X,F).

solution_word(A)
	:-	animal(A),
    	isCorrect(A,1,3,6).

solution_word(A)
	:-	vegetable(A),
    	isCorrect(A,2,4,6).

solution_word(A)
	:-	mineral(A),
   		isCorrect(A,0,2,7),
    	isCorrect(A,0,4,7).

check_List([], A, A).
check_List([N|M], TempStore, PARTYS)
	:-	check_a(N, [], Result),
		Result \== [],
		append(TempStore,[Result],Temp2),
		check_List(M, Temp2, PARTYS).
check_List([_|Y], TempStore, PARTYS)
	:-	check_List(Y, TempStore, PARTYS).

check_a([], A, A).
check_a([H|T], TempList, ResultList)
	:- 	solution_word(H),
    	append(TempList, H, TempList2),
        check_a(T, TempList2, ResultList).
check_a([_|T], TempList, ResultList)
	:-  check_a(T, TempList, ResultList).

convert(Y, B)
	:- number_codes(Y,X), maplist(plus(48),B,X).

write_niner([],[],A,A).
write_niner([H|T],[N|M],NinerList,Temp2)
	:- 	spell(H,X),
    	convert(N,K),
    	length(X,L),
    	loop(L,X,K,NinerList,Temp),
    	write_niner(T,M,Temp,Temp2).

loop(_,[],[],A,A).
loop(R,Word,Number,Niner,Out)
	:- 	R > 0,
    	Index is R-1,
    	nth0(Index,Number,L),
    	nth0(Index,Word,Add),
    	replaceP(L,Add,Niner,NinerTemp),
    	R1 is R-1,
		loop(R1,Word,Number,NinerTemp,Out).

loop(_,[_|T],[_|M],Niner,Out)
	:- 	loop(6,T,M,Niner,Out).

replaceP(_, _, [], []).
replaceP(O, R, [O|T], [R|T2])
:- replaceP(O, R, T, T2).
replaceP(O, R, [H|T], [H|T2])
:- dif(H,O), replaceP(O, R, T, T2).

solution(OUT)
	:- 	Clues = [452589,658785,7378719],
    	An = [[kangeroo,donkey,coyote,antelope,dingo,elephant,horse,jaguar,aardvark],
              [artichoke,cabbage,carrot,leek,celery,potato,onion,lettuce,marrow],
              [anatase,sodium,basalt,cobalt,copper,galena,nickel,silver,zircon]],
    	check_List(An,_,OUTI),
    	write_niner(OUTI,Clues,[1,2,3,4,5,6,7,8,9],OUTII),
    	atomics_to_string(OUTII,OUT).
main
	:- 	solution(OUT),write(OUT),!.
