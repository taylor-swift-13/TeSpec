def _orig_generate_integers_spec(a, b, evens):
    if a <= b:
        (a_local, b_local) = (a, b)
    else:
        (a_local, b_local) = (b, a)
    limit = min(b_local + 1, 10)
    generated_seq = range(a_local, limit)
    expected = [i for i in generated_seq if i % 2 == 0]
    return evens == expected

def generate_integers_spec(a, b, output):
    return bool(_orig_generate_integers_spec(a, b, output))
