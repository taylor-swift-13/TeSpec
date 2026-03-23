def nat_sub(a, b):
    """Helper for Coq's natural number subtraction."""
    return a - b if a >= b else 0

def get_char(s, n):
    """Helper function mimicking Coq's get_char."""
    if 0 <= n < len(s):
        return s[n]
    return " "

def problem_38_pre(input):
    """Pre-condition for problem 38."""
    return True

def problem_38_spec(input, output):
    """Specification for problem 38."""
    if len(input) != len(output):
        return False

    L = len(input)
    # Coq uses nat subtraction, so 0 - 1 = 0
    n = nat_sub((L // 3) * 3, 1)

    for i in range(L):
        out_char = get_char(output, i)
        
        if i <= n:
            # Coq's nat subtraction means i - 1 is 0 when i = 0
            cond1 = (((i + 1) % 3 == 1) and (out_char == get_char(input, i + 2)))
            cond2 = ((((i + 1) % 3 == 2) or ((i + 1) % 3 == 0)) and (out_char == get_char(input, nat_sub(i, 1))))
            
            if not (cond1 or cond2):
                return False
        else:
            if out_char != get_char(input, i):
                return False

    return True
