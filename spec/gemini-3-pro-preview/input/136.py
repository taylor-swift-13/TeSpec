def largest_smallest_integers_spec(lst, result):
    neg_res, pos_res = result
    
    # Check specification for the largest negative integer
    if neg_res is not None:
        if neg_res not in lst:
            return False
        if neg_res >= 0:
            return False
        for x in lst:
            if x < 0 and x > neg_res:
                return False
    else:
        for x in lst:
            if x < 0:
                return False
                
    # Check specification for the smallest positive integer
    if pos_res is not None:
        if pos_res not in lst:
            return False
        if pos_res <= 0:
            return False
        for x in lst:
            if x > 0 and x < pos_res:
                return False
    else:
        for x in lst:
            if x > 0:
                return False
                
    return True
