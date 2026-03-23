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

def _impl(lst):
    ans = 0
    for num in lst:
        if num % 2 == 1 and num > 0 and "." not in str(num):
            ans += num ** 2
    return ans

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(double_the_difference_spec(*input, output))

def double_the_difference(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
