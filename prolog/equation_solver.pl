/*merge 2 lists into 1 without dublicates*/
merge(L,M,S):-append(L,M,S1), /*append without dublicates by calling sort function*/
              sort(S1,S).

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
