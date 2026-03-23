def is_prime(p):
    if p < 2:
        return False
    for i in range(2, int(p**0.5) + 1):
        if p % i == 0:
            return False
    return True

def problem_96_pre(n):
    return True

def problem_96_spec(n, result):
    # Property 1 & 2: All elements in result are prime and less than n
    for p in result:
        if not is_prime(p):
            return False
        if p >= n:
            return False
            
    # Property 3: All primes less than n are in result
    for p in range(2, n):
        if is_prime(p) and p not in result:
            return False
            
    # Property 4: The list is strictly ascending (Sorted lt result)
    for i in range(len(result) - 1):
        if result[i] >= result[i+1]:
            return False
            
    # Property 5: No duplicates in the list
    if len(set(result)) != len(result):
        return False
        
    return True

def _impl(n):
    ans = []
    isprime = [True] * (n + 1)
    for i in range(2, n):
        if isprime[i]:
            ans.append(i)
            for j in range(i + i, n, i):
                isprime[j] = False
    return ans

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_96_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_96_spec(*input, output))

def count_up_to(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
