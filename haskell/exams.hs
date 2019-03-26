slurp(y:ys) x = if(y <= x) then y: (slurp ys x) else []

out = ff [2..]

ff(x:xs) = [(x,[a|a<-slurp l x, (mod x a == 0)])]:ff(xs)

l = q [2..]
q(h:t) = h : q [y | y <-t, mod y h > 0]
