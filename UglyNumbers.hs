--merge function to remove doublicates
merge_and_sort :: [Int] -> [Int] -> [Int]
merge_and_sort [] ys = ys
merge_and_sort xs [] = xs
merge_and_sort (x:xs) (y:ys) | x < y     = x : (merge_and_sort xs (y:ys))
                             | x > y     = y : (merge_and_sort (x:xs) ys)
                             | x == y    = x : merge_and_sort xs ys --if we find a doublicate, we ignore it

--n is an element of ugly, if n=1, or if n =2*k, or if n=3*k, or if n=5*k, where k is a member of multiples
--we use map function to apply the 2*, 3* and 5* to the members of the list
--we also merge 3* with 5* and then all of it with 2*, to remove doublicates
ugly = 1 : merge_and_sort(map (2*) multiples) (merge_and_sort (map (3*) multiples) (map(5*) multiples))
