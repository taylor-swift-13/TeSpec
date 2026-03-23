def make_a_pile_aux(n, current, fuel):
    output = []
    for _ in range(fuel):
        output.append(current)
        current += 2
    return output

def _orig_make_a_pile_spec(n, output):
    if n <= 0:
        return True
    if len(output) != n:
        return False
    for i in range(n):
        if output[i] != n + 2 * i:
            return False
    return True

def make_a_pile_spec(n, output):
    return bool(_orig_make_a_pile_spec(n, output))
