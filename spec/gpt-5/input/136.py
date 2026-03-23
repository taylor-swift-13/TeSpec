def _orig_largest_smallest_integers_spec(lst, a, b):
    negatives = [x for x in lst if x < 0]
    if not negatives:
        expected_a = None
    else:
        expected_a = max(negatives)
    positives = [x for x in lst if x > 0]
    if not positives:
        expected_b = None
    else:
        expected_b = min(positives)
    return a == expected_a and b == expected_b

def largest_smallest_integers_spec(lst, output):
    return bool(_orig_largest_smallest_integers_spec(lst, output[0], output[1]))
