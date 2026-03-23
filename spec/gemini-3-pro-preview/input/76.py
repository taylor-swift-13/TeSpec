def _orig_is_simple_power_spec(x: int, n: int, output: bool) -> bool:

    def check(x: int, n: int) -> bool:
        if n == 0:
            return x == 1 or x == 0
        if n == 1:
            return x == 1
        if n == -1:
            return x == 1 or x == -1
        if x == 1:
            return True
        if x == 0:
            return False
        an = abs(n)
        ax = abs(x)
        if ax < an:
            return False
        low = 1
        high = ax.bit_length()
        while low <= high:
            mid = (low + high) // 2
            p = an ** mid
            if p == ax:
                return x == n ** mid
            elif p < ax:
                low = mid + 1
            else:
                high = mid - 1
        return False
    return check(x, n) == output

def is_simple_power_spec(x, n, output):
    return bool(_orig_is_simple_power_spec(x, n, output))
