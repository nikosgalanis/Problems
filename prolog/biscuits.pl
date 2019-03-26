/*if we have 0 friends and 0 biscuits, we return true to end the recursion.*/
biscuits(0,0,[]).

/*base case, if only 1 friend is left, then give him all the biscuits*/
biscuits(Left,1,[Left|List]):-biscuits(0,0,List).

/*recursive function to give the biscuits*/
biscuits(Left,Friends,[X|List]):- Friends>0,
                                  X is (Friends+1)*(Friends)/2,
                                  Y is Left-X, W is Friends-1,
                                  biscuits(Y,W,List).
