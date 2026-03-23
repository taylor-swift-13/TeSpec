def elem(i):
    return i * i - i + 1

def valid_triple(n, i, j, k):
    return (1 <= i and i < j and j < k and k <= n and 
            (elem(i) + elem(j) + elem(k)) % 3 == 0)

def get_max_triples_spec(n, result):
    # The spec defines result as the number of unique triples (i, j, k)
    # such that valid_triple(n, i, j, k) is true.
    # valid_triple requires 1 <= i < j < k <= n and sum(elem) % 3 == 0.
    
    if n < 3:
        expected = 0
    else:
        # Analyze elem(x) % 3:
        # x % 3 == 0 => elem(x) = 1
        # x % 3 == 1 => elem(x) = 1
        # x % 3 == 2 => elem(x) = 3 = 0 (mod 3)
        # So elem(x) % 3 is 0 if x % 3 == 2, and 1 otherwise.
        
        # We need elem(i) + elem(j) + elem(k) == 0 (mod 3).
        # Since values are in {0, 1}, the sum can be 0, 1, 2, 3.
        # 0 mod 3 => sum is 0 or 3.
        # Sum 0 requires (0, 0, 0) => all indices congruent to 2 mod 3.
        # Sum 3 requires (1, 1, 1) => all indices NOT congruent to 2 mod 3.
        
        # Count indices in 1..n congruent to 2 mod 3
        count_zeros = n // 3
        if n % 3 == 2:
            count_zeros += 1
            
        # Count indices in 1..n NOT congruent to 2 mod 3
        count_ones = n - count_zeros
        
        # Calculate combinations nC3
        def nC3(x):
            if x < 3: return 0
            return (x * (x - 1) * (x - 2)) // 6
            
        expected = nC3(count_zeros) + nC3(count_ones)
        
    return result == expected
