triple x = 3 * x
distance x y = sqrt (x * x + y * y)

description "ccg" = "tql"
description "zd" = "More Money Than God"
description "lfs" = "vegetable exploded"
description x = "no information"

f x
 | x <= 10 = x
 | x <= 20 = x/2
 | x <= 30 = x*x
 | otherwise = x*x*x