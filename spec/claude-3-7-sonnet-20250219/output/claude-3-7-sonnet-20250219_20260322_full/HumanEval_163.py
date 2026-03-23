def even(n):
    return n % 2 == 0

def generate_integers_spec(a, b, res):
    if not (a > 0 and b > 0):
        return False
        
    min_b_9 = min(b, 9)
    # In Coq, subtraction on nat truncates at 0
    nat_sub = min_b_9 - a if min_b_9 >= a else 0
    seq_len = nat_sub + 1
    seq = list(range(a, a + seq_len))
    
    filtered1 = [i for i in seq if a <= i <= min_b_9]
    expected_res = [i for i in filtered1 if even(i)]
    
    if res != expected_res:
        return False
        
    if len(set(res)) != len(res):
        return False
        
    for x in res:
        if not ((a <= x <= b) or (b <= x <= a)):
            return False
            
    for x in res:
        if not even(x):
            return False
            
    lower = min(a, b)
    upper = min(max(a, b), 9)
    for x in range(lower, upper + 1):
        if even(x):
            if x not in res:
                return False
                
    return True

def _impl(a, b):
    if a > b: a, b = b, a
    return [i for i in range(a, min(b + 1, 10)) if i % 2 == 0]

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(generate_integers_spec(*input, output))

def generate_integers(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
