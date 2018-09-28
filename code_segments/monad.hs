half x = if even x
    then Just (x `div` 2)
    else Nothing

Just 20 >>= half
Just 20 >>= half >>= half
Just 20 >>= half >>= half >>= half
