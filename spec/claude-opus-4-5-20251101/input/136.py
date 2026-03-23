def is_negative(x):
    return x < 0

def is_positive(x):
    return x > 0

def largest_negative(lst):
    negatives = [x for x in lst if is_negative(x)]
    if not negatives:
        return None
    return max(negatives)

def smallest_positive(lst):
    positives = [x for x in lst if is_positive(x)]
    if not positives:
        return None
    return min(positives)

def largest_smallest_integers_spec(lst, result):
    expected_fst = largest_negative(lst)
    expected_snd = smallest_positive(lst)
    
    fst_result, snd_result = result
    
    if fst_result != expected_fst:
        return False
    if snd_result != expected_snd:
        return False
        
    return True
