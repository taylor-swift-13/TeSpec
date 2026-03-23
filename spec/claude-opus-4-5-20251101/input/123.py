def collatz_next(x):
    if x % 2 == 0:
        return x // 2
    else:
        return x * 3 + 1

def collatz_sequence(x, seq):
    if x <= 0:
        return False
    expected = []
    curr = x
    seen = set()
    while curr > 1:
        if curr in seen:
            return False
        seen.add(curr)
        expected.append(curr)
        curr = collatz_next(curr)
    expected.append(1)
    return expected == seq

def is_odd(x):
    return x % 2 != 0

def filter_odds(l):
    return [x for x in l if is_odd(x)]

def sorted_ascending(l):
    for i in range(len(l) - 1):
        if l[i] > l[i + 1]:
            return False
    return True

def is_permutation(l1, l2):
    return sorted(l1) == sorted(l2)

def _orig_get_odd_collatz_spec(n, output):
    if n <= 0:
        return False
    collatz_seq = []
    curr = n
    seen = set()
    while curr > 1:
        if curr in seen:
            return False
        seen.add(curr)
        collatz_seq.append(curr)
        curr = collatz_next(curr)
    collatz_seq.append(1)
    odds = filter_odds(collatz_seq)
    return is_permutation(odds, output) and sorted_ascending(output)

def get_odd_collatz_spec(n, output):
    return bool(_orig_get_odd_collatz_spec(n, output))
