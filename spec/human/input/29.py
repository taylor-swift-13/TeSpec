def is_subsequence(l1, l2):
    i, j = 0, 0
    while i < len(l1) and j < len(l2):
        if l1[i] == l2[j]:
            i += 1
        j += 1
    return i == len(l1)

def problem_29_pre(input):
    return True

def problem_29_spec(input, substring, output):
    # 1. output is a subsequence of input
    if not is_subsequence(output, input):
        return False

    # 2. (forall s, In s output <-> (In s input /\ String.prefix substring s = true))
    
    # Check: forall s in output, s in input and has prefix
    for s in output:
        if s not in input:
            return False
        if not s.startswith(substring):
            return False

    # Check: forall s in input, if s has prefix, then s must be in output
    for s in input:
        if s.startswith(substring):
            if s not in output:
                return False

    return True
