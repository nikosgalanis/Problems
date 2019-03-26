parent(john,mary).
father(tom,jim).
male(john).
male(tom).
male(jim).

son(X,Y):-parent(Y,X),male(X).

ancestor(X,Y):-parent(X,Y).

ancestor(X,Y):-parent(Z,Y),ancestor(X,Z).
