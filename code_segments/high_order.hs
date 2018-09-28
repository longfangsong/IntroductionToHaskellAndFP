map (*3) [1,2,3,4,5]
filter (<10) (map (*3) [1,2,3,4,5])
foldl (\acc x -> acc + x) 0 (filter (<10) (map (*3) [1,2,3,4,5]))
foldl (+) 0 (filter (<10) (map (*3) [1,2,3,4,5])) 