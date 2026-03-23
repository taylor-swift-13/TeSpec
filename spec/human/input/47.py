def problem_47_pre(input):
    return len(input) > 0

def problem_47_spec(input, output):
    # In Coq, `/\` binds tighter than `<->`, so the spec parses as:
    # forall r, In r input <-> (In r Sorted_input /\ P)
    # For an empty input, `In r input` is False. We can choose Sorted_input = []
    # so `In r Sorted_input` is False, making the right side False regardless of P.
    # Thus, for an empty list, the spec evaluates to True for ANY output.
    if len(input) == 0:
        return True

    # For non-empty inputs, the intended semantics of the Coq spec (and the standard
    # median calculation) requires Sorted_input to be a permutation of the input
    # (preserving all elements and their multiplicities).
    sorted_input = sorted(input)
    n = len(input)
    halflen = n // 2

    def nth(lst, idx, default=0.0):
        if 0 <= idx < len(lst):
            return lst[idx]
        return default

    if n % 2 == 1:
        expected = nth(sorted_input, halflen, 0.0)
    else:
        idx1 = halflen
        idx2 = max(0, halflen - 1)
        expected = (nth(sorted_input, idx1, 0.0) + nth(sorted_input, idx2, 0.0)) / 2.0

    return float(output) == expected
