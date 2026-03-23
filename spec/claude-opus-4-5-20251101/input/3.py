def prefix_sums(ops, acc):
    res = []
    for op in ops:
        acc += op
        res.append(acc)
    return res

def _orig_below_zero_spec(operations, output):
    balances = prefix_sums(operations, 0)
    has_negative = any((bal < 0 for bal in balances))
    return bool(output) == has_negative

def below_zero_spec(operations, output):
    return bool(_orig_below_zero_spec(operations, output))
