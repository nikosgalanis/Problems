# Problems

#### All problems implementated as exercises in course Principals Of Programming Languages


### Prolog Problems

equation_solver.pl

The user gives two lists with elements variables or consts, and the function solves the equation
ex: > solvelists[[1,x,z],[2,y,y],L]
      > L = [(y,2),(x,1),(z,2)]

-------------------------------------------------------------------------------------------------
limited_permutations.pl


Lets suppose a list with numbers from 1 to n (without doublicates, and not necessarily in order). 
Initially, we do not know that list. What we know, is 5 lists occurred from it, with the following pattern:
The first lists occurs from the unknown list if we move one of its elements in another position. 
The second one occurs with the movement of a different number in another position, etc. 
So if we give these 5 lists into solvelists, then the function returns the unknown list.

ex: > findlist([[1,2,5,3,4],[1,5,3,4,2],[4,2,1,5,3],[2,3,1,5,4],[2,1,3,4,5]],M)
     > M=[2,1,5,3,4].

This algorithm, uses pseudo-permutations, in order to have a O(n^3) complexity, instead of O(n!)

-------------------------------------------------------------------------------------------------
In this path, you will also find the pdf with the statement of the other implementated problems

-------------------------------------------------------------------------------------------------
All functions are interputed with swipl



### Haskell Problems
-------------------------------------------------------------------------------------------------------------------------------
Ugly Numbers: A number is called ugly, if its only divisors are 2, 3 or 5, so the number is written as 2^n * 3^m * 5^k,
              where n,m,k:integers > 0
              So we produce the infinite series of ugly numbers. 
              If you do not want this program to run forever, you can execute >take 100 ugly

------------------------------------------------------------------------------------------------------------------------------- 
TripleSUm:   You initialize a function, such as f a b c = a^2 + 3*b +6c + 1, and the program computes the sum, 
              as a runs from 1 to i, b from 1 to j, and c from 1 to k

-------------------------------------------------------------------------------------------------------------------------------
Egyptian Fractions: It is proven that each fraction can be writen as a sum of sipmple functions, (ex: 4/5 = 1/2 +1/4 +1/20).                        This progam gets a fraction from the input (as fractions 4 5 means 4/5), 
                     and computes the list of the denominators of the egyptian fractions for this number,
                     For fractions < 1, we use a very efficient binary algorithm, but for the others,
                     we use a standard greedy algorithm.
                    
-------------------------------------------------------------------------------------------------------------------------------  
ConnectedComponents: Given a graph, as a tuple of its components and a list of tuples(its vertices) 
                     the program gives the number of connected components, and the number of vertices that they include,
                     using dfs         
