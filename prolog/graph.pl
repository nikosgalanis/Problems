opedge(a,b).
edge(b,c).
edge(c,d).
edge(b,d).
path(X,Y):-edge(X,Y).
path(X,Y):-edge(X,Z),path(Z,Y).

replace(_, _, [], []).
replace(O, R, [O|T], [R|T2]) :- replace(O, R, T, T2).
replace(O, R, [H|T], [H|T2]) :- dif(H,O), replace(O, R, T, T2).
