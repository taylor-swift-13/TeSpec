def double_the_difference_spec(lst, result):
    """
    Python implementation of the Coq specification double_the_difference_spec.
    The specification checks if the result is equal to the sum of squares of 
    all positive odd integers in the list.
    """
    acc = 0
    for num in lst:
        # Coq: (Z.odd num && (0 <? num))%bool
        # Z.odd num is true if num is odd.
        # 0 <? num is true if num > 0.
        is_odd = (num % 2 != 0)
        is_positive = (num > 0)
        
        if is_odd and is_positive:
            acc = acc + (num * num)
        else:
            acc = acc
            
    # Coq: result = fold_left ...
    return result == acc
