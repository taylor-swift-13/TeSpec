def make_a_pile_aux(n, current, fuel):
    result = []
    for _ in range(fuel):
        result.append(current)
        current += 2
    return result

def make_a_pile_spec(n, result):
    if n <= 0:
        return True
    if len(result) != n:
        return False
    for i in range(n):
        if result[i] != n + 2 * i:
            return False
    return True
