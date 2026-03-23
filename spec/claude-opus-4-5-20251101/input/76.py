def is_simple_power_spec(x: int, n: int, result: bool) -> bool:
    def is_simple_power(x_val: int, n_val: int) -> bool:
        # Case 1: x = 1.
        # In Coq, n^0 = 1 for any integer n (including 0).
        # So if x=1, there exists k=0 such that n^k = x.
        if x_val == 1:
            return True

        # Case 2: x = 0.
        # We need n^k = 0 for some k.
        # If n = 0, then 0^k = 0 for k >= 1. So True.
        # If n != 0, then n^k != 0 for any k. So False.
        if x_val == 0:
            return n_val == 0

        # Case 3: n = 0.
        # Powers of 0 are 0^0=1 and 0^k=0 for k>=1.
        # Since x != 1 and x != 0 (handled above), result is False.
        if n_val == 0:
            return False

        # Case 4: n = 1.
        # Powers of 1 are 1^k=1.
        # Since x != 1 (handled above), result is False.
        if n_val == 1:
            return False

        # Case 5: n = -1.
        # Powers of -1 are 1 and -1.
        # Since x != 1 (handled above), result is True iff x == -1.
        if n_val == -1:
            return x_val == -1

        # Case 6: |n| >= 2.
        # We check powers n^k for k >= 1.
        # Since |n| >= 2, |n^k| grows strictly.
        # We stop when |n^k| >= |x|.
        val = 1
        while abs(val) < abs(x_val):
            val *= n_val
        return val == x_val

    return result == is_simple_power(x, n)
