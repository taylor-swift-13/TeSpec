def count_occurrences(n, lst):
    return lst.count(n)

def valid_candidate(n, lst):
    return n > 0 and n in lst and count_occurrences(n, lst) >= n

def search_spec(lst, result):
    # Check if there exists any valid candidate in the list
    exists_valid = any(valid_candidate(n, lst) for n in lst)
    
    # First conjunct of the consequent: 
    # valid_candidate result lst /\ forall m, valid_candidate m lst -> m <= result
    is_max_valid = valid_candidate(result, lst) and all(m <= result for m in lst if valid_candidate(m, lst))
    
    # Second conjunct of the consequent: 
    # (~ exists n, valid_candidate n lst) -> result = -1
    # In Python, P -> Q is equivalent to (not P) or Q
    no_valid_implies_minus_one = exists_valid or (result == -1)
    
    # The overall Coq specification is an implication:
    # (exists n, valid_candidate n lst) -> (is_max_valid /\ no_valid_implies_minus_one)
    if exists_valid:
        return is_max_valid and no_valid_implies_minus_one
    else:
        # If the antecedent is false, the implication is vacuously true
        return True

def _impl(lst):
    count = dict()
    for num in lst:
        if num not in count:
            count[num] = 0
        count[num] += 1
    ans = -1
    for num, cnt in count.items():
        if cnt >= num:
            ans = max(ans, num)
    return ans

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(search_spec(*input, output))

def search(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
