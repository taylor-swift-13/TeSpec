def _orig_search_spec(lst, output):
    counts = {}
    for x in lst:
        counts[x] = counts.get(x, 0) + 1
    valid_xs = []
    for (x, c) in counts.items():
        if x > 0 and c >= x:
            valid_xs.append(x)
    if not valid_xs:
        correct_ans = -1
    else:
        correct_ans = max(valid_xs)
    return output == correct_ans

def search_spec(lst, output):
    return bool(_orig_search_spec(lst, output))
