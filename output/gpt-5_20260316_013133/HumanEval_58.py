
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    l1, l2 = input
    return isinstance(l1, list) and isinstance(l2, list)

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    l1, l2 = input
    if not isinstance(output, list):
        return False

    # Check uniqueness in output
    for i in range(len(output)):
        for j in range(i + 1, len(output)):
            try:
                if output[i] == output[j]:
                    return False
            except Exception:
                return False

    # Helper to check membership by equality without raising on incomparable pairs
    def in_by_eq(lst, val):
        for x in lst:
            try:
                if x == val:
                    return True
            except Exception:
                continue
        return False

    # Every output element should be present in both input lists
    for o in output:
        if not in_by_eq(l1, o):
            return False
        if not in_by_eq(l2, o):
            return False

    # Compute expected unique common elements
    commons = []
    for a in l1:
        if not in_by_eq(l2, a):
            continue
        already = False
        for c in commons:
            try:
                if a == c:
                    already = True
                    break
            except Exception:
                continue
        if not already:
            commons.append(a)

    # Ensure completeness: all expected elements are in output
    def any_equal(lst, val):
        for x in lst:
            try:
                if x == val:
                    return True
            except Exception:
                continue
        return False

    for e in commons:
        if not any_equal(output, e):
            return False

    # Check that output is sorted in non-decreasing order
    try:
        s = sorted(output)
    except Exception:
        return False
    if len(s) != len(output):
        return False
    for i in range(len(output)):
        try:
            if not (s[i] == output[i]):
                return False
        except Exception:
            return False

    return True

def _impl(l1: list, l2: list):
    """Return sorted unique common elements for two lists.
    [1, 5, 653]
    [2, 3]"""
    return sorted(list(set(l1).intersection(set(l2))))

def common(l1: list, l2: list):
    _input = (l1, l2)
    assert precondition(_input)
    _output = _impl(l1, l2)
    assert postcondition(_input, _output)
    return _output
