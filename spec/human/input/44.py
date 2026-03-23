def nat_of_digit(c: str) -> int:
    val = ord(c) - ord('0')
    # In Coq, subtraction on nat truncates at 0
    return val if val >= 0 else 0

def problem_44_pre(x: int, base: int) -> bool:
    return base >= 2 and base < 10

def problem_44_spec(x: int, base: int, output) -> bool:
    digits = [nat_of_digit(c) for c in output]
    
    # Condition 1: all digits must be less than base
    if not all(d < base for d in digits):
        return False
        
    # Condition 2: evaluate the digits in the given base (Horner's method)
    acc = 0
    for d in digits:
        acc = acc * base + d
        
    return acc == x
