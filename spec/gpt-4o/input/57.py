def _orig_monotonic_spec(l, output):
    inc = all((l[i] <= l[i + 1] for i in range(len(l) - 1)))
    dec = all((l[i] >= l[i + 1] for i in range(len(l) - 1)))
    return output == (inc or dec)

def monotonic_spec(l, output):
    return bool(_orig_monotonic_spec(l, output))
