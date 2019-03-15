--quicksort function
quicksort:: [Int] -> [Int]
quicksort [] = []
quicksort (h:t) = (quicksort less) ++ [h] ++ quicksort greater
  where
    less = filter ( < h) t
    greater = filter ( >= h) t

--return the n-th element of a list
return_nth :: Int -> [Int] -> Int
return_nth _ [] = 0
return_nth n (h:t)
  | n == 1 = h
  | otherwise = return_nth (n-1) t

--find the max element of a list
max_list :: [Int]->Int
max_list (h:[]) = h
max_list (h:t) = max h (max_list t)

--same with prolog's select function
select :: Int -> Int -> [Int] ->[Int]
select _ _ [] = []
select n x (h:t) | (x == h) = if n==0 then select 1 x t else h : select 1 x t
                 | otherwise = h : select n x t



--create list s, where each element is abs(l[i]-m[i])
create_diff_list :: [Int]->[Int]->[Int]
create_diff_list [] [] = []
create_diff_list (h1:l) (h2:m) = abs (h1-h2) : create_diff_list l m

--find the irrelevant sock and store it in x
--base case, if we reach empty lists
irrelevant_sock :: [Int] -> [Int] -> Int -> Int -> Int
irrelevant_sock [] _ _ x = x
irrelevant_sock _ [] _ x = x

irrelevant_sock (h1:l) (h2:m) d x | (z > d) = irrelevant_sock l m z h1
                                  | (z <= d) = irrelevant_sock l m d x
                                    where z = abs (h1-h2)

--ugliness function, same algorithm with 1st assignment
ugliness :: [Int] -> [Int] -> Int
ugliness [] [] = 0
ugliness l m  | (length l == length m) = max_list (create_diff_list l1 m1)
              | (length l < length m) = ugliness m l
              | (length l > length m) = ugliness new_l m1
                where new_l = select 0 new_x l1
                      new_x = irrelevant_sock l1 m2 0 x
                      m2 = m1 ++ [x]
                      x = return_nth (length m) m1
                      l1 = quicksort l
                      m1 = quicksort m
