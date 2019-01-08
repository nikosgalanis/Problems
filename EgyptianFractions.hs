--if the fraction is grater than , we use a standard greedy algorithm
--we solve the problem, be each time reducing the fraction by 1/n,if 1/n is less or equal to the fraction
--we check till we reach 0
--due to fraction rounding, we can not add or reduce fractions, so we use their least common multiple(lcm)
fsolve::Int -> Int -> Int  -> [Int]
fsolve 0 _ _ = []
fsolve n m d  | (a >= b) = [d] ++ fsolve (a-b) ekp (d+1)
              | otherwise = fsolve n m (d+1)
                  where a = div (ekp*n) m
                        b = div ekp d
                        ekp = lcm m d

--find k, as 2^k-1 < n <= 2^k
find_next_bin::Int -> Int -> Int
find_next_bin n k | ((2^(k-1) < n) && (n <= 2^k)) = 2^k
                  | otherwise = find_next_bin n (k+1)

--analyse a number into powers of 2
powers_of_2::Int -> Int -> [Int]
powers_of_2 n 1 | (n == 1) = [1]
                | otherwise = []

powers_of_2 n k | (k <= n) = [k] ++ powers_of_2 (n-k) (div k 2)
                | otherwise = powers_of_2 n (div k 2)

--binary algorithm if the denominator is a power of 2
binary_exact:: Int -> Int -> [Int]
binary_exact p q = map (div q) (powers_of_2 p q)

--binary algorithm if the denominator is not a power of 2
binary_general:: Int -> Int -> [Int]
binary_general n m = (binary_exact s f) ++ (map(*m) (binary_exact r f))
                      where x = n * f
                            s = div x m
                            r = mod x m
                            f = find_next_bin m 1

--if the fraction is lower than 1, we call a binary algorithm for the solution
binary:: Int -> Int -> [Int]
binary n m | (m == find_next_bin m 1) = binary_exact n m
           | otherwise = binary_general n m

--we chose which algorithm to use, by determining if n is grater that m (the fraction is greater than 1)
fractions::Int -> Int -> [Int]
fractions n m | (n >= m) = fsolve n m 1
              | otherwise = binary n m
