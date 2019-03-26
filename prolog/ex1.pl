/*-----------functions needed to implement the following problems-------------*/

/*replace function, that allows us to replace every X in a list with a Y(needed in program 2).*/
replace([],_,_,[]).
replace([X|T1],X,A,[A|T2]):-replace(T1,X,A,T2).
replace([B|T1],X,A,[B|T2]):-B\=X, replace(T1,X,A,T2).

/*merge 2 lists into 1 without dublicates(needed in program 2)*/
merge(L,M,S):-append(L,M,S1), /*append without dublicates by calling sort function*/
              sort(S1,S).

/*create S, such as S[x]=|L[x]-M[x]|(needed in program 3)*/
create_diff_list([],[],[]).
create_diff_list([H1|L],[H2|M],[X|S]):- X is abs(H1 - H2),
create_diff_list(L,M,S).

/*return the nth element of a list(needed in program 4)*/
return_nth(0,_,_).
return_nth(1,[H|_],H).
return_nth(X,[_|L],A):- Y is X-1,
                        return_nth(Y,L,A).
/*replace the nth element of a list(needed in program 4)*/
replace_nth([_|T], 1, X, [X|T]).
replace_nth([H|T], I, X, [H|R]):- I > 0, NI is I-1, replace_nth(T, NI, X, R).

/*fill list L with numbers N to M(needed in program 4)*/
fill(M,M,[]).
fill(N,M,[N1|L]):-  N1 is N+1,
fill(N1,M,L).

/*fills list with 0s(needed in program 4)*/
fill_with_0s(0,[]).
fill_with_0s(N,[H|T]) :- M is N - 1, H is 0, fill_with_0s(M, T).

/*check if 2 lists are the same(needed in program 4)*/
same([],[]).
same([H1|L],[H2|M]):- H1==H2,
                      same(L,M).

/*insert element X in the n-th index of a list(needed in program 5)*/
insert_nth(X,L,1,[X|L]).
insert_nth(X,[H|L],Pos,[H|Res]):- Pos > 1,
                                  Pos1 is Pos-1,
                                  insert_nth(X,L,Pos1,Res).

/*create a list of lists, from a given list, in polynomial time (O(N^2)), in order to generate all the possible solutions of program 5*/
list_of_lists(L,[H|R],Length,Count1,Count2):- Count1 =< Length, Count2 =< Length,
                                              select(Count1,L,L1),
                                              insert_nth(Count1,L1,Count2,H),
                                              NewC is Count2 + 1,
                                              list_of_lists(L,R,Length,Count1,NewC).

list_of_lists(L,R,Length,Count1, Count2):- Count2 > Length,
                                           NewC1 is Count1+1,
                                           list_of_lists(L,R,Length,NewC1,1).

list_of_lists(_,[],Length,Count1,_):-Count1 > Length.

/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*------------------------------program 1-------------------------------------*/


/*if we have 0 friends and 0 biscuits, we return true to end the recursion.*/
biscuits(0,0,[]).

/*base case, if only 1 friend is left, then give him all the biscuits*/
biscuits(Left,1,[Left|List]):-biscuits(0,0,List).

/*recursive function to give the biscuits*/
biscuits(Left,Friends,[X|List]):- Friends>0,
                                  X is (Friends+1)*(Friends)/2,
                                  Y is Left-X, W is Friends-1,
                                  biscuits(Y,W,List).

/*-------------------------------program 2------------------------------------*/

solvelists(L,M,S):- solve(L,M,S1,Found1),                                       /*call recursive solve function for the lists, and keep track of the variables you found their value*/
                    reverse(L, Lrev), reverse(M,Mrev),                          /*reverse them*/
                    solve(Lrev,Mrev,S2,Found2),                                 /*solve again(we are doing this, because in solve, if we find 2 variables we skip them)*/
                    merge(Found1,Found2,Found),                                 /*merge the found variables*/
                    solve_infinite_solutions(L,Found,Inf1),                     /*for the rest of them, who have infinite solutions call this function*/
                    solve_infinite_solutions(M,Found,Inf2),
                    merge(Inf1,Inf2,Inf),                                       /*merge everything into s*/
                    merge(S1,S2,S3),
                    merge(Inf,S3,S).                                            /*return S*/



/*base case, if we have reached the nil lists, return*/
solve([],[],[],[]).

/*case 1: H2 is a variable, and H1 is a const, then insert (H2,H1) to the result list, and replace in M and L H1 with H2*/
solve([H1|L],[H2|M],[(H2,H1)|S],[H2|Found]):- integer(H1),not(integer(H2)),
                                              replace(M,H2,H1,M1),replace(L,H2,H1,L1),
                                              solve(L1,M1,S,Found).

/*case 2: H1 is a variable, and H2 is a const, then insert (H1,H2) to the result list, and replace in L and M H1 with H2*/
solve([H1|L],[H2|M],[(H1,H2)|S],[H1|Found]):- integer(H2), not(integer(H1)),
                                              replace(L,H1,H2,L1),replace(M,H1,H2,M1),
                                              solve(L1,M1,S,Found).

/*case 3: Both of them are variables, so skip them*/
solve([H1|L],[H2|M],S,Found):- not(integer(H1)),not(integer(H2)),
                               solve(L,M,S,Found).

/*if both of them are numbers, continue only if they are equal*/
solve([H1|L],[H2|M],S,Found):- integer(H2), integer(H1),
                               H1=:=H2, solve(L,M,S,Found).

/*assign a value to the variables with infinite solutions and insert them into a list*/
solve_infinite_solutions([],_,[]).

solve_infinite_solutions([H|L],Found,S):- integer(H),                           /*not if it is an integer*/
                                          solve_infinite_solutions(L,Found,S).


solve_infinite_solutions([H|L],Found,S):- not(integer(H)),member(H,Found),      /*not if it has been already found*/
                                          solve_infinite_solutions(L,Found,S).

/*but if it is not yet found, (we have something like x=y), make both x and y equal to 1, and assign them into the result list*/
/*this, (x=y)=>(x=1,y=1) is one of infinite solutions*/
solve_infinite_solutions([H|L],Found,[(H,1)|S]):- not(integer(H)),not(member(H,Found)),
                                                  solve_infinite_solutions(L,Found,S).

/*------------------------------program 3-------------------------------------*/
/*base case, if we have reached empty lists, return*/
ugliness([],[],_).
/*if the lists are not of the same length, beautify the lists by removing the most irrelevant sock, and call ugliness again with the new lists*/
ugliness(L,M,U):- length(L,A),length(M,B),A>B,                                  /* find the 2 lengths and compare them*/
                  msort(L,L1), msort(M,M1),                                     /*sort the 2 lists(use msort in order to not nemove dublicates)*/
                  return_nth(B,M1,X),                                           /*find the last element of the shortest list*/
                  append(M1,[X],M2),                                            /*and add it again in the tail*/
                  irrelevant_sock(L1,M2,0,X,NewX),                              /*call the irrelevant_sock function to return the most irrelevant item of the list*/
                  select(NewX,L1,L2),                                           /*remove it from the bigger list*/
                  ugliness(L2,M1,U).                                            /*call ugliness function recursively*/

ugliness(L,M,U):- length(L,A),length(M,B),A<B,
                  msort(L,L1), msort(M,M1),
                  return_nth(A,L1,X),
                  append(L1,[X],L2),
                  irrelevant_sock(M1,L2,0,X,NewX),
                  select(NewX,M1,M2),
                  ugliness(L1,M2,U).

/*if the lists have the same length, sort them and find the max difference between the elements, which is the ugliness*/
ugliness(L,M,U):- length(L,A),length(M,B),A==B,
                  msort(L,L1),msort(M,M1),
                  create_diff_list(L1,M1,S),
                  max_list(S,U).

/*find the irrelevant sock and store it in X*/

/*3 base case, if we reach empty lists, or if they have different length*/
irrelevant_sock(_,[],_,X,X).
irrelevant_sock([],_,_,X,X).

irrelevant_sock([],[],_,X,X).
/*D: stores the maximum difference
  X: stores the ellement that creates it*/

irrelevant_sock([H1|L],[H2|M],D,X,Res):- not(integer(X)),
                                         D is abs(H1-H2),
                                         X is H1,
                                         irrelevant_sock(L,M,D,X,Res).

irrelevant_sock([H1|L],[H2|M],D,X,Res):-  integer(X),
                                          Z is abs(H1-H2),
                                          Z > D,
                                          irrelevant_sock(L,M,Z,H1,Res).

irrelevant_sock([H1|L],[H2|M],D,X,Res):-  integer(X),
                                          Z is abs(H1-H2),
                                          not(Z > D),
                                          irrelevant_sock(L,M,D,X,Res).

/*------------------------------program 4-------------------------------------*/

/*L:list with employers
  M: list with coins
  Mres: list with coins to return
  S: list with employees*/

corporation(L,Mres):-	length(L,A),                                              /*find the number of employers*/
                     	N is A+1,                                                 /*including little jim*/
                     	fill(0,N,S),                                              /*create a list with the employers*/
                     	fill_with_0s(N,M),                                        /*create a list with 0s to store the coins*/
  			              capitalism([0|L],M,S,Mres),!.                               /*call the recursive function(employer of little jim is defined as 0)*/

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
/*-------------------------------program 5------------------------------------*/

findlist([H|L],R):- length(H,N),                                                /*find the length of M1*/
                    list_of_lists(H,Lists1,N,1,1),                              /*and generate all possible solutions(O(n^2))*/
                    solve([H|L],Lists1,R).                                      /*call solve function to return the result*/


/*we represent a set as a list of lists*/
solve([M1,M2,M3,M4,M5],List,Res):-  find_moves(M1,List,Res1),print(Res1), nl,                   /*limit this set by finding the possible moves of M1*/
                                    find_moves(M2,Res1,Res2),print(Res2), nl,                  /*this is like an intersection of the sets of possible solutions for M1,..,M5*/
                                    find_moves(M3,Res2,Res3),print(Res3), nl,
                                    find_moves(M4,Res3,Res4),print(Res4), nl,
                                    find_moves(M5,Res4,Final),print(Final), nl,
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
