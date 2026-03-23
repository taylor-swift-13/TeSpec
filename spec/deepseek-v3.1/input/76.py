def _orig_is_simple_power_spec(x: int, n: int, output: bool) -> bool:

    def check(x: int, n: int) -> bool:
        if n == 0:
            return x == 0 or x == 1
        if n == 1:
            return x == 1
        if n == -1:
            return x == 1 or x == -1
        if x == 0:
            return False
        v = 1
        while abs(v) <= abs(x):
            if v == x:
                return True
            v *= n
        return False
    return output == check(x, n)

def is_simple_power_spec(x, n, output):
    return bool(_orig_is_simple_power_spec(x, n, output))
