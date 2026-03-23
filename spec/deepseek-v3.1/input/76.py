def is_simple_power_spec(x: int, n: int, result: bool) -> bool:
    def check(x: int, n: int) -> bool:
        # In Coq's Z.pow, 0^0 = 1 and 0^k = 0 for k > 0.
        if n == 0:
            return x == 0 or x == 1
        # 1^k = 1 for all k >= 0.
        if n == 1:
            return x == 1
        # (-1)^k is 1 if k is even, -1 if k is odd (for k >= 0).
        if n == -1:
            return x == 1 or x == -1
        # For |n| >= 2, n^k is never 0 for any k >= 0.
        if x == 0:
            return False
        
        # For |n| >= 2, |n^k| is strictly increasing for k >= 0.
        # We check n^0, n^1, n^2, ... until |n^k| > |x|.
        v = 1
        while abs(v) <= abs(x):
            if v == x:
                return True
            v *= n
        return False

    return result == check(x, n)
