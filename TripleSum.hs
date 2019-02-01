--sample function, you need to enter hear the function you each time neeed
f a b c = a+b+c
--sssum calls the solve function to produce the triple sum
sssum f a b c = solve f 1 a 1 b 1 c

solve :: (Int -> Int -> Int -> Int) -> Int -> Int -> Int -> Int -> Int -> Int -> Int
solve f i a j b k c =
 if i >= a then
    if j >= b then
        if k >= c then f a b c
        else solve f i a j b k n + solve f i a j b (n+1) c
      else solve f i a j m k c + solve f i a (m+1) b k c
    else solve f i o j b k c + solve f (o+1) a j b k c
  where o = (i+a) `div` 2
        m = (j+b) `div` 2
        n = (k+c) `div` 2
