maxInList [x] = x
maxInList (x:xs) = max x (maxInList xs)

reverse [] = []
reverse [x] = [x]
reverse (x:xs) = reverse xs ++ [x]

quicksort [] = []
quicksort (x:xs) = (quicksort [y | y <- xs, y < x]) ++ [x] ++ (quicksort [y | y <- xs, y >= x])