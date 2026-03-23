class result:
    pass

class Binary(result):
    def __init__(self, s: str):
        self.s = s
        
    def __eq__(self, other):
        if isinstance(other, Binary):
            return self.s == other.s
        return False

class NegativeOne(result):
    def __eq__(self, other):
        return isinstance(other, NegativeOne)

def to_binary_p(p: int) -> str:
    if p == 1:
        return "1"
    elif p % 2 == 0:
        return to_binary_p(p // 2) + "0"
    else:
        return to_binary_p(p // 2) + "1"

def to_binary(n: int) -> str:
    if n == 0:
        return "0b0"
    elif n > 0:
        return "0b" + to_binary_p(n)
    else:
        return "Error: Negative numbers not supported"

def rounded_avg_impl(n: int, m: int) -> result:
    if n > m:
        return NegativeOne()
    else:
        return Binary(to_binary((n + m) // 2))

def problem_103_pre(n: int, m: int) -> bool:
    return n > 0 and m > 0

def problem_103_spec(n: int, m: int, output: result) -> bool:
    return output == rounded_avg_impl(n, m)
