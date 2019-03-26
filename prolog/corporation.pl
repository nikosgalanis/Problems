/*return the nth element of a list*/
return_nth(0,_,_).
return_nth(1,[H|_],H).
return_nth(X,[_|L],A):- Y is X-1,
                        return_nth(Y,L,A).
/*replace the nth element of a list*/
replace_nth([_|T], 1, X, [X|T]).
replace_nth([H|T], I, X, [H|R]):- I > 0, NI is I-1, replace_nth(T, NI, X, R).

/*fill list L with numbers N to M*/
fill(M,M,[]).
fill(N,M,[N1|L]):-  N1 is N+1,
fill(N1,M,L).

/*fills list with 0s*/
fill_with_0s(0,[]).
fill_with_0s(N,[H|T]) :- M is N - 1, H is 0, fill_with_0s(M, T).

/*check if 2 lists are the same*/
same([],[]).
same([H1|L],[H2|M]):- H1==H2,
same(L,M).

/*L:list with employers
  M: list with coins
  Mres: list with coins to return
  S: list with employees*/

corporation(L,Mres):-	length(L,A),                                              /*find the number of employers*/
                     	N is A+1,                                                 /*including little jim*/
                     	fill(0,N,S),                                              /*create a list with the employers*/
                     	fill_with_0s(N,M),                                        /*create a list with 0s to store the coins*/
  			              capitalism([0|L],M,S,Mres),!.                             /*call the recursive function(employer of little jim is defined as 0)*/

capitalism(_,M,[],M).                                                           /*if all employers have quitted, we have a base case*/

capitalism(L,M,S,Res):-  find_slave(L,S,Pos),                                   /*find the employer who has to do the job*/
  			                 change_coins(Pos,L,M,1,NewM),                          /*call recursive function to change the coins*/
  			                 delete(S,Pos,NewS),                                    /*delete the employer from the employers list*/
  			                 replace_nth(L,Pos,-1,NewL),                            /*replace his employee with -1*/
  			                 capitalism(NewL, NewM, NewS,Res).                      /*call again with the new list*/

find_slave(_,[],_).                                                             /*if we reach an empty employers list, we've reached a base case*/

find_slave(L,[H|S],Pos):-	member(H, L), find_slave(L,S,Pos).                    /*if H is an employee, he is not doing the job*/


find_slave(L,[H|_],Pos):-	not(member(H, L)), Pos is H.                          /*the first non-employee with the lowest number, does the job*/

change_coins(-1,_,R,_,R).                                                       /*base cases, if we reach 0, or someone who has been deleted (-1)*/
change_coins(0,_,R,_,R).
change_coins(X,L,M,C,R):- return_nth(X,M,A),                                    /*find the coins of X*/
                          B is A+C,                                             /*add C to them, where C is the nth call of the function(N level of the employes tree)*/
                          replace_nth(M,X,B,M1),                                /*replace in the coins list*/
                          return_nth(X,L,T),                                    /*find the employer of X*/
                          C1 is C+1,                                            /*add 1 level*/
                          change_coins(T,L,M1,C1,R).                            /*call again*/
