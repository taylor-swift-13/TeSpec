def problem_58_pre(l1, l2):
    return True

def problem_58_spec(l1, l2, l_out):
    expected = sorted(list(set(l1).intersection(set(l2))))
    return l_out == expected
