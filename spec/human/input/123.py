def collatz_aux(n, fuel):
    res = []
    curr = n
    for _ in range(fuel):
        if curr == 1:
            res.append(1)
            break
        res.append(curr)
        if curr % 2 == 0:
            curr = curr // 2
        else:
            curr = 3 * curr + 1
    return res

def collatz_list(n, l):
    if not l or l[-1] != 1:
        return False
    # If l is a valid collatz sequence ending in 1, 
    # its length is exactly the minimum fuel required to generate it.
    return collatz_aux(n, len(l)) == l

def _orig_problem_123_pre(n):
    return n > 0

def _orig_problem_123_spec(n, output):
    if n <= 0:
        return False
    seq = []
    curr = n
    while True:
        seq.append(curr)
        if curr == 1:
            break
        if curr % 2 == 0:
            curr = curr // 2
        else:
            curr = 3 * curr + 1
    odds = [x for x in seq if x % 2 != 0]
    expected = sorted(odds)
    return output == expected

def problem_123_pre(n):
    return bool(_orig_problem_123_pre(n))

def problem_123_spec(n, output):
    return bool(_orig_problem_123_spec(n, output))
