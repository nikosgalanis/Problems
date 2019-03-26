/*insert element X in the n-th index of a list*/
insert_nth(X,L,1,[X|L]).
insert_nth(X,[H|L],Pos,[H|Res]):- Pos > 1,
                                  Pos1 is Pos-1,
                                  insert_nth(X,L,Pos1,Res).

/*create a list of lists, from a given list, in polynomial time (O(N^2)), in order to generate all the possible solutions*/
list_of_lists(L,[H|R],Length,Count1,Count2):- Count1 =< Length, Count2 =< Length,
                                              select(Count1,L,L1),
                                              insert_nth(Count1,L1,Count2,H),
                                              NewC is Count2 + 1,
                                              list_of_lists(L,R,Length,Count1,NewC).

list_of_lists(L,R,Length,Count1, Count2):- Count2 > Length,
                                           NewC1 is Count1+1,
                                           list_of_lists(L,R,Length,NewC1,1).

list_of_lists(_,[],Length,Count1,_):-Count1 > Length.



findlist([H|L],R):- length(H,N),                                                 /*find the length of M1*/
                    list_of_lists(H,Lists1,N,1,1),                              /*and generate all possible solutions(O(n^2))*/
                    solve([H|L],Lists1,R).                                      /*call solve function to return the result*/


/*we represent a set as a list of lists*/
solve([M1,M2,M3,M4,M5],List,Res):-  find_moves(M1,List,Res1),print(Res1),       /*limit this set by finding the possible moves of M1*/
                                    find_moves(M2,Res1,Res2),print(Res2),       /*this is like an intersection of the sets of possible solutions for M1,..,M5*/
                                    find_moves(M3,Res2,Res3),print(Res3),
                                    find_moves(M4,Res3,Res4),print(Res4),
                                    find_moves(M5,Res4,Final),print(Final),
                                    member(Res,Final).                          /*the result is each member of this final list*/


/*given all the generated lists, find the ones that occur from M,and store them in a list of lists*/
find_moves(_,[],[]).

find_moves(M,[H|Lists],Res):- not(moved_only_one(M,H)),
                              find_moves(M,Lists,Res).

find_moves(M,[H|Lists],[H|Res]):- moved_only_one(M,H),
                                  find_moves(M,Lists,Res).



/*only one element is moved if we find such element. Two or more are moved if find_element return false.*/
moved_only_one(L,M):- find_element(L,M,_,1).

/*we check from 1 to N for the element
  it is changed, in case we remove it from both lists and they result in the same list
  (if 2 or more are changed, lists will never be the same)*/

find_element(L,M,X,C):- select(C,M,M1),
                        select(C,L,L1),
                        same(L1,M1),
                        X is C.

/*if they are not, check the next number*/
find_element(L,M,X,C):- select(C,M,M1),
                        select(C,L,L1),
                        not(same(L1,M1)),
                        C1 is C+1,
                        find_element(L,M,X,C1).
