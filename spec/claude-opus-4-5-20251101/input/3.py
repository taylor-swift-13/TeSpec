def prefix_sums(ops, acc):
    res = []
    for op in ops:
        acc += op
        res.append(acc)
    return res

def below_zero_spec(operations, result):
    balances = prefix_sums(operations, 0)
    has_negative = any(bal < 0 for bal in balances)
    return bool(result) == has_negative
