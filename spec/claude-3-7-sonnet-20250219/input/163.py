def even(n):
    return n % 2 == 0

def generate_integers_spec(a, b, res):
    # Clause 1 & 2: a > 0 /\ b > 0
    if not (a > 0 and b > 0):
        return False

    # Clause 3: res = filter ...
    limit = min(b, 9)
    
    # Coq: seq a (S (Nat.min b 9 - a))
    # Natural subtraction: if limit < a, limit - a = 0
    sub = limit - a if limit >= a else 0
    length = sub + 1
    seq = list(range(a, a + length))
    
    # Coq: List.filter (fun i => (a <=? i) && (i <=? (Nat.min b 9)))
    filtered_seq = [i for i in seq if a <= i <= limit]
    
    # Coq: filter (fun i => Nat.even i)
    expected_res = [i for i in filtered_seq if even(i)]

    if res != expected_res:
        return False

    # Clause 4: NoDup res
    if len(res) != len(set(res)):
        return False

    # Clause 5: forall x, In x res -> a <= x <= b \/ b <= x <= a
    for x in res:
        if not ((a <= x <= b) or (b <= x <= a)):
            return False

    # Clause 6: forall x, In x res -> even x
    for x in res:
        if not even(x):
            return False

    # Clause 7: forall x, even x -> (a <= x <= b \/ b <= x <= a) -> x <= 9 -> In x res
    # Since x is a nat and x <= 9, we only need to check integers from 0 to 9.
    for x in range(10):
        if even(x) and ((a <= x <= b) or (b <= x <= a)):
            if x not in res:
                return False

    return True
