def generate_integers_spec(a, b, evens):
    # Coq: let (a, b) := if a <=? b then (a, b) else (b, a)
    if a <= b:
        a_local, b_local = a, b
    else:
        a_local, b_local = b, a

    # Coq: min (b + 1) 10
    limit = min(b_local + 1, 10)

    # Coq: seq a (min (b + 1) 10 - a)
    # This generates a sequence starting at a_local with length (limit - a_local).
    # In Python, range(start, end) covers [start, end).
    # If limit <= a_local, the length is 0 (due to nat subtraction in Coq), 
    # and range(a_local, limit) is empty in Python, so this matches.
    generated_seq = range(a_local, limit)

    # Coq: filter (fun i => i mod 2 =? 0) ...
    expected = [i for i in generated_seq if i % 2 == 0]

    return evens == expected
