"Using swish https://swish.swi-prolog.org/,
main. in query"
2.1 --

par(Y)
	 :- convert(Y,Z),
    	not(member(0,Z)),
    	unique(Z),
    	div(Z , A , B),
    	createNumber(A, C),
    	createNumber(B, D),
    	compare(C, D).

convert(Y, B)
	:- number_codes(Y,X), maplist(plus(48),B,X).

mod_result(0,1).

compare(A,B)
	:- C is mod(A,B),
    mod_result(C,1).

div(L, A, B) :-
    append(A, B, L),
    length(A, N),
    length(B, N).

createNumber([A,B],X)
	:- X is (A*10 + B).

unique([]).
unique([_,[]]).
unique([H|T])
	:-not(member(H,T)),unique(T).

main
	:- par(7826).

2.2 --

pars(PARS)
	:- 	listmake([], 1000,PARS),
      !.

listmake(X, 10000, X).
listmake(X,R,T)
	:-  not(par(R)),
    	R1 is R+1,
    	listmake(X, R1, T).
listmake(X,R,T)
	:-  append(X, [R], L),
    	R1 is R + 1,
    	listmake(L, R1, T).

par([]).
par(Y)
	 :- convert(Y,Z),
    	not(member(0,Z)),
    	unique(Z),
    	div(Z , A , B),
    	createNumber(A, C),
    	createNumber(B, D),
    	compare(C, D).

convert(Y, B)
	:- number_codes(Y,X), maplist(plus(48),B,X).

mod_result(0,1).

compare(A,B)
	:- C is mod(A,B),
    mod_result(C,1).

div(L, A, B) :-
    append(A, B, L),
    length(A, N),
    length(B, N).


createNumber([A,B],X)
	:- X is (A*10 + B).

unique([]).
unique([_,[]]).
unique([H|T])
	:-not(member(H,T)),unique(T).

main
	:- pars(PARS),write(PARS).


-- 2.3

party(A,B)
    :- 	par(A),
    	  par(B),
		    convert(A, W),
      	convert(B, X),
      	append(W,X,K),
      	unique(K),
      	sort(K,C),
      	checkParty(C,[1,2,3,4,5,6,7,8,9], A, B), !.

checkParty([N|M], [H|T], A,B)
	:-  N = H,
    	checkParty(M,T, A, B).
checkParty(A, [H|T], C, D)
	:-  A = T,
    	found(H, C, D).

found(H, C, D)
	:- 	Check1 is mod(C,H),
    	mod_result(Check1,1),
    	Check2 is mod(D,H),
    	mod_result(Check2,1).


convert(Y, B)
	:- number_codes(Y,X), maplist(plus(48),B,X).

par([]).
par(Y)
	 :- convert(Y,Z),
    	not(member(0,Z)),
    	unique(Z),
    	div(Z, A, B),
    	createNumber(A, C),
    	createNumber(B, D),
    	compare(C, D).

mod_result(0,1).

compare(A,B)
	:- C is mod(A,B),
    mod_result(C,1).

div(L, A, B) :-
    append(A, B, L),
    length(A, N),
    length(B, N).

createNumber([A,B],X)
	:- X is (A*10 + B).

unique([]).
unique([_,[]]).
unique([H|T])
	:-not(member(H,T)),unique(T).

main
	:- party(3618, 5427).

--2.4

partys(PARTYS) :-
	pars(AllPars),
	check_allPars(AllPars, AllPars, _, PARTYS),
    !.

check_allPars(_, [], A, A).
check_allPars([H|T], [_|Y], TempStore, PARTYS)
	:-	check_party(H, Y, [], Result),
		Result \== [],
		append(TempStore,Result,Temp2),
		check_allPars(T, Y, Temp2, PARTYS).
check_allPars([_|T], [_|Y], TempStore, PARTYS)
	:-	check_allPars(T, Y, TempStore, PARTYS).

check_party(_, [], A, A).
check_party(CheckingNumber, [H|T], TempList, ResultList)
	:- 	party(CheckingNumber, H),
        append(TempList, [[CheckingNumber,H]], TempList2),
        check_party(CheckingNumber, T, TempList2, ResultList).
check_party(CheckingNumber, [_|T], TempList, ResultList)
	:-  check_party(CheckingNumber, T, TempList, ResultList).

pars(PARS)
	:- 	listmake([], 1000,PARS).

listmake(X, 10000, X).
listmake(X,R,T)
	:-  not(par(R)),
    	R1 is R+1,
    	listmake(X, R1, T).
listmake(X,R,T)
	:-  append(X, [R], L),
    	R1 is R + 1,
    	listmake(L, R1, T).

par([]).
par(Y)
	 :- convert(Y,Z),
    	not(member(0,Z)),
    	unique(Z),
    	div(Z , A , B),
    	createNumber(A, C),
    	createNumber(B, D),
    	compare(C, D).


convert(Y, B)
	:- number_codes(Y,X), maplist(plus(48),B,X).

mod_result(0,1).

compare(A,B)
	:- C is mod(A,B),
    mod_result(C,1).

div(L, A, B) :-
    append(A, B, L),
    length(A, N),
    length(B, N).


createNumber([A,B],X)
	:- X is (A*10 + B).

unique([]).
unique([_,[]]).
unique([H|T])
	:-not(member(H,T)),unique(T).

party(A,B)
    :- 	par(A),
    	par(B),
		convert(A, W),
    	convert(B, X),
    	append(W,X,K),
    	unique(K),
    	sort(K,C),
    	checkParty(C,[1,2,3,4,5,6,7,8,9], A, B).

checkParty([N|M], [H|T], A,B)
	:-  N = H,
    	checkParty(M,T, A, B).
checkParty(A, [H|T], C, D)
	:-  A = T,
    	found(H, C, D).

found(H, C, D)
	:- 	Check1 is mod(C,H),
    	mod_result(Check1,1),
    	Check2 is mod(D,H),
    	mod_result(Check2,1).


main
	:- partys(PARTYS),write(PARTYS).
