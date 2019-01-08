member :: (Eq a) => a -> [a] -> Bool
member x [] = False
member x (y:ys) | x==y = True
                | otherwise = member x ys

--quicksort function
quicksort:: [Int] -> [Int]
quicksort [] = []
quicksort (h:t) = (quicksort less) ++ [h] ++ quicksort greater
  where
    less = filter ( < h) t
    greater = filter ( >= h) t


--replace the n-th element of a list with k
replace_nth:: Int -> Int -> [Int] -> [Int]
replace_nth n k l | (0 < n && n <= length l) = take (n-1) l ++ [k] ++ drop n l
                  | otherwise = l

v_is_visited::Int -> [(Int,Int)]-> [(Int,Int)]-> [(Int,Int)]
v_is_visited _ [] res = res
v_is_visited v ((x,y):t) res
                              | (v == x) = v_is_visited v t res ++ [(0,y)]
                              | (v == y) = v_is_visited v t res ++ [(x,0)]
                              | otherwise = v_is_visited v t res ++ [(x,y)]

--find the first adjacent vertex of vertex n
find_next::Int->[(Int,Int)]->Int
find_next n [] = 0
find_next n ((x,y):t) | (n==x) = y
                      | otherwise = find_next n t
--return the first element of a triple
return_x::(t,a,t) -> t
return_x (x,y,z) = x

--return the second element of a triple
return_y::(t,a,t) -> a
return_y (x,y,z) = y

--return the third element of a triple
return_z::(t,a,t) -> t
return_z (x,y,z) = z

--find the next vertex that is not yet visited
next_not_visited::[Int] -> Int
next_not_visited [] = 0
next_not_visited (h:l) | (h == 0) = next_not_visited l
                       | otherwise = h

--create a list with vertices that are adjacent to v
adjacent:: Int -> [(Int,Int)] -> [Int] -> [Int]
adjacent _ [] res = res
adjacent v ((x,y):edges) res | (x == v) = adjacent v edges res ++ [y]
                             | otherwise = adjacent v edges res

dfs::Int -> Int -> [Int] -> [(Int,Int)] -> [[Int]] -> [[Int]]
dfs 0 _ _ _ res = res
dfs n cnt vertices edges result | (cnt > length vertices) = result
                                | (n /= 0) = dfs next (cnt+1) new_vertices new_edges (result ++ [component])
                                    where new_vertices = return_x compute
                                          new_edges = return_y compute
                                          next = next_not_visited (new_vertices)
                                          component = return_z compute
                                          compute = dfs_loop n adj step_vertices edges []
                                          step_vertices = replace_nth n 0 vertices
                                          adj = quicksort (adjacent n edges [])

dfs_loop::Int -> [Int] -> [Int] -> [(Int,Int)] -> [Int] ->([Int], [(Int,Int)], [Int])
dfs_loop v [] vertices edges result | (member v result == True) = (vertices, edges, result)
                                    | otherwise = (vertices, edges, result++[v])
dfs_loop v (h:adj) vertices edges result = dfs_loop v adj new_vertices new_edges (result ++ res)
                                            where step_vertices = return_x compute
                                                  new_vertices = replace_nth v 0 step_vertices
                                                  new_edges = return_y compute
                                                  res = return_z compute
                                                  compute = dfs_util h vertices edges []

--depth first search in order to find all the connexted components
dfs_util::Int -> [Int] -> [(Int,Int)] -> [Int] ->([Int], [(Int,Int)], [Int])
dfs_util 0 vertices edges res = (vertices,edges, res)
dfs_util v vertices edges res | (member v res == True) =  dfs_util u new_vertices new_edges res
                              | otherwise =  dfs_util u new_vertices new_edges (res ++ [v])
                                  where u = find_next v edges
                                        new_vertices = replace_nth v 0 vertices
                                        new_edges = v_is_visited v edges []

--return a list with the lengths of each list in a list of lists
list_of_lengths::[[Int]]->[Int]
list_of_lengths [] = []
list_of_lengths (h:t) = length h : list_of_lengths t

--solve the problem
components::([Int],[(Int,Int)]) -> (Int,[Int])
components (vertices, edges ) = (length res, quicksort(list_of_lengths res))
                                    where res = dfs 1 1 vertices edges []
