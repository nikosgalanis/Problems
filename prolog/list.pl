prefix([],M).
prefix([H|L],[H|M]):-prefix(L,M).

suffix(L,L).
suffix(X,[A|L]):-suffix(X,L).


sublist(L,M):-append(A,L,Y),append(Z,Y,M).


reverse([H|T],LR):-reverse(T,A),append(A,[H],LR).

adjacent(X,Y,L):-sublist([X,Y],L).
adjacent(X,Y,L):-sublist([Y,X],L).

last(X,L):-append(A,[X],L).

palindrome(L):-reverse(L,L).

evenlength([]).
evenlength([X,Y|T]):-evenlength(T).

delete([],X,[]).
delete([X|T],X,A,T1):-replace(T,X,T1).
delete([Y|T],X,[Y|T1]):-X\=Y,delete(T,X,T1).

replace([],X,A,[]).
replace([X|T1],X,A,[A|T2]):-replace(T1,X,A,T2).
replace([B|T1],X,A,[B|T2]):-B/=X, replace(T,X,A,T2).

nat(0).               /*needed for ordered function*/
nat(s(X)):-nat(X).

lesseq(0,X):-nat(X).
lesseq(s(X),s(Y):-lesseq(X,Y).


ordered([X]).  /*possibly wrong*/
ordered([]).
ordered([X,Y|L]):-lesseq(X,Y),ordered([Y|L]).

permutation([],[]).
permutation(L,[X|Y]):-select(X,L,Q),permutation(Q,Y).


replace(_, _, [], []).
replace(O, R, [O|T], [R|T2]) :- replace(O, R, T, T2).
replace(O, R, [H|T], [H|T2]) :- dif(H,O), replace(O, R, T, T2).
%ex5 with swap instead of replace
findlist([_],_).
findlist([H|L],R):- permutation(H,R),
                    moved_only_one(H,R),
                    findlist(L,R).


moved_only_one(L,M):- abstract(L,M,R),
                      delete_all(R,0,R1),
                      length(R1,2).
