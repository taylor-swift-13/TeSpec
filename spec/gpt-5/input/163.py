def generate_integers_spec(a, b, res):
    lo = min(a, b)
    hi = min(max(a, b), 9)
    
    if lo <= hi:
        # List.seq lo (S (Nat.sub hi lo)) generates numbers from lo to hi inclusive.
        # List.filter (fun i => Nat.even i) keeps only even numbers.
        expected = [i for i in range(lo, hi + 1) if i % 2 == 0]
    else:
        expected = []
        
    return res == expected
