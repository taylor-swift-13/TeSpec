from typing import List

def IsPrime(n: int) -> bool:
    if n <= 1:
        return False
    for d in range(2, int(n**0.5) + 1):
        if n % d == 0:
            return False
    return True

def problem_25_pre(input: int) -> bool:
    return True

def problem_25_spec(input: int, output: list) -> bool:
    # Check if output is sorted in ascending order
    for i in range(len(output) - 1):
        if output[i] > output[i + 1]:
            return False
            
    # Check if the product of the output equals the input
    prod = 1
    for x in output:
        prod *= x
    if prod != input:
        return False
        
    # Check if all elements in the output are prime
    for x in output:
        if not IsPrime(x):
            return False
            
    return True

def _impl(n: int) -> List[int]:
    import math
    fact = []
    i = 2
    while i <= int(math.sqrt(n) + 1):
        if n % i == 0:
            fact.append(i)
            n //= i
        else:
            i += 1
    if n > 1:
        fact.append(n)
    return fact

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_25_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_25_spec(*input, output))

def factorize(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
