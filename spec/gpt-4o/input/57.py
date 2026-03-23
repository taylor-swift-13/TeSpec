def monotonic_spec(l, result):
    inc = all(l[i] <= l[i+1] for i in range(len(l) - 1))
    dec = all(l[i] >= l[i+1] for i in range(len(l) - 1))
    return result == (inc or dec)
