import math

def problem_13_pre(a: int, b: int) -> bool:
    return a != 0 or b != 0

def problem_13_spec(a: int, b: int, output: int) -> bool:
    # Based on the latest feedback, the Coq spec behaves as a Greatest Common Divisor check
    # (checking 'a mod output = 0' etc.), despite the text in the prompt suggesting otherwise.
    return output == math.gcd(a, b)
