def largest_divisor_spec(n: int, res: int) -> bool:
    if n <= 1:
        return res == 1
        
    if res < 1 or res >= n:
        return False
        
    if n % res != 0:
        return False
        
    # Directly implement the forall condition:
    # forall m : Z, 1 <= m < n -> Z.divide m n -> m <= res
    # This means there is no m in (res < m < n) that divides n.
    for m in range(res + 1, n):
        if n % m == 0:
            return False
            
    return True
