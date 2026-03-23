def count_occurrences(n, lst):
    return lst.count(n)

def valid_candidate(n, lst):
    return n > 0 and n in lst and count_occurrences(n, lst) >= n

def _orig_search_spec(lst, output):
    valid_candidates = [n for n in set(lst) if valid_candidate(n, lst)]
    if valid_candidates:
        return output == max(valid_candidates)
    return output == -1

def search_spec(lst, output):
    return bool(_orig_search_spec(lst, output))
