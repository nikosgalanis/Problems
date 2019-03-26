or([L],L).
or([H|T],W):- or(T,W1), append(H,W1,W).

q([X|Xs],[X|S]):-q(Xs,S).
q([],[]).
