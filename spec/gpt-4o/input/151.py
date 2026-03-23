def _orig_double_the_difference_spec(lst, output):
    """
    Python implementation of the Coq specification double_the_difference_spec.
    The specification checks if the output is equal to the sum of squares of 
    all positive odd integers in the list.
    """
    acc = 0
    for num in lst:
        is_odd = num % 2 != 0
        is_positive = num > 0
        if is_odd and is_positive:
            acc = acc + num * num
        else:
            acc = acc
    return output == acc

def double_the_difference_spec(lst, output):
    return bool(_orig_double_the_difference_spec(lst, output))
