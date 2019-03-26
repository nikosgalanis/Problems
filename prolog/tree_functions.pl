tree_member(X,tree(X,_,_)).
tree_member(X,tree_member(X,T1,_)):-tree_member(X,T1).
tree_member(X,tree_member(X,_,T2)):-tree_member(X,T2).

binary_tree(void).
binary_tree(tree(X,L,R)):-binary_tree(L),binary_tree(R).

append([],L,L).
append([H|T],L,[H|L2]):-append(T,L,L2).

preorder(void,[]).
preorder(tree(X,L,R),[X,T]):-preorder(L,T1),preorder(R,T2),append(T1,T2,T).
