def _orig_is_simple_power_spec(x: int, n: int, output: bool) -> bool:

    def is_simple_power(x_val: int, n_val: int) -> bool:
        if x_val == 1:
            return True
        if x_val == 0:
            return n_val == 0
        if n_val == 0:
            return False
        if n_val == 1:
            return False
        if n_val == -1:
            return x_val == -1
        val = 1
        while abs(val) < abs(x_val):
            val *= n_val
        return val == x_val
    return output == is_simple_power(x, n)

def is_simple_power_spec(x, n, output):
    return bool(_orig_is_simple_power_spec(x, n, output))
