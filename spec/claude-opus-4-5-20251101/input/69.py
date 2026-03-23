def count_occurrences(n, lst):
    return lst.count(n)

def valid_candidate(n, lst):
    return n > 0 and n in lst and count_occurrences(n, lst) >= n

# def search_spec(lst, result):
#     valid_candidates = [n for n in set(lst) if valid_candidate(n, lst)]
#     if valid_candidates:
#         return result == max(valid_candidates)
#     return True

def search_spec(lst, result):
    valid_candidates = [n for n in set(lst) if valid_candidate(n, lst)]
    if valid_candidates:
        return result == max(valid_candidates)
    return result == -1
